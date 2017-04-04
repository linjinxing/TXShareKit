//
//  PGSKServiceSinaTwitter.m
//  PGShareKit
//
//  Created by linjinxing on 17/2/5.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import <Social/Social.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

#import "PGSKServiceTwitter.h"
#import "PGSKServiceInfo.h"
#import "PGSKConfig.h"
#import "PGShareKitError.h"
#import "UIViewController+Category.h"

@implementation PGSKServiceTwitter
@synthesize success, cancel, fail;

+ (BOOL) canShare{
    return YES;
}

- (void)shareComposer:(id<PGSKShareDataComposer>)composer
{
    SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    WeakSelf
    socialVC.completionHandler = ^(SLComposeViewControllerResult result) {
        StrongSelf
        if (result == SLComposeViewControllerResultCancelled) {
            if (self.cancel) self.cancel(self);
        }
        else
        {
            if (self.success) self.success(@{});
        }
    };
    [socialVC addImage:composer.thumbnail];
    [socialVC setInitialText:composer.content];
    [TXUIGetTopmostViewController() presentViewController:socialVC animated:YES completion:nil];
}

@end
