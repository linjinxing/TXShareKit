//
//  PGSKShareData.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//  分享的数据

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PGSKTypes.h"

@protocol PGSKShareDataBase<NSObject>
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* desc;
@end

//@protocol PGSKShareDataThumbnail<NSObject>
//@property(nonatomic, readonly) UIImage* thumbnail;
//@end

@protocol PGSKShareDataText <PGSKShareDataBase>
@end


@protocol PGSKShareDataImage <PGSKShareDataBase>
@property(nonatomic, readonly) UIImage* image;
@property(nonatomic, readonly) UIImage* thumbnail;
@end

//@protocol PGSKShareDataMultiImages <PGSKShareDataText>
//@property(nonatomic, readonly) NSArray<UIImage*>* image;
//@property(nonatomic, readonly) NSArray<NSURL*>* urls;
//@end

@protocol PGSKShareDataVideo <PGSKShareDataBase>
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* url; /* 视频位置 */
@end

@protocol PGSKShareDataWebPage <PGSKShareDataBase>
@property(nonatomic, readonly) PGSKServiceWebPageDataContentType type;
@property(nonatomic, readonly) NSURL* url;

/**
 以下二选一
 */
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* thumbnailURL;
@end


@interface PGSKShareDataTextPOD : NSObject<PGSKShareDataText>

@end

@interface PGSKShareDataImagePOD : NSObject<PGSKShareDataImage>
+ (instancetype)PODWithTitle:(NSString*)title
                                      desc:(NSString*)desc
                                     image:(UIImage*)image
                             thubnailImage:(UIImage*)thubnailImage;
@end

@interface PGSKShareDataVideoPOD : NSObject<PGSKShareDataVideo>

@end

@interface PGSKShareDataWebPagePOD : NSObject<PGSKShareDataWebPage>
+ (instancetype)PODWithTitle:(NSString*)title
                                      desc:(NSString*)desc
                                      type:(PGSKServiceWebPageDataContentType)type
                                       URL:(NSURL*)webPageURL
                                  thubnail:(UIImage*)thubnailImage
                              thumbnailURL:(NSURL*)thumbnailURL;
@end










