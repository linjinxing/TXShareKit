//
//  PGImageView.h
//  MVCOfReadableCode
//
//  Created by linjinxing on 17/1/18.
//  Copyright © 2017年 linjinxing. All rights reserved.
//  

#import <Foundation/Foundation.h>

#import "PGGridView.h"


//@protocol PGGridView<NSObject>
//@end


/**
 只有单行的图像表格
 */
@protocol PGSingleLineImageView<NSObject>
@property(copy) PGGVNumberOfItemsInSection numberOfItemsInSection;
@property(copy) PGGVImageForIndexPath imageForIndexPath;
@property(copy) PGGVTitleForIndexPath titleForIndexPath;
//@property(copy) PGGVDescriptionForIndexPath descriptionForIndexPath;
@property(copy) PGGVDidSelectItemAtIndexPath didSelectItemAtIndexPath;
@end

/**
 水平方向单行的图像表格
 */
@protocol PGHorizontalSingleLineImageView<PGSingleLineImageView>
@end


static inline CGFloat PGSingleLineImageViewDefaultSpace(){
    return 6.0f;
}

static inline CGSize PGSingleLineImageViewDefaultCellSize(){
    return CGSizeMake(80.0f, 120.0f);
}



//
//
//@protocol PGImageViewDataSource <NSObject>
//- (UIImage*)iamgeView:(__kindof UIView*)imageView imageForIndexPath:(NSIndexPath*)indexPath;
//- (NSInteger)imageView:(__kindof UIView*)imageView numberOfItemsInSection:(NSInteger)section;
//@optional
///**
// 返回有多少个section，默认返回1
//
// @param imageView <#imageView description#>
// @return <#return value description#>
// */
//- (NSInteger)numberOfSectionsInCollectionView:(__kindof UIView*)imageView;
///**
// 返回图片的标题
//
// @param imageView <#imageView description#>
// @param indexPath <#indexPath description#>
// @return <#return value description#>
// */
//- (NSString*)iamgeView:(__kindof UIView*)imageView titleForIndexPath:(NSIndexPath*)indexPath;
///**
// 返回图片的描述
//
// @param imageView <#imageView description#>
// @param indexPath <#indexPath description#>
// @return <#return value description#>
// */
//- (NSString*)iamgeView:(__kindof UIView*)imageView descriptionForIndexPath:(NSIndexPath*)indexPath;
//@end
//
//@protocol PGImageViewDelegate <NSObject>
//@optional
///**
// 点击某个图片的回调
//
// @param imageView <#imageView description#>
// @param indexPath <#indexPath description#>
// */
//- (void)imageView:(__kindof UIView*)imageView didSelectItemAtIndexPath:(NSIndexPath*)indexPath;
//@end
