//
//  MSURefundStatusController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSURefundStatusController.h"
#import "MSUHomeNavView.h"
#import "MSUStringTools.h"
#import "MSUPathTools.h"
#import "MSUPrefixHeader.pch"
#import "MSURefundDetailView.h"
#import "MSUDetailCenterView.h"
#import "MSUDetailBottomView.h"


@interface MSURefundStatusController ()

@end

@implementation MSURefundStatusController

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
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:22];
    [self.view addSubview:nav];
    
    [self createContentView];
}

- (void)createContentView{
    UIScrollView *bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    bgView.scrollEnabled = YES;
    bgView.backgroundColor = BGLINECOLOR;
    bgView.showsHorizontalScrollIndicator = NO;
    bgView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:bgView];
    
    UIImageView *wolfIma = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    wolfIma.image = [MSUPathTools showImageWithContentOfFileByName:@""];
    wolfIma.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:wolfIma];
    
    UILabel *statusLab = [[UILabel alloc] init];
    statusLab.frame = CGRectMake(0, 80, WIDTH, 20);
    statusLab.textAlignment = NSTextAlignmentCenter;
    statusLab.text = @"退款已同意,等待退款中。";
    statusLab.textColor = [UIColor whiteColor];
    statusLab.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:statusLab];
    
    // 如果有图片 frame为此值，如果没有图片 减掉40  再次表明，接接口记得判断
    MSURefundDetailView *detail = [[MSURefundDetailView alloc] initWithFrame:CGRectMake(0, 130, WIDTH, 160+30) imaNum:2];
    detail.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:detail];
    
    // 退款方式
    NSString *a = @"仅退款";
    detail.funcLab.attributedText = [MSUStringTools makeKeyWordAttributedWithSubText:a inOrigiText:[NSString stringWithFormat:@"退款方式 : %@",a] font:14 color:[UIColor orangeColor]];
    // 退款金额
    NSString *b = [NSString stringWithFormat:@"¥%@",@"88.80"];
    detail.moneyLab.attributedText = [MSUStringTools makeKeyWordAttributedWithSubText:b inOrigiText:[NSString stringWithFormat:@"退款金额 : %@",b] font:14 color:[UIColor orangeColor]];
    // 退款原因
    detail.reasonLab.text = [NSString stringWithFormat:@"退款原因 : %@",@"产品质量"];
    // 退款说明
    detail.introLab.text = @"退款说明 : ";
    CGRect arect = [MSUStringTools danamicGetHeightFromText:detail.introLab.text WithWidth:WIDTH font:14];
    detail.introLab.frame = CGRectMake(10, 85, arect.size.width, arect.size.height);
    detail.introReasonLab.text = @"外观破损,要求退款";
    CGRect brect = [MSUStringTools danamicGetHeightFromText:detail.introReasonLab.text WithWidth:WIDTH font:14];
    detail.introReasonLab.frame = CGRectMake(10+arect.size.width, 85, WIDTH-(20+arect.size.width), brect.size.height);

    MSUDetailCenterView *centerView = [[MSUDetailCenterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detail.frame)+10, WIDTH, 142)];
    [bgView addSubview:centerView];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.nickLab.text = @"叶叶叶叶叶子";
    centerView.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect rect = [MSUStringTools danamicGetHeightFromText:centerView.shopNameLab.text WithWidth:WIDTH font:16];
    centerView.shopNameLab.frame = CGRectMake(95, 4, WIDTH-105-10-10, rect.size.height);
    centerView.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.88"];
    centerView.numLab.text = [NSString stringWithFormat:@"x%@",@"1"];
    centerView.sizeLab.text = [NSString stringWithFormat:@"颜色分类:%@ 尺码:%@",@"红底",@"（80-100斤）160码"];
    
    NSString *aa = @"浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市江干区迪凯银座1301";
    CGRect aarect = [MSUStringTools danamicGetHeightFromText:a WithWidth:WIDTH font:16];
    MSUDetailBottomView *bottomView = [[MSUDetailBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(centerView.frame), WIDTH, 175+arect.size.height-65)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:bottomView];
    bottomView.reciUserLab.text = [NSString stringWithFormat:@"收货人 : %@  %@",@"张三",@"13925000003"];
    bottomView.headerLab.text = @"收货地址 : ";
    CGRect harect = [MSUStringTools danamicGetHeightFromText:bottomView.headerLab.text WithWidth:WIDTH font:16];
    bottomView.headerLab.frame = CGRectMake(10, 35, harect.size.width, harect.size.height);
    bottomView.reciAddressLab.text = aa;
    bottomView.reciAddressLab.frame = CGRectMake(10+harect.size.width, 35, WIDTH-(20+harect.size.width), aarect.size.height);
    bottomView.orderNumLab.text = [NSString stringWithFormat:@"订单编号 : %@",@"20170727010101010"];
    bottomView.timeLab.text = [NSString stringWithFormat:@"成交时间 : %@",@"2017-07-31 16:37:23"];
//    bottomView.companyLab.text = [NSString stringWithFormat:@"快递公司 : %@",@"顺丰快递"];
//    bottomView.expressLab.text = [NSString stringWithFormat:@"快递单号 : %@",@"13945781654"];
    bottomView.companyLab.hidden = YES;
    bottomView.expressLab.hidden = YES;
    
    UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    privateBtn.frame = CGRectMake(WIDTH*0.5, CGRectGetMaxY(bottomView.frame)+10, WIDTH*0.5, 50);
    [privateBtn setTitle:@"同意申请" forState:UIControlStateNormal];
    [privateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    privateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    privateBtn.backgroundColor = [UIColor orangeColor];
    privateBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:privateBtn];
    
    bgView.contentSize = CGSizeMake(0, CGRectGetMaxY(privateBtn.frame)+40);

}

@end
