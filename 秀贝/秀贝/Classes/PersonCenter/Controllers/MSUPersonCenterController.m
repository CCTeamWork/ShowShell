//
//  MSUPersonCenterController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPersonCenterController.h"
#import "MSUPrefixHeader.pch"
#import "MSUAliPayController.h"
#import "MSUShareController.h"
#import "MSUShopHouseController.h"
#import "MSUOrderDeatilController.h"

@interface MSUPersonCenterController ()

@end

@implementation MSUPersonCenterController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = WHITECOLOR;
    
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.backgroundColor = [UIColor blueColor];
    [payBtn setTitle:@"点我支付" forState:UIControlStateNormal];
    [self.view addSubview:payBtn];
    [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [payBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(64);
        make.left.equalTo(self.view.left).offset(20);
        make.width.equalTo(WIDTH-40);
        make.height.equalTo(30);
    }];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.backgroundColor = [UIColor blueColor];
    [shareBtn setTitle:@"点我分享" forState:UIControlStateNormal];
    [self.view addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payBtn.bottom).offset(20);
        make.left.equalTo(self.view.left).offset(20);
        make.width.equalTo(WIDTH-40);
        make.height.equalTo(30);
    }];
    
    UIButton *houseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    houseBtn.backgroundColor = [UIColor blueColor];
    [houseBtn setTitle:@"商品库" forState:UIControlStateNormal];
    [self.view addSubview:houseBtn];
    [houseBtn addTarget:self action:@selector(houseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [houseBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareBtn.bottom).offset(20);
        make.left.equalTo(self.view.left).offset(20);
        make.width.equalTo(WIDTH-40);
        make.height.equalTo(30);
    }];
    
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.backgroundColor = [UIColor blueColor];
    [orderBtn setTitle:@"我的订单" forState:UIControlStateNormal];
    [self.view addSubview:orderBtn];
    [orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(houseBtn.bottom).offset(20);
        make.left.equalTo(self.view.left).offset(20);
        make.width.equalTo(WIDTH-40);
        make.height.equalTo(30);
    }];

}

- (void)payBtnClick:(UIButton *)sender{
    [MSUAliPayController payForSomethingWithAliPay];
}

- (void)shareBtnClick:(UIButton *)sender{
    [MSUShareController makeShareSomeContentWithText:@"何龙飞真帅" title:@"分享" url:nil];
}

- (void)houseBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUShopHouseController *house = [[MSUShopHouseController alloc] init];
    [self.navigationController pushViewController:house animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)orderBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUOrderDeatilController *order = [[MSUOrderDeatilController alloc] init];
    [self.navigationController pushViewController:order animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
