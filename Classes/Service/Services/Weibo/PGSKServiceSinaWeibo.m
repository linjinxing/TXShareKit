//
//  PGSKServiceSinaWeibo.m
//  PGShareKit
//
//  Created by linjinxing on 17/1/7.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import <WeiboSDK.h>
#import "PGSKServiceSinaWeibo.h"
#import "PGSKServiceInfo.h"
#import "PGSKConfig.h"
#import "PGShareKitError.h"
#import "PGSKShareDataComposerPOD+private.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PGSKServiceSinaWeibo()<WeiboSDKDelegate>
@end

@implementation PGSKServiceSinaWeibo
@synthesize success, cancel, fail;


+ (void)initialize{
    [WeiboSDK registerApp:PGSKConfigGetServiceAppKey(kPKSGServiceIDWeiBo)];
}

//- (void)sendRequestWithContent:(NSString*)content
//                         title:(NSString*)title
//                           des:(NSString*)des
//                         image:(UIImage*)image
//{
//    WBMessageObject *wbmessage = [WBMessageObject message];
//    
//    WBImageObject *wbimage = [WBImageObject object];
//    wbimage.imageData = UIImageJPEGRepresentation(image,0.9);
//    wbmessage.imageObject = wbimage;
//    wbmessage.text = content;
//    
//    [WBSendMessageToWeiboRequest requestWithMessage:wbmessage];
//}

- (void)handleResponse{
    __block PGSKServiceSinaWeibo* wb = self; //// 在通知发送完成后，释放自己。
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:PGSKApplicationLaunchNotification object:nil]
      takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification* noti) {
         [WeiboSDK handleOpenURL:noti.userInfo[UIApplicationLaunchOptionsURLKey] delegate:wb];
         wb = nil;
     }];
}

- (void)sendRequestWithText:(NSString*)text
                       image:(UIImage*)image
{
    WBMessageObject *wbmessage = [WBMessageObject message];
    WBImageObject *wbimage = [WBImageObject object];
    wbimage.imageData = UIImageJPEGRepresentation(image,0.9);
    wbmessage.imageObject = wbimage;
    wbmessage.text = text;
//    static WBSendMessageToWeiboRequest *request = nil;
    [WeiboSDK sendRequest:[WBSendMessageToWeiboRequest requestWithMessage:wbmessage]];

}

//- (void)shareImage:(id<PGSKShareDataImage>)image{
//    [self sendRequestWithText:[NSString stringWithFormat:@"%@ %@", image.title, image.desc]
//                        image:image.image];
//}

- (void)shareComposer:(id<PGSKShareDataComposer>)composer{
    [self sendRequestWithText:composer.content
                        image:composer.thumbnail];
    [self handleResponse];
}

//- (void)shareVideo:(id<PGSKShareDataVideo>)video{
//
//}

//- (void)shareWebPage:(id<PGSKShareDataWebPage>)webpage{
//    [self sendRequestWithText:[NSString stringWithFormat:@"%@ %@ %@", webpage.title, webpage.desc, webpage.url.absoluteString]
//                        image:webpage.thumbnail];
//}

+ (BOOL) canShare{
    return ([WeiboSDK isWeiboAppInstalled] && [WeiboSDK isCanShareInWeiboAPP]);
}

#pragma mark - WeiboSDKDelegate
/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 [WBBaseResponse userInfo] 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
        {
            if (self.success) self.success(@{});
            break;
        }
        case WeiboSDKResponseStatusCodeUserCancel:
        {
            if (self.cancel) self.cancel(self);
            break;
        }
        default:
        {
            if (self.fail) self.fail([NSError errorWithDomain:PGShareKitErrorDomain
                                                         code:response.statusCode
                                                     userInfo:@{NSLocalizedDescriptionKey:@""}]);
            break;
        }
    }
}


@end



