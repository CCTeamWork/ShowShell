//
//  MSUShopDetailView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopDetailView.h"
#import "MSUPathTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUShopDetailView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)arr
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithImageArr:arr];
        [self createCenterViewWithImaArr:arr];
    }
    return self;
}


- (void)createViewWithImageArr:(NSArray *)arr{
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(SelfWidth * arr.count ,0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(325);
    }];

    self.pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = arr.count;
    [self addSubview:_pageControl];
    [_pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-10);
        make.left.equalTo(self.left).offset(SelfWidth * 0.5-100);
        make.width.equalTo(200);
        make.height.equalTo(25);
    }];

    
    for (NSInteger i = 0; i < arr.count; i++) {
        self.imaView = [[UIImageView alloc] init];
//        _imaView.backgroundColor = [UIColor];
        _imaView.image = [MSUPathTools showImageWithContentOfFileByName:arr[i]];
        _imaView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imaView];
        [_imaView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView.top).offset(0);
            make.left.equalTo(_scrollView.left).offset(SelfWidth*i);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(400);
        }];
    }
    
    self.bgView = [[UIView alloc] init];
    [self addSubview:_bgView];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    self.tittleLab = [[UILabel alloc] init];
    _tittleLab.font = [UIFont systemFontOfSize:16];
    _tittleLab.numberOfLines = 0;
    _tittleLab.textColor = [UIColor blackColor];
    [_bgView addSubview:_tittleLab];
    
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:18];
    _priceLab.textColor = [UIColor redColor];
    [_bgView addSubview:_priceLab];
    
    self.freightLab = [[UILabel alloc] init];
    _freightLab.font = [UIFont systemFontOfSize:12];
    _freightLab.textColor = [UIColor grayColor];
    [_bgView addSubview:_freightLab];

}

- (void)createCenterViewWithImaArr:(NSArray *)arr{
    self.bgCenView = [[UIView alloc] init];
    [self addSubview:_bgCenView];
    _bgCenView.backgroundColor = [UIColor whiteColor];
    [_bgCenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.bottom).offset(15);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(40+arr.count *400 + 3*10 + 15);
    }];
    
    UILabel *scanLab = [[UILabel alloc] init];
    scanLab.text = @"图文详情";
    scanLab.font = [UIFont systemFontOfSize:14];
    [_bgCenView addSubview:scanLab];
    [scanLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgCenView.top).offset(10);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(20);
    }];
    
    for (NSInteger j = 0; j < arr.count; j++) {
        UIImageView *ima = [[UIImageView alloc] init];
        ima.backgroundColor = [UIColor redColor];
        ima.image = [MSUPathTools showImageWithContentOfFileByName:arr[j]];
        [_bgCenView addSubview:ima];
        [ima makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgCenView.top).offset(40 + (400+10)*j);
            make.left.equalTo(scanLab.left).offset(0);
            make.width.equalTo(SelfWidth-30);
            make.height.equalTo(400);
        }];
    }
    
}


@end
