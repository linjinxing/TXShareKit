//
//  PGSKServiceInfo.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/31.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceInfo.h"
#import "PGSKConfig.h"
//#import "NSArray+BlocksKit.h"
#import "NSObject+Init.h"
#import "PGSKMacro.h"
#import <HDevice/HSystem.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

/* 以下值要和配置里的对应，否则会出错 */
PGSKStringConst kPKSGServiceIDWechat = @"wechat";
PGSKStringConst kPKSGServiceIDWechatMoments = @"wechatMoments";
PGSKStringConst kPKSGServiceIDQQ = @"qq";
PGSKStringConst kPKSGServiceIDWeiBo = @"sina";
PGSKStringConst kPKSGServiceIDQQZone = @"qqzone";
PGSKStringConst kPKSGServiceIDTwitter = @"twitter";
PGSKStringConst kPKSGServiceIDInstagram = @"instagram";
PGSKStringConst kPKSGServiceIDFacebook = @"facebook";

PGSKStringConst kPKSGServiceIDSupportedTypeImage = @"image";
PGSKStringConst kPKSGServiceIDSupportedTypeWebpage = @"webpage";
PGSKStringConst kPKSGServiceIDSupportedTypeVideo = @"video";


@interface PGSKServiceInfoPOD()// : NSObject<PGSKServiceInfo>
//@property(nonatomic, strong) NSString* name;
//@property(nonatomic, strong) NSString* key;
//@property(nonatomic, strong) NSString* appKey;
//@property(nonatomic, strong) NSString* appSecret;
//@property(nonatomic, strong) NSString* redirectURL;
//@property(nonatomic, strong) NSString* sloganImageName;
//@property(nonatomic, assign) PGSKServiceSupportedDataType supportedShareTypes;
//+ (instancetype)serviceInfoPODWithDictionary:(NSDictionary*)dict;
@end


@implementation PGSKServiceInfoPOD
@synthesize ID, name, appKey, appSecret, redirectURL, sloganImageName, supportedShareTypes;
//+ (instancetype)serviceInfoPODWithDictionary:(NSDictionary*)dict{
//    assert(dict);
//    return [PGSKServiceInfoPOD instanceWithDictionary:dict];
//}
@end




/**
 根据平台的ID获取相应平台服务的字典

 @param ID 平台的ID
 @return 平台服务的字典
 */
NSDictionary* PGSKConfigGetService(NSString*ID){
    PGSKAssertNilAndClass(ID, NSString)
    NSDictionary* dict = [PGSKConfigLoad() valueForKeyPath:[PGSKConfigDictionaryKeyServices stringByAppendingFormat:@".%@", ID]];
    PGSKAssertNilAndClass(dict, NSDictionary)
    return dict;
}

/**
 根据平台的ID，以及平台的属性key，获取相应平台服务key对应的值

 @param ID 平台的ID
 @param serverKey 平台的属性key
 @return 平台服务key对应的值
 */
NSString* PGSKConfigGetServiceInfo(NSString*ID, NSString* serverKey){
    PGSKAssertNilAndClass(ID, NSString)
    PGSKAssertNilAndClass(serverKey, NSString)
    NSString* value = PGSKConfigGetService(ID)[serverKey];
    //// 可以为空，twitter就没有sdk
    //    PGSKAssertNilAndClass(appKey, NSString)
    return value;
}

/**
 根据平台的ID获取相应平台服务的AppKey

 @param ID 平台的ID
 @return 平台服务的AppKey
 */
NSString* PGSKConfigGetServiceAppKey(NSString*ID){
    return PGSKConfigGetServiceInfo(ID, PGSKConfigDictionaryAppKey);
}

/**
 根据平台ID获取相应平台服务的图片

 @param ID 平台的ID
 @return 平台服务的图片
 */
UIImage* PGSKServiceGetImage(NSString*ID)
{
    return [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:[PGSKConfigBundleName stringByAppendingPathComponent:PGSKConfigGetServiceInfo(ID, PGSKConfigDictionaryImage)]
                                                               ofType:@"png"]];
}


/**
 配置里的字符串转换转换为枚举变量
 
 @return <#return value description#>
 */
static NSNumber* PGSKServiceSupportedDataTypeStringToNSNumber(NSArray* value){
    PGSKAssertNilAndClass(value, NSArray)
    return [value.rac_sequence foldLeftWithStart:@(0)
                                          reduce:^id(id accumulator, id value) {
                                              return @([accumulator integerValue] | [@{
                                                                                       kPKSGServiceIDSupportedTypeImage:@(PGSKServiceSupportedDataTypeImage),
                                                                                       kPKSGServiceIDSupportedTypeWebpage:@(PGSKServiceSupportedDataTypeWebPage),
                                                                                       kPKSGServiceIDSupportedTypeVideo:@(PGSKServiceSupportedDataTypeVideo)
                                                                                       }[value]
                                                                                     integerValue]);
                                          }];
    //    return @{
    //             kPKSGServiceIDSupportedTypeImage:@(PGSKServiceSupportedDataTypeImage),
    //             kPKSGServiceIDSupportedTypeWebpage:@(PGSKServiceSupportedDataTypeWebPage),
    //             kPKSGServiceIDSupportedTypeVideo:@(PGSKServiceSupportedDataTypeVideo)
    //             };
}

/**
 用字典初始化对象时，有些数据类型需要进行转化
 
 @param keypath 要解析json数据的路径
 @param value json路径对应的值
 @return 返回转换后的值
 */
static id PGSKServiceTransformBlock(NSString *keypath, id value){
    PGSKAssertNilAndClass(keypath, NSString)
    PGSKAssertNil(value)
    PGSKReturnDataBlock block = @{
                                  //             PGSKConfigDictionaryKeySlogan:^{
                                  //                 return [[[NSBundle mainBundle] pathForResource:PGSKConfigBundleName
                                  //                                                         ofType:nil]
                                  //                         stringByAppendingPathComponent:value];
                                  //             },
                                  PGSKConfigDictionaryKeySupportedShareType:^{
                                      return PGSKServiceSupportedDataTypeStringToNSNumber(value);
                                  },
                                  }[keypath];
    return block ? block() : nil;
}

static NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadDisplayOrder(NSString* order){
    NSDictionary* dict = PGSKConfigLoad();
    NSDictionary* dictServices = dict[PGSKConfigDictionaryKeyServices];
    PGSKAssertNilAndClass(dictServices, NSDictionary)
    PGSKAssertNilAndClass(dict[order], NSDictionary)
    PGSKStringConst zh = @"zh";
    NSDictionary* dictLocalOrder = dict[order][[[HSystem shareInstance].curLanguage hasPrefix:zh] ? zh : PGSKConfigDictionaryKeyDefault];
    return [[((NSArray*)dictLocalOrder).rac_sequence map:^id _Nonnull(id  _Nonnull serviceID) {
        NSMutableDictionary* tmpDict = [PGSKConfigGetService(serviceID) mutableCopy];
        tmpDict[PGSKConfigDictionaryKeyID] = serviceID;
        return [PGSKServiceInfoPOD instanceWithDictionary:tmpDict
                                                transform:^id(NSString *keypath, id value) {
                                                    return PGSKServiceTransformBlock(keypath, value);
                                                }];
        //        [tmpDict[PGSKConfigDictionaryKeySupportedShareType] bk_each:^(id  _Nonnull obj) {
        //            [pod setValue:PGSKServiceSupportedDataTypeStringToNSNumber(obj)
        //                   forKey:PGSKConfigDictionaryKeySupportedShareType];
        //        }];
        //        return pod;
    }] array];
}
/**
 加载相机的分享顺序
 
 @return <#return value description#>
 */
NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadCamera(){
    return PGSKServiceInfoLoadDisplayOrder(PGSKConfigDictionaryKeyCameraOrder);
}

NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadSNS(){
    return PGSKServiceInfoLoadDisplayOrder(PGSKConfigDictionaryKeySNSOrder);
}



