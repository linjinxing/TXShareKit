//
//  PGSKShareData+private.m
//  PGShareKit
//
//  Created by linjinxing on 17/2/5.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "PGSKShareDataComposerPOD+private.h"




@interface PGSKShareDataComposerPOD()
@property(nonatomic) NSString* content;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* url;
@property(nonatomic) NSArray<NSString*>* tags;
@end

@implementation PGSKShareDataComposerPOD
+ (instancetype)shareDataPODWithContent:(NSString*)content
                                    url:(NSURL*)url
                          thubnailImage:(UIImage*)thubnailImage
{
    PGSKShareDataComposerPOD* pod = [[self alloc] init];
    pod.content = content;
    pod.url = url;
    pod.thumbnail = thubnailImage;
    return pod;
}
@end


