//
//  PGSKConfig.m
//  PGShareKit
//
//  Created by linjinxing on 17/1/7.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "PGSKConfig.h"
#import "PGSKServiceInfo.h"
#import "PGSKShareData.h"
#import "NSObject+Init.h"
#import "PGSKMacro.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

PGSKDictionaryKey PGSKConfigDictionaryKeyDefault = @"default";

PGSKDictionaryKey PGSKConfigDictionaryKeyServices     = @"services";

PGSKDictionaryKey PGSKConfigDictionaryKeyCameraOrder     = @"cameraOrder";
PGSKDictionaryKey PGSKConfigDictionaryKeySNSOrder     = @"SNSOrder";

PGSKDictionaryKey PGSKConfigDictionaryKeySlogan = @"slogan";
PGSKDictionaryKey PGSKConfigDictionaryKeyID = @"ID";
PGSKDictionaryKey PGSKConfigDictionaryAppKey = @"appKey";
PGSKDictionaryKey PGSKConfigDictionaryImage = @"sloganImageName";
PGSKDictionaryKey PGSKConfigDictionaryKeySupportedShareType = @"supportedShareTypes";
PGSKDictionaryKey PGSKConfigDictionaryKeyCopyWritingTemplate = @"copyWritingTemplate";

PGSKStringConst PGSKConfigBundleName = @"PGL-ShareKit.bundle";
//PGSKDictionaryKey PGSKConfigDictionaryKeyLanguage    = @"zh";
//PGSKDictionaryKey PGSKConfigDictionaryKeyDescription = @"Description";

//static id PGSKServiceTransformBlock(NSString *keypath, id value);

NSDictionary* PGSKConfigLoad(){
    static dispatch_once_t onceToken;
    static NSDictionary* dict = nil;
    dispatch_once(&onceToken, ^{
        NSError* error;
        NSString* path = [[NSBundle mainBundle]
                          pathForResource:[PGSKConfigBundleName stringByAppendingPathComponent:@"PGSKConfig.json"]
                          ofType:nil];
        NSData* data = [NSData dataWithContentsOfFile:path
                                              options:NSDataReadingMappedIfSafe
                                                error:&error];
        if (error) {
            NSLog(@"error:%@", error);
        }else{
            dict = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingAllowFragments
                                                     error:&error];
            if (error) {
                NSLog(@"error:%@", error);
            }
            PGSKAssertNilAndClass(dict, NSDictionary)
        }
    });
    return dict;
}

//
//void PGSKLoadConfigAsyn(NSDictionary* param, PGSKSuccessBlock success, PGSKFailBlock fail){
//    
//}




