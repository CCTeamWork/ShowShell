//
//  MSUOrderSureCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUOrderSureCell : UITableViewCell

/// 头像
@property (nonatomic , strong) UIImageView *iconIma;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 内容背景
@property (nonatomic , strong) UIView *bgView;

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 商品数量
@property (nonatomic , strong) UILabel *numLab;

@end
