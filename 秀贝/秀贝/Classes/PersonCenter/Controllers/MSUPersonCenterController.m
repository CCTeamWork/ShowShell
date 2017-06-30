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
    [payBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    [shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payBtn.bottom).offset(20);
        make.left.equalTo(self.view.left).offset(20);
        make.width.equalTo(WIDTH-40);
        make.height.equalTo(30);
    }];

}

- (void)btnClick:(UIButton *)sender{
    [MSUAliPayController payForSomethingWithAliPay];
}

@end
