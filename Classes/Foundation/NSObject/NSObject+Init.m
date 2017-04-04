//
//  NSObject+Init.m
//  PGShareKit
//
//  Created by linjinxing on 17/1/10.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "NSObject+Init.h"
#import <objc/runtime.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

static const char * property_getTypeString( objc_property_t property )
{
    const char * attrs = property_getAttributes( property );
    if ( attrs == NULL )
        return ( NULL );
    
    static char buffer[256];
    const char * e = strchr( attrs, ',' );
    if ( e == NULL )
        return ( NULL );
    
    int len = (int)(e - attrs);
    memcpy( buffer, attrs, len );
    buffer[len] = '\0';
    
    return ( buffer );
}

@implementation NSObject (Init)
+ (NSDictionary*)propeties
{
    unsigned int propertyCount = 0, i = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    NSMutableDictionary* retProperties = [NSMutableDictionary dictionaryWithCapacity:propertyCount];
    for(i = 0; i < propertyCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if ([propertyName length]) {
            retProperties[propertyName] = [NSString stringWithUTF8String:property_getTypeString(property)];
        }
    }
    
    free(properties);
    return [retProperties copy];
}

+ (NSDictionary*)allPropeties
{
    static NSMutableDictionary* s_caches ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_caches = [NSMutableDictionary dictionaryWithCapacity:100];
    });
    NSDictionary* cacheResults = [s_caches valueForKey:NSStringFromClass(self)];
    if (nil != cacheResults) {
        return cacheResults;
    }
    NSMutableDictionary* results = [[self propeties] mutableCopy];
    Class cls = [self superclass];
    while (cls != [NSObject class]) {
        [results addEntriesFromDictionary:[cls propeties]];
        cls = [self superclass];
    }
    NSDictionary* dict = [results copy];
    s_caches[NSStringFromClass(self)] = dict;
    return dict;
}

+ (instancetype)instanceWithDictionary:(NSDictionary*)dict{
    return [self instanceWithDictionary:dict transform:nil];
}

+ (instancetype)instanceWithDictionary:(NSDictionary*)dict
                             transform:(PGSKTransformValueBlock)transform{
    NSObject* instance = [[self alloc] init];
    NSDictionary* allPropeties = [self allPropeties];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        void(^setKeyValue)() = ^{
            if ([allPropeties objectForKey:key]) {
                [instance setValue:obj forKey:key];
            }else{
                NSLog(@"%@类没有%@属性, %@", NSStringFromClass(self), key, @(__LINE__));
            }
        };
        if (transform) {
            id value = transform(key, obj);
            if (value) {
                [instance setValue:value forKey:key];
            }else{
                setKeyValue();
//                NSLog(@"%@类%@属性transform后值%@为空, %@", NSStringFromClass(self), key, value, @(__LINE__));
            }
        }else{
            setKeyValue();
        }
//        @try {
//            [instance setValue:obj forKey:key];
//        } @catch (NSException *exception) {
//            if (transform) {
//                id value = transform(key, obj);
//                if (value) {
//                    @try {
//                        [instance setValue:value forKey:key];
//                    } @catch (NSException *exception) {
//                        NSLog(@"exception:%@, %@", exception, @(__LINE__));
//                    }
//                }
//            }else{
//                NSLog(@"exception:%@, %@", exception, @(__LINE__));
//            }
//        }
    }];
    return instance;
}

@end
