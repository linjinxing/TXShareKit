//
//  PGSKServiceQQZone.m
//  PGShareKit
//
//  Created by linjinxing on 17/2/4.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "PGSKServiceQQZone.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>

@implementation PGSKServiceQQZone
- (void)shareImage:(id<PGSKShareDataImage>)image{
    [self sendRequest:[QQApiImageArrayForQZoneObject objectWithimageDataArray:@[UIImageJPEGRepresentation(image.image, 0.9)]
                                                                        title:image.title]];
}
- (void)sendRequest:(QQApiObject *)message{
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:message];
    [QQApiInterface SendReqToQZone:req];
}
@end
