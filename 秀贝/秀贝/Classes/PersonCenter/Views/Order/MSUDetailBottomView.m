//
//  MSUDetailBottomView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUDetailBottomView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@implementation MSUDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    /// 收货人
    self.reciUserLab = [[UILabel alloc] init];
    _reciUserLab.textColor = [UIColor blackColor];
    _reciUserLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_reciUserLab];
    [_reciUserLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];

    /// 收货地址
    self.headerLab = [[UILabel alloc] init];
    _headerLab.textColor = [UIColor blackColor];
    _headerLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_headerLab];

    
    self.reciAddressLab = [[UILabel alloc] init];
    _reciAddressLab.textColor = [UIColor blackColor];
    _reciAddressLab.font = [UIFont systemFontOfSize:14];
    _reciAddressLab.numberOfLines = 0;
    [self addSubview:_reciAddressLab];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = BGLINECOLOR;
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_reciAddressLab.bottom).offset(10);
        make.left.equalTo(_reciUserLab.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(1);
    }];
    
    /// 订单编号
    self.orderNumLab = [[UILabel alloc] init];
    _orderNumLab.textColor = [UIColor blackColor];
    _orderNumLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_orderNumLab];
    [_orderNumLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];

    /// 成交时间
    self.timeLab = [[UILabel alloc] init];
    _timeLab.textColor = [UIColor blackColor];
    _timeLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderNumLab.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];
    
    UIView *bg1View = [[UIView alloc] init];
    bg1View.backgroundColor = BGLINECOLOR;
    [self addSubview:bg1View];
    [bg1View makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLab.bottom).offset(10);
        make.left.equalTo(_reciUserLab.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(1);
    }];

    /// 快递公司
    self.companyLab = [[UILabel alloc] init];
    _companyLab.textColor = [UIColor grayColor];
    _companyLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_companyLab];
    [_companyLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg1View.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];

    /// 快递单号
    self.expressLab = [[UILabel alloc] init];
    _expressLab.textColor = [UIColor grayColor];
    _expressLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_expressLab];
    [_expressLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_companyLab.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];

    
}

@end
