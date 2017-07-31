//
//  MSUHotTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUHotTableCell : UITableViewCell

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 加入购物车
@property (nonatomic , strong) UIButton *shopCarBtn;;

@end
