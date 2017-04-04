//
//  PGSKTypes.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void(^PGSKVoidBlock)();
typedef NSString*(^PGSKStrBlockReturnStr)(NSString*);
typedef void(^PGSKDataBlock)(id data);
typedef id(^PGSKReturnDataBlock)();
typedef PGSKDataBlock PGSKSuccessBlock;
typedef void(^PGSKFailBlock)(NSError* error);

typedef void(^PGSKSelectBlock)(id sender, NSIndexPath* indexPath);
typedef void(^PGSKSenderBlock)(id sender);
typedef PGSKSenderBlock PGSKCancelBlock;

typedef NSString* const PGSKStringConst;
typedef PGSKStringConst PGSKDictionaryKey ;
typedef PGSKStringConst PGSKNotification ;

FOUNDATION_EXPORT PGSKStringConst  PGShareKitErrorDomain;

/* 第三方应用程序打开自己程序时发出，也即- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation函数被调用时 */
FOUNDATION_EXPORT PGSKNotification  PGSKApplicationLaunchNotification;

FOUNDATION_EXPORT PGSKDictionaryKey  PGSKApplicationLaunchOptionspAplicationKey;

/**
 支持的数据类型定义
 */
typedef NS_OPTIONS(NSUInteger, PGSKServiceSupportedDataType) {
    PGSKServiceSupportedDataTypeText        = 1 << 0,
    PGSKServiceSupportedDataTypeImage       = 1 << 1,
    PGSKServiceSupportedDataTypeMultiImages = 1 << 2,
    PGSKServiceSupportedDataTypeGif         = 1 << 3,
    PGSKServiceSupportedDataTypeVideo       = 1 << 4,
    PGSKServiceSupportedDataTypeWebPage     = 1 << 5,
    PGSKServiceSupportedDataTypeComposer    = 1 << 6, /* 内部使用 */
};


/**
 分享的网页内容类型，暂时不用
 */
typedef NS_OPTIONS(NSUInteger, PGSKServiceWebPageDataContentType) {
    PGSKServiceWebPageDataContentTypeNormal,
    PGSKServiceWebPageDataContentTypeImage,
    PGSKServiceWebPageDataContentTypeVideo
};


