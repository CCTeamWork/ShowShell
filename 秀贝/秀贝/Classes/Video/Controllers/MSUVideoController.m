//
//  MSUVideoController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUVideoController.h"
#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"
#import "MSUSearchController.h"
#import "MSUVideoView.h"
#import "MSUPlayerController.h"

@interface MSUVideoController ()

@end

@implementation MSUVideoController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    // 状态栏菊花转
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = WHITECOLOR;

    /// 导航栏
    [self createNavView];

    /// 内容视图
    [self createCenterView];
}

#pragma mark - 视图相关
- (void)createNavView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:3];
    [self.view addSubview:nav];
    [nav.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createCenterView{
    MSUVideoView *video = [[MSUVideoView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-44)];
    video.backgroundColor = YELLOWCOLOR;
    [self.view addSubview:video];
    [video.pageBtn addTarget:self action:@selector(pageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    

}

#pragma mark - 点击事件
/* 搜索框按钮点击 */
- (void)searchBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUSearchController *search = [[MSUSearchController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

/* 视频页按钮点击 */
- (void)pageBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUPlayerController *player = [[MSUPlayerController alloc] init];
    [self.navigationController pushViewController:player animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
