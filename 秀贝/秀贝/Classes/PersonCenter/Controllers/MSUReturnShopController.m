//
//  MSUReturnShopController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUReturnShopController.h"
#import "MSUHomeNavView.h"
#import "MSUDetailCenterView.h"

#import "MSUStringTools.h"
#import "MSUPathTools.h"
#import "MSUPrefixHeader.pch"

@interface MSUReturnShopController ()

@property (nonatomic , strong) UIView *redLineView;

@end

@implementation MSUReturnShopController

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
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:21];
    [self.view addSubview:nav];
    
    [self createCenterView];
    
}

- (void)createCenterView{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    bgView.backgroundColor = BGLINECOLOR;
    [self.view addSubview:bgView];
    
    MSUDetailCenterView *centerView = [[MSUDetailCenterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 142)];
    [bgView addSubview:centerView];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.nickLab.text = @"叶叶叶叶叶子";
    centerView.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect rect = [MSUStringTools danamicGetHeightFromText:centerView.shopNameLab.text WithWidth:WIDTH font:16];
    centerView.shopNameLab.frame = CGRectMake(95, 4, WIDTH-105-10-10, rect.size.height);
    centerView.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.88"];
    centerView.priceLab.textColor = [UIColor redColor];
    centerView.numLab.text = [NSString stringWithFormat:@"x%@",@"1"];
    centerView.sizeLab.text = [NSString stringWithFormat:@"颜色分类:%@ 尺码:%@",@"红底",@"（80-100斤）160码"];
    
    NSArray *titArr = @[@"退货退款",@"仅退款"];
    for (NSInteger i = 0; i < titArr.count; i++) {
        UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        privateBtn.frame = CGRectMake(WIDTH*0.5*i, CGRectGetMaxY(centerView.frame)+10, WIDTH*0.5, 40);
        [privateBtn setTitle:titArr[i] forState:UIControlStateNormal];
        [privateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        privateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        privateBtn.backgroundColor = [UIColor whiteColor];
        privateBtn.tag = 2014+i;
        privateBtn.adjustsImageWhenHighlighted = NO;
        [bgView addSubview:privateBtn];
        [privateBtn addTarget:self action:@selector(privateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(10, CGRectGetMaxY(centerView.frame)+10+40, WIDTH-20, 1);
    lineView.backgroundColor = BGLINECOLOR;
    [bgView addSubview:lineView];
    
    self.redLineView = [[UIView alloc] init];
    _redLineView.frame = CGRectMake(WIDTH*0.5*0.5-35, CGRectGetMaxY(centerView.frame)+10+40, 70, 2);
    _redLineView.backgroundColor = [UIColor redColor];
    [bgView addSubview:_redLineView];
    

}

- (void)privateBtnClick:(UIButton *)sender{
    _redLineView.frame = CGRectMake(WIDTH*0.5*0.5-35 + WIDTH*0.5*(sender.tag-2014), 142+10+40, 70, 2);

}



@end
