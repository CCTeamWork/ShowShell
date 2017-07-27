//
//  MSUGeussLikeView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUGeussLikeView.h"
#import "MSUGeussCollectionViewCell.h"

#define SelfWidth self.frame.size.width

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface MSUGeussLikeView()<UICollectionViewDelegateFlowLayout>

@end

@implementation MSUGeussLikeView

- (instancetype)initWithFrame:(CGRect)frame imageCount:(NSInteger)count
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithCount:count];
        
    }
    return self;
}


- (void)createViewWithCount:(NSInteger)count{
    UILabel *geussLab = [[UILabel alloc] init];
    geussLab.text = @"猜你喜欢";
    geussLab.font = [UIFont systemFontOfSize:16];
    geussLab.textColor = [UIColor blackColor];
    [self addSubview:geussLab];
    [geussLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(20);
    }];
    
    
    CGFloat wid = (SelfWidth - 30 - 30)/4;
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    [layOut setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layOut.itemSize = CGSizeMake(wid, wid+50+10);
    // 列间距
//    layOut.minimumInteritemSpacing = 10;
    // 行间距
    layOut.minimumLineSpacing = 10;
    // 四边距
    layOut.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, SelfWidth, wid+50+10) collectionViewLayout:layOut];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[MSUGeussCollectionViewCell class] forCellWithReuseIdentifier:@"geussCollectionViewCell"];
    _collectionView.scrollsToTop = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];

    
    
}

@end
