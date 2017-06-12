//
//  MSUShopStoreController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopStoreController.h"
#import "MSUPrefixHeader.pch"

@interface MSUShopStoreController ()

@end

@implementation MSUShopStoreController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = WHITECOLOR;

}


@end
