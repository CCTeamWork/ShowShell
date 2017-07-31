//
//  MSUSearchResultView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchResultView.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height
#define lineColor [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUSearchResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.seleArr = [NSMutableArray array];
        [self createView];
        
    }
    return self;
}


- (void)createView{
    // 第一段线背景
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, 1)];
    lineView.backgroundColor = lineColor;
    [self addSubview:lineView];
    
    // 背景视图
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(50);
    }];
    
    NSArray *nameArr = @[@"综合",@"视频",@"用户",@"商品"];
    for (NSInteger i = 0; i < nameArr.count; i++) {
        self.seleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _seleBtn.adjustsImageWhenHighlighted = NO;
        _seleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_seleBtn setTitle:[NSString stringWithFormat:@"%@",nameArr[i]] forState:UIControlStateNormal];
        [_seleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_seleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        _seleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        if (i == 0) {
            _seleBtn.selected = YES;
        }
//        _seleBtn.tag = 2017 + i;
        [bgView addSubview:_seleBtn];
        [_seleBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.top).offset(0);
            make.left.equalTo(bgView.left).offset(SelfWidth/4*i);
            make.width.equalTo(SelfWidth/4);
            make.height.equalTo(45);
        }];
        [self.seleArr addObject:_seleBtn];
    }
    
    
    self.underLineView = [[UIView alloc] init];
//    self.underLineView = [[UIView alloc] initWithFrame:CGRectMake(SelfWidth/8-15, 38, 30, 5)];
    _underLineView.backgroundColor = [UIColor orangeColor];
    _underLineView.layer.cornerRadius = 3;
    _underLineView.clipsToBounds = YES;
    _underLineView.layer.shouldRasterize = YES;
    _underLineView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:_underLineView];
//    [_underLineView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_seleBtn.bottom).offset(-7);
//        make.centerX.equalTo(_seleBtn.centerX).offset(0);
//        make.width.equalTo(30);
//        make.height.equalTo(5);
//    }];

    
    // 第二段线背景
    UIView *line2View = [[UIView alloc] init];
    line2View.backgroundColor = lineColor;
    [self addSubview:line2View];
    [line2View makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(10);
    }];

    
    // 滚动视图
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(SelfWidth * nameArr.count, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2View.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfHeight-64-1-50-10);
    }];


}

@end
