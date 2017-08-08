//
//  MSUMineShopTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUMineShopTableCell : UITableViewCell

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 设置推广
@property (nonatomic , strong) UIButton *pushBtn;

/// 设置推广
@property (nonatomic , strong) UIButton *againPushBtn;

/// 总佣金
@property (nonatomic , strong) UILabel *yongjinLab;
@property (nonatomic , strong) UIButton *yongjinBtn;

@end
