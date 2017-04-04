//
//  PGSKServiceSelectorView.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceDefaultSelectorView.h"
#import "TXCollectionViewImageCell.h"
#import "UIButton+Layout.h"
#import "PGSKConfig.h"
#import "PGLocalizationDefines.h"

//static UIColor * colorWithHex(int hex)
//{
//    float r = ((float)((hex & 0xff0000) >> 16))/255.0;
//    float g = ((float)((hex & 0xff00) >> 8))/255.0;
//    float b = ((float)((hex & 0xff) >> 0))/255.0;
//    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
//}

@interface PGSKServiceDefaultSelectorView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) UICollectionView* collectionView;
@property(nonatomic, strong) UIButton* btnCancel;
@property(nonatomic, strong) UIView* viewBackgroud;
@property(nonatomic, strong) UIView* viewLine;
@end

#define Space 6
#define CollectionViewHeight 80
#define CellSize CGSizeMake(68, CollectionViewHeight)
#define ButtonHeight 60

@implementation PGSKServiceDefaultSelectorView
@synthesize numberOfItemsInSection, imageForIndexPath, didSelectItemAtIndexPath, titleForIndexPath, cancelBlock;

-(instancetype)init{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return self;
}

+ (UICollectionViewFlowLayout*)collectionViewFlowLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CellSize;
    layout.minimumInteritemSpacing = Space;
    layout.sectionInset = UIEdgeInsetsMake(Space , Space * 2, 0, Space * 2);
    return layout;
}

- (UICollectionView*)createCollectionView{
    UICollectionView* cv = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[[self class] collectionViewFlowLayout]];
    cv.backgroundColor = [UIColor whiteColor];
    [cv registerClass:[TXCollectionViewImageCell class]  forCellWithReuseIdentifier:NSStringFromClass([TXCollectionViewImageCell class])];
    return cv;
}

- (void)createSubviews{
    self.viewBackgroud = [[UIView alloc] initWithFrame:self.bounds];
    self.viewBackgroud.backgroundColor = [UIColor whiteColor];
    
    self.viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
    self.viewLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    self.collectionView = [self createCollectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.btnCancel setTitle:PText(@"cancle",@"取消") forState:UIControlStateNormal];
    [self.btnCancel addTarget:self
                       action:@selector(cancelAction:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.viewBackgroud];
    [self addSubview:self.collectionView];
    [self addSubview:self.btnCancel];
    [self addSubview:self.viewLine];
}

- (void)action:(id)sender{
//    if ([self.delegate respondsToSelector:@selector(selectorDidCancel:)]) {
//        [self.delegate selector:self didSelectIndex:[sender tag]];
//    }
}

- (void)cancelAction:(id)sender{
//    if ([self.delegate respondsToSelector:@selector(selectorDidCancel:)]) {
//        [self.delegate selectorDidCancel:self];
//    }
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

- (void)layoutSubviews{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat cvHeight = size.height - CollectionViewHeight - Space * 3 - ButtonHeight;
    CGFloat buttonOffsetY = size.height - ButtonHeight - Space * 2;
    self.collectionView.frame = CGRectMake(0, cvHeight, size.width, CollectionViewHeight);
    
    self.btnCancel.frame = CGRectMake(0, buttonOffsetY, size.width, ButtonHeight);
    
    self.viewBackgroud.frame = CGRectMake(0, cvHeight, size.width, size.height - cvHeight);
    
    self.viewLine.frame = CGRectMake(0, buttonOffsetY, size.width, 0.5);
//    self.viewLine.backgroundColor = [UIColor redColor];
}

- (void)show{
    [self removeFromSuperview];
//    UIView* superView = [[UIApplication sharedApplication].windows firstObject];
    UIView* superView = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    [superView addSubview:self];
    [self.collectionView reloadData];
    [superView bringSubviewToFront:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}

#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInSelector:)]) {
//        return [self.dataSource numberOfRowsInSelector:self];
//    }
//    return 0;
    return self.numberOfItemsInSection ? self.numberOfItemsInSection(section) : 0;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TXCollectionViewImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TXCollectionViewImageCell class]) forIndexPath:indexPath];
    assert(self.imageForIndexPath);
    const CGFloat space = 10.0f;
    cell.insets = UIEdgeInsetsMake(space/2, space, space, space);
    cell.imageView.image = self.imageForIndexPath(indexPath);
    
    if (self.titleForIndexPath) {
        NSString* name = self.titleForIndexPath(indexPath);
        cell.titleLabel.text = PText(name, name);
    }
//    if ([self.dataSource respondsToSelector:@selector(selector:serviceForIndex:)]) {
//        id<PGSKServiceInfo> info = [self.dataSource selector:self serviceForIndex:indexPath.item];
//        [btn setTitle:info.name forState:UIControlStateNormal];
//        [btn setImage:PGSKServiceInfoGetImageWithKey([info sloganImageName]) forState:UIControlStateNormal];
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectItemAtIndexPath) {
        self.didSelectItemAtIndexPath(indexPath);
    }
}


@end





