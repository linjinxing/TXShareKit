//
//  PGSKShareData+private.h
//  PGShareKit
//
//  Created by linjinxing on 17/2/5.
//  Copyright © 2017年 linjinxing. All rights reserved.
//  不暴露给外界

#import <Foundation/Foundation.h>
#import "PGSKShareData.h"

/**
 像新浪，twitter这样，需要编辑的数据
 */
@protocol PGSKShareDataComposer <NSObject>
@property(nonatomic, readonly) NSString* content;
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* url;
@property(nonatomic, readonly) NSArray<NSString*>* tags;
@end


@interface PGSKShareDataComposerPOD : NSObject<PGSKShareDataComposer>
+ (instancetype)shareDataPODWithContent:(NSString*)content
                                         url:(NSURL*)url
                               thubnailImage:(UIImage*)thubnailImage;
@end
