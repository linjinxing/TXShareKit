//
//  PGSKServiceWechat.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceWechat.h"
#import <WXApi.h>
#import <WXApiObject.h>
#import "PGSKServiceInfo.h"
#import "PGSKConfig.h"
#import "PGShareKitError.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PGSKServiceWechat()<WXApiDelegate>

@end

@implementation PGSKServiceWechat
@synthesize success, cancel, fail;

+ (void)initialize{
    [WXApi registerApp:PGSKConfigGetServiceAppKey(kPKSGServiceIDWechat)];
}
//
//+ (BOOL)isInstalled{
//    return [WXApi isWXAppInstalled];
//}

+ (int)scene{
    return WXSceneSession;
}

- (void)sendRequestWithMediaObject:(id)mediaObject
                             title:(NSString*)title
                               des:(NSString*)des
                         thumbnail:(UIImage*)thumbnail
{
    WXMediaMessage *mediaMessage = [WXMediaMessage message];
    mediaMessage.title = title;
    mediaMessage.description = des;
    mediaMessage.thumbData = UIImageJPEGRepresentation(thumbnail, 0.8);
    mediaMessage.mediaObject = mediaObject;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.scene = [[self class] scene];
    req.message = mediaMessage;
    [WXApi sendReq:req];
}

- (void)handleResponse{
    __block PGSKServiceWechat* wx = self; //// 在通知发送完成后，释放自己。
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:PGSKApplicationLaunchNotification object:nil]
      takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification* noti) {
         [WXApi handleOpenURL:noti.userInfo[UIApplicationLaunchOptionsURLKey] delegate:wx];
         wx = nil;
     }];
}

- (void)shareImage:(id<PGSKShareDataImage>)image{
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImageJPEGRepresentation(image.image,0.9);
    
    [self sendRequestWithMediaObject:ext title:image.title des:image.desc thumbnail:image.thumbnail];
    [self handleResponse];
}

//- (void)shareVideo:(id<PGSKShareDataVideo>)video{
//
//}

- (void)shareWebPage:(id<PGSKShareDataWebPage>)webpage{
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = webpage.url.absoluteString;
    
    [self sendRequestWithMediaObject:ext title:webpage.title des:webpage.desc thumbnail:webpage.thumbnail];
    [self handleResponse];
}

+ (BOOL) canShare{
    return ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]);
}



- (void) onResp:(BaseResp*)resp{
    NSString *str = [NSString stringWithFormat:@"%d",resp.errCode];
    NSLog(@"%@", str);
    switch (resp.errCode) {
        case WXSuccess:
        {
            if (self.success) self.success(@{});
        }
        case WXErrCodeUserCancel:
        {
            if (self.cancel) self.cancel(self);
            break;
        }
        default:
        {
            if (self.fail) self.fail([NSError errorWithDomain:PGShareKitErrorDomain
                                                            code:resp.errCode
                                                        userInfo:@{NSLocalizedDescriptionKey:resp.errStr}]);
            break;
        }
    }
}

- (void) onReq:(BaseReq*)req{
    NSLog(@"req:%@", req);
}

@end
