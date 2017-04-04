//
//  PGSKShareData.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKShareData.h"
#import "PGSKTypes.h"


@interface PGSKShareDataTextPOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* desc;
@end

@implementation PGSKShareDataTextPOD

@end

@interface PGSKShareDataImagePOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* desc;
@property(nonatomic) UIImage* image;
@property(nonatomic) UIImage* thumbnail;
@end

@implementation PGSKShareDataImagePOD
+ (instancetype)PODWithTitle:(NSString*)title
                                      desc:(NSString*)desc
                                     image:(UIImage*)image
                             thubnailImage:(UIImage*)thubnailImage{
    PGSKShareDataImagePOD* pod = [[self alloc] init];
    pod.title = title;
    pod.desc = desc;
    pod.image = image;
    pod.thumbnail = thubnailImage;
    return pod;
}
@end


@interface PGSKShareDataVideoPOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* desc;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailURL;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKShareDataVideoPOD

@end

@interface PGSKShareDataWebPagePOD()
@property(nonatomic) PGSKServiceWebPageDataContentType type;
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* desc;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailURL;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKShareDataWebPagePOD
+ (instancetype)PODWithTitle:(NSString*)title
                                      desc:(NSString*)desc
                                      type:(PGSKServiceWebPageDataContentType)type
                                       URL:(NSURL*)webPageURL
                                  thubnail:(UIImage*)thubnailImage
                              thumbnailURL:(NSURL*)thumbnailURL{
    PGSKShareDataWebPagePOD* pod = [[self alloc] init];
    pod.title = title;
    pod.desc = desc;
    pod.type = type;
    pod.url = webPageURL;
    pod.thumbnail = thubnailImage;
    pod.thumbnailURL = thumbnailURL;
    return pod;
}
@end





//id PGShareKitCreateData(PGSKServiceSupportedDataType type, NSDictionary* initDict){
//    return [@{@(PGSKServiceSupportedDataTypeImage):[PGSKShareDataImagePOD class],
//              @(PGSKServiceSupportedDataTypeVideo):[PGSKShareDataVideoPOD class],
//              @(PGSKServiceSupportedDataTypeWebPage):[PGSKShareDataWebPagePOD class]
//              }
//            objectForKey:@(type)];
//}


