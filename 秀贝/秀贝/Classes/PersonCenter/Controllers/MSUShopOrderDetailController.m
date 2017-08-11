//
//  MSUShopOrderDetailController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopOrderDetailController.h"
#import "MSUHomeNavView.h"
#import "MSUStringTools.h"
#import "MSUPathTools.h"
#import "MSUPrefixHeader.pch"
#import "MSUDetailCenterView.h"
#import "MSUOrderTableCell.h"
#import "MSUDetailBottomView.h"
#import "MSURefundStatusController.h"

@interface MSUShopOrderDetailController ()


@end

@implementation MSUShopOrderDetailController

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
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:20];
    [self.view addSubview:nav];
    
    [self createContentView];
    
    [self createBottomView];
    
}

- (void)createContentView{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    bgView.backgroundColor = BGLINECOLOR;
    [self.view addSubview:bgView];
    
    UIImageView *wolfIma = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    wolfIma.image = [MSUPathTools showImageWithContentOfFileByName:@""];
    wolfIma.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:wolfIma];
    
    UILabel *statusLab = [[UILabel alloc] init];
    statusLab.frame = CGRectMake(0, 80, WIDTH, 20);
    statusLab.textAlignment = NSTextAlignmentCenter;
    statusLab.text = @"已发货,待收货。";
    statusLab.textColor = [UIColor whiteColor];
    statusLab.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:statusLab];


    MSUDetailCenterView *centerView = [[MSUDetailCenterView alloc] initWithFrame:CGRectMake(0, 130, WIDTH, 142)];
    [bgView addSubview:centerView];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.nickLab.text = @"叶叶叶叶叶子";
    centerView.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect rect = [MSUStringTools danamicGetHeightFromText:centerView.shopNameLab.text WithWidth:WIDTH font:16];
    centerView.shopNameLab.frame = CGRectMake(95, 4, WIDTH-105-10-10, rect.size.height);
    centerView.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.88"];
    centerView.numLab.text = [NSString stringWithFormat:@"x%@",@"1"];
    centerView.sizeLab.text = [NSString stringWithFormat:@"颜色分类:%@ 尺码:%@",@"红底",@"（80-100斤）160码"];
    
    NSString *a = @"浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市江干区迪凯银座1301";
    CGRect arect = [MSUStringTools danamicGetHeightFromText:a WithWidth:WIDTH font:16];
    MSUDetailBottomView *bottomView = [[MSUDetailBottomView alloc] initWithFrame:CGRectMake(0, 130+142, WIDTH, 175+arect.size.height)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:bottomView];
    bottomView.reciUserLab.text = [NSString stringWithFormat:@"收货人 : %@  %@",@"张三",@"13925000003"];
    bottomView.headerLab.text = @"收货地址 : ";
    CGRect harect = [MSUStringTools danamicGetHeightFromText:bottomView.headerLab.text WithWidth:WIDTH font:16];
    bottomView.headerLab.frame = CGRectMake(10, 35, harect.size.width, harect.size.height);
    bottomView.reciAddressLab.text = a;
    bottomView.reciAddressLab.frame = CGRectMake(10+harect.size.width, 35, WIDTH-(20+harect.size.width), arect.size.height);
    bottomView.orderNumLab.text = [NSString stringWithFormat:@"订单编号 : %@",@"20170727010101010"];
    bottomView.timeLab.text = [NSString stringWithFormat:@"成交时间 : %@",@"2017-07-31 16:37:23"];
    bottomView.companyLab.text = [NSString stringWithFormat:@"快递公司 : %@",@"顺丰快递"];
    bottomView.expressLab.text = [NSString stringWithFormat:@"快递单号 : %@",@"13945781654"];
}

- (void)createBottomView{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, HEIGHT-50, WIDTH*0.5, 50);
    [backBtn setTitle:@"退货/换货" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(WIDTH*0.5, HEIGHT-50, WIDTH*0.5, 50);
    [sureBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    sureBtn.backgroundColor = [UIColor orangeColor];
    sureBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:sureBtn];
}

#pragma mark - 点击事件
- (void)backBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSURefundStatusController *refund = [[MSURefundStatusController alloc] init];
    [self.navigationController pushViewController:refund animated:YES];
}


@end
