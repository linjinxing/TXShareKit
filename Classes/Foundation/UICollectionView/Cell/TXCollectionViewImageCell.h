//
//  TXCollectionViewImageCell.h
//  MVCOfReadableCode
//
//  Created by linjinxing on 17/1/18.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXCollectionViewImageCell : UICollectionViewCell
@property(readonly, nonatomic, weak) UIImageView* imageView;
@property(readonly, nonatomic, weak) UILabel* titleLabel;
@property(nonatomic) UIEdgeInsets insets;
//@property(nonatomic, weak) UILabel* titleLabel;
@end



