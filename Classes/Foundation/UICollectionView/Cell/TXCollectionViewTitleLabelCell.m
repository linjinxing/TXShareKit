//
//  TXCollectionViewTitleLabelCell.m
//  MVCOfReadableCode
//
//  Created by linjinxing on 17/1/18.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "TXCollectionViewTitleLabelCell.h"

@interface TXCollectionViewTitleLabelCell()
@property(nonatomic, weak) UILabel* titleLabel;
@end

@implementation TXCollectionViewTitleLabelCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self createTitleLabel];
    return self;
}

- (void)createTitleLabel{
    UILabel* label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    self.titleLabel = label;
    self.titleLabelInsets = UIEdgeInsetsZero;
}

- (void)layoutSubviews{
    self.titleLabel.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, self.titleLabelInsets);
}

@end




