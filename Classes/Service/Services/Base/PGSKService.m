//
//  PGSKServiceInfo.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKService.h"
#import "PGSKServiceQQ.h"
#import "PGSKServiceQQZone.h"
#import "PGSKServiceWechat.h"
#import "PGSKServiceWechatTimeLine.h"
#import "PGSKServiceSinaWeibo.h"
#import "PGSKServiceTwitter.h"
#import "PGSKServiceFB.h"
#import "PGSKConfig.h"
#import "NSObject+Init.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

static Class PGShareKitClassForKey(NSString* key){
    return [@{kPKSGServiceIDWechat:[PGSKServiceWechat class],
              kPKSGServiceIDWechatMoments:[PGSKServiceWechatTimeLine class],
              kPKSGServiceIDQQ:[PGSKServiceQQ class],
              kPKSGServiceIDQQZone:[PGSKServiceQQZone class],
              kPKSGServiceIDWeiBo:[PGSKServiceSinaWeibo class],
              kPKSGServiceIDTwitter:[PGSKServiceTwitter class],
              kPKSGServiceIDFacebook:[PGSKServiceFB class],
              }
            valueForKey:key];
}

NSObject<PGSKService>* PGShareKitCreateServiceFactory(id<PGSKServiceInfo> serviceInfo){
    return [[PGShareKitClassForKey(serviceInfo.ID) alloc] init];
}

BOOL PGShareKitServiceCanShare(id<PGSKServiceInfo> serviceInfo){
    return [PGShareKitClassForKey(serviceInfo.ID) canShare];
}


SEL PGShareKitGetServiceSelector(PGSKServiceSupportedDataType type){
    NSString* selector = [@{@(PGSKServiceSupportedDataTypeVideo):NSStringFromSelector(@selector(shareVideo:)),
                            @(PGSKServiceSupportedDataTypeImage):NSStringFromSelector(@selector(shareImage:)),
                            @(PGSKServiceSupportedDataTypeWebPage):NSStringFromSelector(@selector(shareWebPage:)),
                            @(PGSKServiceSupportedDataTypeComposer):NSStringFromSelector(@selector(shareComposer:))
                            }
                          objectForKey:@(type)];
    return NSSelectorFromString(selector);
}




//void PGShareKitHandleResponse(id<PGSKService> service){
//    
//}
//
//
//
