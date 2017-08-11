//
//  MSUSellerWaitPayTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/11.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSellerWaitPayTableCell : UITableViewCell

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

/// 收货人
@property (nonatomic , strong) UILabel *reciUserLab;
/// 收货地址
@property (nonatomic , strong) UILabel *addressLab;
@property (nonatomic , strong) UILabel *addressContentLab;
/// 留言
@property (nonatomic , strong) UILabel *wordsLab;

/// 修改价格
@property (nonatomic , strong) UIButton *priceBtn;
/// 取消订单
@property (nonatomic , strong) UIButton *cancelBtn;

/// 待发货
@property (nonatomic , strong) UIButton *sendBtn;
/// 取消订单
@property (nonatomic , strong) UIButton *orderBtn;




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rowHeight:(CGFloat)rowHeight;

@end
