//
//  MSUShopHouseTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/4.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUShopHouseTableCell : UITableViewCell

/// 选择按钮
@property (nonatomic , strong) UIButton *seleBtn;

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 推广金额
@property (nonatomic , strong) UILabel *tuiGuangLab;

/// 店铺信息
@property (nonatomic , strong) UIButton *infoBtn;

@end
