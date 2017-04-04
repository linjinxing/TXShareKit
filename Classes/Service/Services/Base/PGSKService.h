//
//  PGSKServiceInfo.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKShareData.h"
#import "PGSKServiceInfo.h"
#import "PGSKShareDataComposerPOD+private.h"

@protocol PGSKServiceDelegate;


@protocol PGSKService<NSObject>
@property(copy) PGSKSuccessBlock success;
@property(copy) PGSKCancelBlock cancel;
@property(copy) PGSKFailBlock fail;
//@property(nonatomic, readonly) BOOL isInitDone;
+ (BOOL) canShare;
@optional
//- (void)shareText:(id<PGSKShareDataText>)text;
- (void)shareImage:(id<PGSKShareDataImage>)image;
- (void)shareWebPage:(id<PGSKShareDataWebPage>)webpage;
- (void)shareVideo:(id<PGSKShareDataVideo>)video;
- (void)shareComposer:(id<PGSKShareDataComposer>)composer;
//- (void)shareMultiImages:(id<PGSKShareDataMultiImages>)images;
@end

//@protocol PGSKServiceDelegate <NSObject>
//- (void)service:(id<PGSKService>)service didCompleteWithResults:(NSDictionary *)results;
//- (void)service:(id<PGSKService>)service didFailWithError:(NSError *)error;
//- (void)service:(id<PGSKService>)service didReceiveRequest:(id)param;
//- (void)serviceDidLogined:(id<PGSKService>)service;
//- (void)serviceWillShare:(id<PGSKService>)service;
//- (void)serviceDidInitDone:(id<PGSKService>)service;
//@end


/**
 创建社交平台服务类实例

 @param serviceInfo <#serviceInfo description#>
 @return <#return value description#>
 */
NSObject<PGSKService>* PGShareKitCreateServiceFactory(id<PGSKServiceInfo> serviceInfo);

/**
 检查某个社交平台类是否能够分享

 @param serviceInfo <#serviceInfo description#>
 @return <#return value description#>
 */
BOOL PGShareKitServiceCanShare(id<PGSKServiceInfo> serviceInfo);

/**
 获取某个社交平台支持的数据类型

 @param type <#type description#>
 @return <#return value description#>
 */
SEL PGShareKitGetServiceSelector(PGSKServiceSupportedDataType type);

//void PGShareKitHandleResponse(id<PGSKService> service);




