//
//  MSUOrderTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/9.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUOrderTableCell : UITableViewCell

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

/// 付款按钮
@property (nonatomic , strong) UIButton *payBtn;
/// 取消订单
@property (nonatomic , strong) UIButton *cancelBtn;

/// 申请售后
@property (nonatomic , strong) UIButton *applyBtn;
/// 申诉
@property (nonatomic , strong) UIButton *appealBtn;

/// 确认收货
@property (nonatomic , strong) UIButton *sureBtn;
/// 退货/换货
@property (nonatomic , strong) UIButton *returnBtn;
/// 提醒卖家发货
@property (nonatomic , strong) UIButton *remindBtn;

/// 提醒卖家发货
@property (nonatomic , strong) UIButton *commentBtn;

@end
