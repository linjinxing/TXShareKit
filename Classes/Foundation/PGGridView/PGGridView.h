//
//  PGGridView.h
//  PGShareKit
//
//  Created by linjinxing on 17/1/22.
//  Copyright © 2017年 linjinxing. All rights reserved.
//  定义表格View的回调协议，可以用来统一UITableView和UICollectionView

#ifndef PGGridView_h
#define PGGridView_h

#import <UIKit/UIKit.h>

/*
 ----------- 以下是定义blocks，代替delegate或者datasource，因为blocks相对更方便些，简单些。 ----------
 */

@protocol PGGridView;

/**
 在indexPath指定的section中，一共有多少项
 
 @param section <#indexPath description#>
 @return <#return value description#>
 */
typedef NSUInteger (^PGGVNumberOfItemsInSection)(NSInteger section);

/**
 返回indexPath的图片
 
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
typedef UIImage*  (^PGGVImageForIndexPath)(NSIndexPath* indexPath);


/**
 返回indexPath要显示的图片
 
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
typedef __kindof UIView*  (^PGGVCellForIndexPath)(NSIndexPath* indexPath);


/**
 返回cell的size大小
 
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
typedef CGSize (^PGGVSizeForIndexPath)(NSIndexPath* indexPath);

/**
 一共有多少个Sections
 
 @return <#return value description#>
 */
typedef NSInteger (^PGGVNumberOfSections)();


/**
 返回indexPath要显示的标题
 
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
typedef NSString* (^PGGVTitleForIndexPath)(NSIndexPath* indexPath);


/**
 返回indexPath要显示的描述
 
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
typedef NSString* (^PGGVDescriptionForIndexPath)(NSIndexPath* indexPath);


/**
 当选中了某个Item时，就会回调
 
 @param indexPath <#indexPath description#>
 */
typedef void (^PGGVDidSelectItemAtIndexPath)(NSIndexPath* indexPath);


//@protocol PGGridView<NSObject>
//@property(copy) PGGVNumberOfItemsInSection numberOfItemsInSection;
//@property(copy) PGGVImageForIndexPath imageForIndexPath;
//@property(copy) PGGVCellForIndexPath cellForIndexPath;
//@property(copy) PGGVNumberOfSections numberOfSections;
//@property(copy) PGGVTitleForIndexPath titleForIndexPath;
//@property(copy) PGGVDescriptionForIndexPath descriptionForIndexPath;
//@property(copy) PGGVDidSelectItemAtIndexPath didSelectItemAtIndexPath;
//@end

/**
 只有单行的表格
 */
@protocol PGSingleLineGridView<NSObject>
@property(copy) PGGVNumberOfItemsInSection numberOfItemsInSection;
@property(copy) PGGVCellForIndexPath cellForIndexPath;
@property(copy) PGGVSizeForIndexPath szieForIndexPath;
@property(copy) PGGVDidSelectItemAtIndexPath didSelectAtIndexPath;
@end

/**
 水平单行的表格
 */
@protocol PGHorizontalSingleLineGridView<PGSingleLineGridView>
@end

/**
 垂直单行的表格
 */
@protocol PGVeticalSingleLineGridView<PGSingleLineGridView>
@end

static inline CGFloat PGGridViewDefaultSpace(){
    return 6.0f;
}

static inline CGSize PGGridViewDefaultCellSize(){
    return CGSizeMake(80.0f, 120.0f);
}



#endif /* PGGridView_h */






