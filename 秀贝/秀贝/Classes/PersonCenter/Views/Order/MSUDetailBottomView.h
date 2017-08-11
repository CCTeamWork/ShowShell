//
//  MSUDetailBottomView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUDetailBottomView : UIView

/// 收货人
@property (nonatomic , strong) UILabel *reciUserLab;

/// 收货地址
@property (nonatomic , strong) UILabel *headerLab;
@property (nonatomic , strong) UILabel *reciAddressLab;

/// 订单编号
@property (nonatomic , strong) UILabel *orderNumLab;

/// 成交时间
@property (nonatomic , strong) UILabel *timeLab;

/// 快递公司
@property (nonatomic , strong) UILabel *companyLab;

/// 快递单号
@property (nonatomic , strong) UILabel *expressLab;


@end
