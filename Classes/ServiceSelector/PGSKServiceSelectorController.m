//
//  PGSKServiceSelectorController.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceSelectorController.h"
#import "PGShareKitDefines.h"
#import "PGSKConfig.h"

@interface PGSKServiceSelectorController()
//@property(strong, readonly) NSArray<PGSKServiceInfo>* service;
//@property(strong, readonly) id<PGSKServiceSelector> selectorView;
@property(strong) NSArray<PGSKServiceSelectorItemPOD*>* services;
@property(strong) id<PGSKServiceSelector> selectorView;
@property(copy) PGSKSelectServiceBlock selectBlock;
@property(copy) PGSKCancelBlock cancelBlock;
@end

@implementation PGSKServiceSelectorController
+ (instancetype)controllerWithselectorView:(id<PGSKServiceSelector>) selectorView
                                   service:(NSArray<PGSKServiceSelectorItemPOD*>*)services{
    PGSKServiceSelectorController* controller = [[self alloc] init];
    controller.selectorView = selectorView;
    controller.services = services;
    
    selectorView.numberOfItemsInSection = ^(NSInteger section){
        return [services count];
    };
    
    selectorView.imageForIndexPath = ^(NSIndexPath* indexPath){
        return PGSKServiceGetImage([services[indexPath.item] sloganImageName]);
    };
    
    selectorView.titleForIndexPath = ^(NSIndexPath* indexPath){
        return [services[indexPath.item] name];
    };
    
    return controller;
}

- (void)showWithSelectBlock:(PGSKSelectServiceBlock)select cancelBlock:(PGSKCancelBlock)cancel{
    WeakSelf
    self.selectorView.didSelectItemAtIndexPath = ^(NSIndexPath* indexPath){
        StrongSelf
        [self.selectorView dismiss];
        if (select) select(self.services[indexPath.item]);
    };

    self.selectorView.cancelBlock = ^(id<PGSKServiceSelector> sender){
        StrongSelf
        [self.selectorView dismiss];
        if (cancel) cancel(self);
    };
    [self.selectorView show];
}

//- (NSInteger)numberOfRowsInSelector:(id<PGSKServiceSelector>)selector{
//    return [self.services count];
//}
//
//- (id<PGSKServiceInfo>)selector:(id<PGSKServiceSelector>)selector serviceForIndex:(NSUInteger)index{
//    return self.services[index];
//}
//
//- (void)selectorDidCancel:(id<PGSKServiceSelector>)selector{
//    if (self.cancelBlock) {
//        self.cancelBlock(selector);
//    }
//    [selector dismiss];
//}
//
//- (void)selector:(id<PGSKServiceSelector>)selector didSelectIndex:(NSUInteger)index{
//    if (self.selectBlock) {
//        self.selectBlock(self.services[index]);
//    }
//    [selector dismiss];
//}
@end






