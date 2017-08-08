//
//  MSUPushShopTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/8.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUPushShopTableCell : UITableViewCell

/// 店头像
@property (nonatomic , strong) UIImageView *userIma;

/// 店名
@property (nonatomic , strong) UILabel *nickLab;

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 总佣金
@property (nonatomic , strong) UILabel *yongjinLab;

/// 有效期
@property (nonatomic , strong) UILabel *timeLab;

/// 状态图片
@property (nonatomic , strong) UIImageView *pushImaView;

@end
