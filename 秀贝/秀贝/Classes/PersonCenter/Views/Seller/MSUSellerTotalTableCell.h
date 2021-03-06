//
//  MSUSellerTotalTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/11.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSellerTotalTableCell : UITableViewCell

/// 头像
@property (nonatomic , strong) UIImageView *iconIma;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 状态
@property (nonatomic , strong) UILabel *statusLab;

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 规格
@property (nonatomic , strong) UILabel *sizeLab;;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 商品数量
@property (nonatomic , strong) UILabel *numLab;

/// 同意申请
@property (nonatomic , strong) UIButton *agreeBtn;
/// 拒绝申请
@property (nonatomic , strong) UIButton *disagreeBtn;

/// 确认收货
@property (nonatomic , strong) UIButton *sureBtn;

@end
