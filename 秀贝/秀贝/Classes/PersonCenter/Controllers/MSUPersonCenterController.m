//
//  MSUPersonCenterController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPersonCenterController.h"
#import "MSUPrefixHeader.pch"

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
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(50, 50, 50, 50);
    testBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testBtn];
    [testBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)sender{
    
}

@end
