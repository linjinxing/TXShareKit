//
//  PGSKConfig.h
//  PGShareKit
//
//  Created by linjinxing on 17/1/7.
//  Copyright © 2017年 linjinxing. All rights reserved.
//  配置

#import <Foundation/Foundation.h>
#import "PGSKServiceInfo.h"
#import "PGSKTypes.h"
#import "PGShareKitDefines.h"

FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryKeyDefault;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryKeyServices;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryKeySlogan;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryKeyID;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryKeyCameraOrder;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryKeySupportedShareType;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryAppKey;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryKeySNSOrder;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryKeyCopyWritingTemplate;
FOUNDATION_EXPORT PGSKDictionaryKey PGSKConfigDictionaryImage;
FOUNDATION_EXPORT PGSKStringConst PGSKConfigBundleName;

/**
 加载配置

 @return <#return value description#>
 */
NSDictionary* PGSKConfigLoad();

///**
// 异步加载
//
// @param param <#param description#>
// @param success <#success description#>
// @param fail <#fail description#>
// */
//void PGSKLoadConfigAsyn(NSDictionary* param, PGSKSuccessBlock success, PGSKFailBlock fail);


