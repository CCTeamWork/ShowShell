//
//  MSUOrderDeatilController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/9.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUOrderDeatilController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"

#import "MSUOrderMenuView.h"
#import "MSUOrderTotaltView.h"
#import "MSUWaitPayView.h"
#import "MSUWaitRecieveView.h"
#import "MSUWaitCommentView.h"

#import "MSUPublishCommentController.h"
#import "MSUShopOrderDetailController.h"
#import "MSUReturnShopController.h"

@interface MSUOrderDeatilController ()<MSUWaitCommentViewDelegate,MSUWaitPayViewDelegate,MSUWaitRecieveViewDelegate,MSUOrderTotaltViewDelegate>

@property (nonatomic , strong) MSUOrderMenuView *orderView;

@property (nonatomic , strong) MSUOrderTotaltView *totalView;
@property (nonatomic , strong) MSUWaitPayView *payView;
@property (nonatomic , strong) MSUWaitRecieveView *recieveView;
@property (nonatomic , strong) MSUWaitCommentView *commentView;

@end

@implementation MSUOrderDeatilController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:18];
    [self.view addSubview:nav];
    
    [self createBuyerMenuView];
}

- (void)createBuyerMenuView{
    self.orderView = [[MSUOrderMenuView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 40)];
    [self.view addSubview:_orderView];
    _orderView.backgroundColor = [UIColor whiteColor];
    _orderView.lineView.frame = CGRectMake(30, 38, (WIDTH-60-20*3)/4, 2);
    for (UIButton *btn in _orderView.btnArr) {
        [btn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.totalView.hidden = NO;
}

#pragma mark - 点击事件
- (void)orderBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _orderView.lineView.frame = CGRectMake(CGRectGetMidX(sender.frame)-30, 38, (WIDTH-60-20*3)/4, 2);
    }];
    if (sender == _orderView.btnArr[0]) {
        self.totalView.hidden = NO;
        self.payView.hidden = YES;
        self.recieveView.hidden = YES;
        self.commentView.hidden = YES;
    }
    else if (sender == _orderView.btnArr[1]){
        self.totalView.hidden = YES;
        self.payView.hidden = NO;
        self.recieveView.hidden = YES;
        self.commentView.hidden = YES;
    }
    else if (sender == _orderView.btnArr[2]){
        self.totalView.hidden = YES;
        self.payView.hidden = YES;
        self.recieveView.hidden = NO;
        self.commentView.hidden = YES;
    } else if (sender == _orderView.btnArr[3]){
        self.totalView.hidden = YES;
        self.payView.hidden = YES;
        self.recieveView.hidden = YES;
        self.commentView.hidden = NO;
    }
    
}

#pragma mark - 初始化
- (MSUOrderTotaltView *)totalView{
    if (!_totalView) {
        self.totalView = [[MSUOrderTotaltView alloc] initWithFrame:CGRectMake(0, 64+40, WIDTH, HEIGHT-104)];
        [self.view addSubview:_totalView];
        _totalView.backgroundColor = BGLINECOLOR;
        _totalView.delegate = self;
        _totalView.hidden = YES;
    }
    return _totalView;
}

- (MSUWaitPayView *)payView{
    if (!_payView) {
        self.payView = [[MSUWaitPayView alloc] initWithFrame:CGRectMake(0, 64+40, WIDTH, HEIGHT-104)];
        [self.view addSubview:_payView];
        _payView.backgroundColor = BGLINECOLOR;
        _payView.delegate = self;
        _payView.hidden = YES;
    }
    return _payView;
}

- (MSUWaitRecieveView *)recieveView{
    if (!_recieveView) {
        self.recieveView = [[MSUWaitRecieveView alloc] initWithFrame:CGRectMake(0, 64+40, WIDTH, HEIGHT-104)];
        [self.view addSubview:_recieveView];
        _recieveView.backgroundColor = BGLINECOLOR;
        _recieveView.delegate = self;
        _recieveView.hidden = YES;
    }
    return _recieveView;
}

- (MSUWaitCommentView *)commentView{
    if (!_commentView) {
        self.commentView = [[MSUWaitCommentView alloc] initWithFrame:CGRectMake(0, 64+40, WIDTH, HEIGHT-104)];
        [self.view addSubview:_commentView];
        _commentView.backgroundColor = BGLINECOLOR;
        _commentView.delegate = self;
        _commentView.hidden = YES;
    }
    return _commentView;
}

#pragma mark - 代理
- (void)commentBtnClick{
    self.hidesBottomBarWhenPushed = YES;
    MSUPublishCommentController *publish = [[MSUPublishCommentController alloc] init];
    [self.navigationController pushViewController:publish animated:YES];
}

- (void)cellDidSelct{
    self.hidesBottomBarWhenPushed = YES;
    MSUShopOrderDetailController *publish = [[MSUShopOrderDetailController alloc] init];
    [self.navigationController pushViewController:publish animated:YES];
}

- (void)returnBtnClick{
    self.hidesBottomBarWhenPushed = YES;
    MSUReturnShopController *publish = [[MSUReturnShopController alloc] init];
    [self.navigationController pushViewController:publish animated:YES];
}

@end
