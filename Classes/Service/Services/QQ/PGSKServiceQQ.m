//
//  PGSKServiceQQ.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceQQ.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "PGSKServiceInfo.h"
#import "PGSKConfig.h"
#import "PGShareKitError.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

static TencentOAuth* s_auth;
@interface PGSKServiceQQ()<QQApiInterfaceDelegate>
//@property (nonatomic) BOOL inited;
@end

@implementation PGSKServiceQQ
@synthesize success, cancel, fail;

+ (void)initialize{
    s_auth = [[TencentOAuth alloc] initWithAppId:PGSKConfigGetServiceAppKey(kPKSGServiceIDQQ)
                                     andDelegate:nil];
}

//- (instancetype)init{
//    self = [super init];
//    if (!self) {
//        return nil;
//    }
//    return self;
//}
//
//+ (BOOL)isInstalled{
//    return ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]);
//}

- (void)handleResponse{
    __block PGSKServiceQQ* qq = self;
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:PGSKApplicationLaunchNotification object:nil]
      takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification* noti) {
         //         StrongSelf
         [QQApiInterface handleOpenURL:noti.userInfo[UIApplicationLaunchOptionsURLKey] delegate:qq];
         qq = nil;
     }];
}

- (void)sendRequest:(QQApiObject *)message{
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:message];
    [QQApiInterface sendReq:req];
}

- (void)shareImage:(id<PGSKShareDataImage>)image{
    [self sendRequest:[QQApiImageObject objectWithData:UIImageJPEGRepresentation(image.image, 0.9)
                                      previewImageData:UIImageJPEGRepresentation(image.thumbnail, 0.8)
                                                 title:image.title
                                           description:image.desc]];
    [self handleResponse];
}

//- (void)shareVideo:(id<PGSKShareDataVideo>)video{
//    
//}

- (void)shareWebPage:(id<PGSKShareDataWebPage>)webpage{
    [self sendRequest:[QQApiNewsObject objectWithURL:webpage.url
                                               title:webpage.title
                                         description:webpage.desc
                                    previewImageData:UIImageJPEGRepresentation(webpage.thumbnail, 0.8)]];
    [self handleResponse];
}

+ (BOOL) canShare{
    return ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]);
}

#pragma mark - delegate

/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req{}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp{
    if (resp.errorDescription == nil)
    {
        if (self.success) self.success(@{});
    }
    else
    {
        if (![[resp errorDescription] isEqualToString:@"the user give up the current operation"]) //傻逼SDK，不给错误🐴
        {
            if (self.fail) self.fail([NSError errorWithDomain:PGShareKitErrorDomain
                                                         code:PGSKErrorCodeUnknown
                                                     userInfo:@{NSLocalizedDescriptionKey:resp.errorDescription}]);
        }
        else
        {
            if (self.cancel) self.cancel(self);
        }
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{}
@end



