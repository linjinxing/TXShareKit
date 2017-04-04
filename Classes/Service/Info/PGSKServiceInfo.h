//
//  PGSKServiceInfo.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKShareData.h"
#import "PGSKTypes.h"

/* 各平台的ID定义 */
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDWechat ;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDWechatMoments;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDQQ ;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDWeiBo ;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDQQZone;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDInstagram ;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDTwitter;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDFacebook;


/* 支持分享的数据类型 */
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDSupportedTypeImage   ;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDSupportedTypeWebpage ;
FOUNDATION_EXPORT PGSKStringConst kPKSGServiceIDSupportedTypeVideo   ;


/**
 各社交平台属性定义
 */
@protocol PGSKServiceInfo <NSObject>
@property(nonatomic, readonly, strong) NSString* ID;
@property(nonatomic, readonly, strong) NSString* name;
@property(nonatomic, readonly, strong) NSString* appKey;
@property(nonatomic, readonly, strong) NSString* appSecret;
@property(nonatomic, readonly, strong) NSString* redirectURL;
@property(nonatomic, readonly, strong) NSString* sloganImageName;
@property(nonatomic, readonly, assign) PGSKServiceSupportedDataType supportedShareTypes;
@end




@interface PGSKServiceInfoPOD : NSObject<PGSKServiceInfo>
@end


/**
 加载相机的分享平台顺序
 
 @return 返回平台配置信息
 */
NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadCamera();
/**
 加载社区分享平台顺序

 @return <#return value description#>
 */
NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadSNS();



/**
 根据社交平台服务的ID获取应用程序的AppKey
 
 @param ID 社交平台服务的ID
 @return 应用程序的AppKey
 */
NSString* PGSKConfigGetServiceAppKey(NSString*ID);


/**
 根据社交平台服务的ID获取应用程序的图标
 
 @param ID 社交平台服务的ID
 @return 应用程序的图标
 */
UIImage* PGSKServiceGetImage(NSString*ID);
//id<PGSKServiceInfo> PGSKServiceInfoLoadWithKey(NSString*key);


/**
 根据社交平台服务的ID获取某个服务配置
 
 @param ID 社交平台服务的ID
 @return 某个服务配置
 */
NSDictionary* PGSKConfigGetService(NSString*ID);



