//
//  NSObject+Init.h
//  PGShareKit
//
//  Created by linjinxing on 17/1/10.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^PGSKTransformValueBlock)(NSString* keypath, id value);

@interface NSObject (Init)
+ (instancetype)instanceWithDictionary:(NSDictionary*)dict;

+ (instancetype)instanceWithDictionary:(NSDictionary*)dict
                             transform:(PGSKTransformValueBlock)transform;
@end


