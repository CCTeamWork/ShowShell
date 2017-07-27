//
//  MSUShopDetailView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUShopDetailView : UIView

/// 滚动视图
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIPageControl *pageControl;

/// 图片内容
@property (nonatomic , strong) UIImageView *imaView;

/// 背景上图
@property (nonatomic , strong) UIView *bgView;

/// 标题
@property (nonatomic , strong) UILabel *tittleLab;

/// 价格
@property (nonatomic , strong) UILabel *priceLab;

/// 运费
@property (nonatomic , strong) UILabel *freightLab;

/// 背景中图
@property (nonatomic , strong) UIView *bgCenView;

/* 初始化 */
- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)arr;

@end
