//
//  PGSKServiceSelector.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PGSKServiceInfo.h"
#import "PGImageView.h"
#import "PGShareKitDefines.h"

@protocol PGSKServiceSelector<PGSingleLineImageView>
@property(copy) void(^cancelBlock)(id<PGSKServiceSelector> sender);
- (void)show;
- (void)dismiss;
@end


//@protocol PGSKServiceSelectorDelegate <NSObject>
//- (void)selectorDidCancel:(id<PGSKServiceSelector>)selector;
//- (void)selector:(id<PGSKServiceSelector>)selector didSelectIndex:(NSUInteger)index;
//@end






