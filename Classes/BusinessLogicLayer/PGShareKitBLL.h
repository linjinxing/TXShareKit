//
//  PGShareKitBLL.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//  业务逻辑

#import <Foundation/Foundation.h>
#import "PGSKTypes.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PGShareKitDefines.h"


typedef void(^PGSKGetSharedDataSuccessBlock)(PGSKServiceSupportedDataType type, id data);

/**
 调用者需要实现的block

 @param supportedType 社交平台能支持的数据类型，调用者根据此类型构造参数，包括PGSKShareDataTextPOD，PGSKShareDataImagePOD，PGSKShareDataVideoPOD，PGSKShareDataWebPagePOD，PGSKShareDataComposerPOD
 @param success 调用者成功获取到了数据，调用此block将数据传给PGShareKit（有些需要上传视频到服务器，因此这里使用block，可以实现异步）
 @param fail 调用者获取数据失败了，调用此block将错误传给PGShareKit。
 */
typedef void (^PGShareKitBLLGetSharInfo)(PGSKServiceSupportedDataType supportedType, PGSKGetSharedDataSuccessBlock success, PGSKFailBlock fail);

/**
 加载配置->显示选择器->获取分享数据类型->分享数据
 
 @param getParamBlock 调用者需要实现这个block,根据type传数据
 @param success 成功回调
 @param fail 失败回调
 @example:
     PGShareKitBLLShare(^(PGSKServiceSupportedDataType suportedType,
                         PGSKGetSharedDataSuccessBlock success,
                         PGSKFailBlock fail) {
                             NSLog(@"suportedType:%@", @(suportedType));
                             
                             if (success) success(PGSKServiceSupportedDataTypeImage,
                                                 [PGSKShareDataImagePOD shareDataImagePODWithTitle:@"text"
                                                     desc:@"description aa"
                                                     image:[UIImage imageNamed:@"covor"]
                                                     thubnailImage:[UIImage imageNamed:@"covor"]]);
                         }, ^(id data) {
                             NSLog(@"data:%@", data);
                         }, ^(NSError *error) {
                             NSLog(@"error:%@", error);
     });
 */
//void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock, PGSKSuccessBlock success, PGSKFailBlock fail);
RACSignal* PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock);


