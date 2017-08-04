//
//  MSUShopSelectTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUShopSelectTableCell : UITableViewCell

@property (nonatomic , copy) void(^unfoldBtnClickBlock)(UIButton *unfoldBtn);


/// 商品背景视图
@property (nonatomic , strong) UIView *topBGView;

/// 选择按钮
@property (nonatomic , strong) UIButton *seleBtn;

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 展开按钮
@property (nonatomic , strong) UIButton *foldBtn;;

/// 颜色按钮
@property (nonatomic , strong) UIButton *colorBtn;
@property (nonatomic , strong) NSMutableArray *colorBtnArr;

/// 加减按钮
@property (nonatomic , strong) UIButton *cutBtn;
@property (nonatomic , strong) UILabel *numLab;
@property (nonatomic , strong) UIButton *addBtn;


/// 规格背景视图
@property (nonatomic , strong) UIView *bottomBGView;




@end
