//
//  PGSKServiceSelectorController.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PGSKServiceInfo.h"
#import "PGSKServiceDefaultSelectorView.h"
#import "PGSKTypes.h"
#import "PGShareKitDefines.h"
#import "PGSKServiceSelectorItemPOD.h"

typedef void(^PGSKSelectServiceBlock)(PGSKServiceSelectorItemPOD*serviceItem);


@interface PGSKServiceSelectorController : NSObject
+ (instancetype)controllerWithselectorView:(id<PGSKServiceSelector>) selectorView
                                   service:(NSArray<PGSKServiceSelectorItemPOD*>*)services;
- (void)showWithSelectBlock:(PGSKSelectServiceBlock)select
                cancelBlock:(PGSKCancelBlock)cancel;
@end




