//
//  CopyWritingFormat.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//  文案处理

#import <Foundation/Foundation.h>
#import "PGSKTypes.h"
#import "PGShareKitDefines.h"

//typedef void(^PGSKConfigLoadCopyWritingSuccess)(NSString* title, NSString* message);
//
///**
// 加载文案配置
//
// @param param <#param description#>
// @param success <#success description#>
// @param fail <#fail description#>
// */
//void PGSKConfigLoadCopyWritingInfo(NSDictionary* param,
//                                   PGSKConfigLoadCopyWritingSuccess success,
//                                   PGSKFailBlock fail);


/**
 格式化方案

 @param title 标题
 @param desc 描述
 @param webpageURL 网页地址
 */

NSString* PGSKCopyWritingFormat(NSString* serviceID, NSString* title, NSString* desc, NSURL* webpageURL);





