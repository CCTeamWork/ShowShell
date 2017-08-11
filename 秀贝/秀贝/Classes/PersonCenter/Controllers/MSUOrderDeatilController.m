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
// 买家版
#import "MSUOrderTotaltView.h"
#import "MSUWaitPayView.h"
#import "MSUWaitRecieveView.h"
#import "MSUWaitCommentView.h"
// 卖家版
#import "MSUSellerTotalView.h"
#import "MSUBackMoneyView.h"
#import "MSUSellerWaitPayView.h"
#import "MSUSellerWaitSendView.h"


#import "MSUPublishCommentController.h"
#import "MSUShopOrderDetailController.h"
#import "MSUReturnShopController.h"

@interface MSUOrderDeatilController ()<MSUWaitCommentViewDelegate,MSUWaitPayViewDelegate,MSUWaitRecieveViewDelegate,MSUOrderTotaltViewDelegate>

@property (nonatomic , strong) UIView *buyerView;
@property (nonatomic , strong) MSUOrderMenuView *orderBuyerView;
@property (nonatomic , strong) MSUOrderTotaltView *totalView;
@property (nonatomic , strong) MSUWaitPayView *payView;
@property (nonatomic , strong) MSUWaitRecieveView *recieveView;
@property (nonatomic , strong) MSUWaitCommentView *commentView;

@property (nonatomic , strong) UIView *sellerView;
@property (nonatomic , strong) MSUOrderMenuView *orderSellerView;
@property (nonatomic , strong) MSUSellerTotalView *sellerTotalView;
@property (nonatomic , strong) MSUBackMoneyView *sellerBackMoneyView;
@property (nonatomic , strong) MSUSellerWaitPayView *sellerWaitPayView;
@property (nonatomic , strong) MSUSellerWaitSendView *sellerWaitSendView;

@end

@implementation MSUOrderDeatilController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:18];
    [self.view addSubview:nav];
    [nav.positionBtn addTarget:self action:@selector(positionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buyerView.hidden = NO;
    
}


#pragma mark - 点击事件
- (void)positionBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.sellerView.hidden = NO;
        self.buyerView.hidden = YES;
    } else {
        self.sellerView.hidden = YES;
        self.buyerView.hidden = NO;
    }
    
}

/* 买家按钮点击 */
- (void)orderBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _orderBuyerView.lineView.frame = CGRectMake(CGRectGetMidX(sender.frame)-30, 38, (WIDTH-60-20*3)/4, 2);
    }];
    if (sender == _orderBuyerView.btnArr[0]) {
        self.totalView.hidden = NO;
        self.payView.hidden = YES;
        self.recieveView.hidden = YES;
        self.commentView.hidden = YES;
    }
    else if (sender == _orderBuyerView.btnArr[1]){
        self.totalView.hidden = YES;
        self.payView.hidden = NO;
        self.recieveView.hidden = YES;
        self.commentView.hidden = YES;
    }
    else if (sender == _orderBuyerView.btnArr[2]){
        self.totalView.hidden = YES;
        self.payView.hidden = YES;
        self.recieveView.hidden = NO;
        self.commentView.hidden = YES;
    } else if (sender == _orderBuyerView.btnArr[3]){
        self.totalView.hidden = YES;
        self.payView.hidden = YES;
        self.recieveView.hidden = YES;
        self.commentView.hidden = NO;
    }
}

/* 卖家按钮点击 */
- (void)orderSellerBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _orderSellerView.lineView.frame = CGRectMake(CGRectGetMidX(sender.frame)-30, 38, (WIDTH-60-20*3)/4, 2);
    }];
    if (sender == _orderSellerView.btnArr[0]) {
        self.sellerTotalView.hidden = NO;
        self.sellerWaitPayView.hidden = YES;
        self.sellerWaitSendView.hidden = YES;
        self.sellerBackMoneyView.hidden = YES;
    }
    else if (sender == _orderSellerView.btnArr[1]){
        self.sellerTotalView.hidden = YES;
        self.sellerWaitPayView.hidden = NO;
        self.sellerWaitSendView.hidden = YES;
        self.sellerBackMoneyView.hidden = YES;
    }
    else if (sender == _orderSellerView.btnArr[2]){
        self.sellerTotalView.hidden = YES;
        self.sellerWaitPayView.hidden = YES;
        self.sellerWaitSendView.hidden = NO;
        self.sellerBackMoneyView.hidden = YES;
    } else if (sender == _orderSellerView.btnArr[3]){
        self.sellerTotalView.hidden = YES;
        self.sellerWaitPayView.hidden = YES;
        self.sellerWaitSendView.hidden = YES;
        self.sellerBackMoneyView.hidden = NO;
    }

}

#pragma mark - 初始化
#pragma mark - 卖家初始化
- (UIView *)sellerView{
    if (!_sellerView) {
        self.sellerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
        [self.view addSubview:_sellerView];
        
        NSArray *nameArr = @[@"全部",@"待付款",@"待发货",@"退款中"];
        self.orderSellerView = [[MSUOrderMenuView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40) titArr:nameArr];
        [_sellerView addSubview:_orderSellerView];
        _orderSellerView.backgroundColor = [UIColor whiteColor];
        _orderSellerView.lineView.frame = CGRectMake(30, 38, (WIDTH-60-20*3)/4, 2);
        for (UIButton *btn in _orderSellerView.btnArr) {
            [btn addTarget:self action:@selector(orderSellerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        self.sellerTotalView.hidden = NO;
    }
    return _sellerView;
}

- (MSUSellerTotalView *)sellerTotalView{
    if (!_sellerTotalView) {
        self.sellerTotalView = [[MSUSellerTotalView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104)];
        [self.sellerView addSubview:_sellerTotalView];
        _sellerTotalView.backgroundColor = BGLINECOLOR;
        _sellerTotalView.hidden = YES;
    }
    return _sellerTotalView;
}

- (MSUBackMoneyView *)sellerBackMoneyView{
    if (!_sellerBackMoneyView) {
        self.sellerBackMoneyView = [[MSUBackMoneyView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104)];
        [self.sellerView addSubview:_sellerBackMoneyView];
        _sellerBackMoneyView.backgroundColor = BGLINECOLOR;
        _sellerBackMoneyView.hidden = YES;
    }
    return _sellerBackMoneyView;
}

- (MSUSellerWaitPayView *)sellerWaitPayView{
    if (!_sellerWaitPayView) {
        self.sellerWaitPayView = [[MSUSellerWaitPayView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104)];
        [self.sellerView addSubview:_sellerWaitPayView];
        _sellerWaitPayView.backgroundColor = BGLINECOLOR;
        _sellerWaitPayView.hidden = YES;
    }
    return _sellerWaitPayView;
}

- (MSUSellerWaitSendView *)sellerWaitSendView{
    if (!_sellerWaitSendView) {
        self.sellerWaitSendView = [[MSUSellerWaitSendView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104)];
        [self.sellerView addSubview:_sellerWaitSendView];
        _sellerWaitSendView.backgroundColor = BGLINECOLOR;
        _sellerWaitSendView.hidden = YES;
    }
    return _sellerWaitSendView;
}

#pragma mark - 买家初始化
- (UIView *)buyerView{
    if (!_buyerView) {
        self.buyerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
        [self.view addSubview:_buyerView];
        
        NSArray *nameArr = @[@"全部",@"待付款",@"待收货",@"待评价"];
        self.orderBuyerView = [[MSUOrderMenuView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40) titArr:nameArr];
        [_buyerView addSubview:_orderBuyerView];
        _orderBuyerView.backgroundColor = [UIColor whiteColor];
        _orderBuyerView.lineView.frame = CGRectMake(30, 38, (WIDTH-60-20*3)/4, 2);
        for (UIButton *btn in _orderBuyerView.btnArr) {
            [btn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        self.totalView.hidden = NO;
    }
    return _buyerView;
}

- (MSUOrderTotaltView *)totalView{
    if (!_totalView) {
        self.totalView = [[MSUOrderTotaltView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104)];
        [_buyerView addSubview:_totalView];
        _totalView.backgroundColor = BGLINECOLOR;
        _totalView.delegate = self;
        _totalView.hidden = YES;
    }
    return _totalView;
}

- (MSUWaitPayView *)payView{
    if (!_payView) {
        self.payView = [[MSUWaitPayView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104)];
        [_buyerView addSubview:_payView];
        _payView.backgroundColor = BGLINECOLOR;
        _payView.delegate = self;
        _payView.hidden = YES;
    }
    return _payView;
}

- (MSUWaitRecieveView *)recieveView{
    if (!_recieveView) {
        self.recieveView = [[MSUWaitRecieveView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104)];
        [_buyerView addSubview:_recieveView];
        _recieveView.backgroundColor = BGLINECOLOR;
        _recieveView.delegate = self;
        _recieveView.hidden = YES;
    }
    return _recieveView;
}

- (MSUWaitCommentView *)commentView{
    if (!_commentView) {
        self.commentView = [[MSUWaitCommentView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104)];
        [_buyerView addSubview:_commentView];
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
