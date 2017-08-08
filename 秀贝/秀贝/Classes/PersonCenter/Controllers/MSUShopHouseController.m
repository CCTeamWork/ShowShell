//
//  MSUShopHouseController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopHouseController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUMineShopView.h"
#import "MSUPushShopView.h"

#import "MSUPushSetController.h"


@interface MSUShopHouseController ()<UIScrollViewDelegate,MSUMineShopViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIView *lineView ;

@property (nonatomic , strong) MSUMineShopView *mineView;
@property (nonatomic , strong) MSUPushShopView *pushView;

@end

@implementation MSUShopHouseController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor blackColor];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:16];
    [self.view addSubview:nav];
    
    NSArray *arr = @[@"我的商品",@"推广商品"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *mineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        mineBtn.frame = CGRectMake(WIDTH*0.5*i, 64, WIDTH*0.5, 40);
        [mineBtn setTitle:arr[i] forState:UIControlStateNormal];
        [mineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        mineBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        mineBtn.backgroundColor = [UIColor whiteColor];
        mineBtn.adjustsImageWhenHighlighted = NO;
        mineBtn.tag = 20170807 + i;
        [mineBtn addTarget:self action:@selector(mineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mineBtn];
    }
    
    self.lineView = [[UIView alloc] init];
    _lineView.frame = CGRectMake(WIDTH*0.5*0.5-30, 64+38, 60, 2);
    _lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_lineView];
    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+40, WIDTH, HEIGHT-104)];
//    _scrollView.pagingEnabled = NO;
//    _scrollView.scrollEnabled = NO;
//    _scrollView.contentSize = CGSizeMake(WIDTH * 2, 0);
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.showsVerticalScrollIndicator = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.view addSubview:_scrollView];
    
    self.mineView.hidden = NO;
}

- (void)mineBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _lineView.frame = CGRectMake(WIDTH*0.5*0.5-30 + WIDTH*0.5*(sender.tag-20170807), 64+38, 60, 2);
    }];
    
    switch (sender.tag) {
        case 20170807:
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.pushView.hidden = YES;
                self.mineView.hidden = NO;
            }];
        }
            break;
        case 20170808:
        {
            self.mineView.hidden = YES;
            self.pushView.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (MSUMineShopView *)mineView{
    if (!_mineView) {
        self.mineView = [[MSUMineShopView alloc] initWithFrame:CGRectMake(0, 64+40, WIDTH, HEIGHT-104)];
        [self.view addSubview:_mineView];
        _mineView.delegate = self;
        _mineView.hidden = YES;
        
    }
    return _mineView;
}

- (MSUPushShopView *)pushView{
    if (!_pushView) {
        self.pushView = [[MSUPushShopView alloc] initWithFrame:CGRectMake(0, 64+40, WIDTH, HEIGHT-104)];
        [self.view addSubview:_pushView];
        _pushView.hidden = YES;
    }
    return _pushView;
}

- (void)pushBtnClick{
    self.hidesBottomBarWhenPushed = YES;
    MSUPushSetController *set = [[MSUPushSetController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}

@end
