//
//  PGSKServiceFB.m
//  PGShareKit
//
//  Created by linjinxing on 17/2/5.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "PGSKServiceFB.h"
#import "PGSKServiceInfo.h"
#import "PGSKConfig.h"
#import "PGShareKitError.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PGSKServiceFB()<FBSDKSharingDelegate>

@end

@implementation PGSKServiceFB
@synthesize success, cancel, fail;

+ (void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

+ (void)appDidFinishLaunching:(NSNotification *)notification
{
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [FBSDKLikeControl class];
    [[FBSDKApplicationDelegate sharedInstance] application:notification.object didFinishLaunchingWithOptions:nil];
    //    });
}

+ (void)appDidBecomeActive:(NSNotification *)notification
{
    [FBSDKAppEvents activateApp];
}

+ (BOOL)canShare{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fbauth2:/"]];
}

- (void)handleResponse{
    __block PGSKServiceFB* fb = self;
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:PGSKApplicationLaunchNotification object:nil]
      takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification* noti) {
         //         StrongSelf
         [[FBSDKApplicationDelegate sharedInstance] application:noti.userInfo[PGSKApplicationLaunchOptionspAplicationKey]
                                                        openURL:noti.userInfo[UIApplicationLaunchOptionsURLKey]
                                              sourceApplication:noti.userInfo[UIApplicationLaunchOptionsSourceApplicationKey]
                                                     annotation:noti.userInfo[UIApplicationLaunchOptionsAnnotationKey]];
         fb = nil;
     }];
}


- (void)showDialogWithContent:(id<FBSDKSharingContent>) shareContent{
    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    dialog.mode = FBSDKShareDialogModeNative;
    dialog.shareContent = shareContent;
    [dialog show];
    dialog.delegate = self;
}

- (void)shareImage:(id<PGSKShareDataImage>)image{
    FBSDKSharePhoto *photo = [FBSDKSharePhoto photoWithImage:image.image userGenerated:YES];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    [self showDialogWithContent:content];
    [self handleResponse];
}
- (void)shareWebPage:(id<PGSKShareDataWebPage>)webpage{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = webpage.url;
    content.contentTitle = webpage.title;
    content.contentDescription = webpage.desc;
//    content.imageURL = webpage.thumbnail;
    [self showDialogWithContent:content];
    [self handleResponse];
}

- (void)shareVideo:(id<PGSKShareDataVideo>)videoData{
    FBSDKShareVideo *video = [FBSDKShareVideo videoWithVideoURL:videoData.url];
    FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
    content.video = video;
    [self showDialogWithContent:content];
    [self handleResponse];
}

#pragma mark - fackbook ssoShare delegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    if (self.success) self.success(@{});
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    if (self.fail) self.fail(error);
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    if (self.cancel) self.cancel(self);
}


@end





