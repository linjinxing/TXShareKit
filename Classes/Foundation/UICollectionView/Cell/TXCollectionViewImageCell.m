//
//  TXCollectionViewImageCell.m
//  MVCOfReadableCode
//
//  Created by linjinxing on 17/1/18.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "TXCollectionViewImageCell.h"
#import "PGGridView.h"

#define kDefaultSpace 12.0f

@interface TXCollectionViewImageCell()
@property(nonatomic, weak) UIImageView* imageView;
@property(nonatomic, weak) UILabel* titleLabel;
@property(assign) CGFloat space;
@end

@implementation TXCollectionViewImageCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self createImageView];
    [self createTitleLabel];
    self.space = PGGridViewDefaultSpace();
    self.insets = UIEdgeInsetsMake(self.space, self.space, self.space, self.space);
#ifdef DEBUG
//    self.backgroundColor = [UIColor yellowColor];
//    self.imageView.backgroundColor = [UIColor greenColor];
//    self.titleLabel.backgroundColor = [UIColor brownColor];
#endif
    return self;
}

- (void)createImageView{
    UIImageView* imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)createTitleLabel{
    UILabel* label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:label];
    self.titleLabel = label;
}

- (void)layoutSubviews{
    CGFloat width = self.frame.size.width - self.insets.left - self.insets.right;
    self.imageView.frame = CGRectMake(self.insets.left, self.insets.top, width, width);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(0,
                                       self.insets.top + width + self.insets.top,
                                       self.frame.size.width,
                                       self.titleLabel.frame.size.height);
}


@end

