//
//  MSUShopDetailSKUView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUShopDetailSKUView : UIView

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 颜色按钮
@property (nonatomic , strong) UIButton *colorBtn;
@property (nonatomic , strong) NSMutableArray *colorBtnArr;

/// 加减按钮
@property (nonatomic , strong) UIButton *cutBtn;
@property (nonatomic , strong) UILabel *numLab;
@property (nonatomic , strong) UIButton *addBtn;

/// 确定按钮
@property (nonatomic , strong) UIButton *sureBtn;

@end
