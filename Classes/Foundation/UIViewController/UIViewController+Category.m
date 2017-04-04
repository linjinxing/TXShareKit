//
//  UIViewController+Category.m
//  PGShareKit
//
//  Created by linjinxing on 17/2/5.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

@end


UIViewController* TXUIGetTopmostViewController(){
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (true)
    {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)topViewController;
            topViewController = nav.topViewController;
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}
