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
#import "MSURefundCenterView.h"
#import "MSURefundSecondView.h"
#import "MSURefuncPopView.h"

#import "MSUStringTools.h"
#import "MSUPathTools.h"
#import "MSUPrefixHeader.pch"

@interface MSUReturnShopController ()

@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) UIView *redLineView;
@property (nonatomic , strong) MSURefundCenterView *centerView;
@property (nonatomic , strong) MSURefundSecondView *secondView;
@property (nonatomic , strong) MSURefuncPopView *popView;
@property (nonatomic , strong) MSURefuncPopView *pop1View;
@property (nonatomic , strong) MSURefuncPopView *statusPopView;

@property (nonatomic , strong) NSArray *reasonArr;
@property (nonatomic , strong) NSArray *statusArr;


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
    
    self.reasonArr = @[@"质量问题",@"与商品描述不符",@"不想要了"];
    self.statusArr = @[@"未收到货",@"已收到货"];

    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:21];
    [self.view addSubview:nav];
    
    [self createCenterView];
    
}

- (void)createCenterView{
    self.bgView = [[UIView alloc] init];
    _bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    _bgView.backgroundColor = BGLINECOLOR;
    [self.view addSubview:_bgView];
    
    MSUDetailCenterView *centerView = [[MSUDetailCenterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 142)];
    [_bgView addSubview:centerView];
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
        [_bgView addSubview:privateBtn];
        [privateBtn addTarget:self action:@selector(privateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.centerView.hidden = NO;
    self.secondView.hidden = YES;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(10, CGRectGetMaxY(centerView.frame)+10+40, WIDTH-20, 1);
    lineView.backgroundColor = BGLINECOLOR;
    [_bgView addSubview:lineView];
    
    self.redLineView = [[UIView alloc] init];
    _redLineView.frame = CGRectMake(WIDTH*0.5*0.5-35, CGRectGetMaxY(centerView.frame)+10+40, 70, 2);
    _redLineView.backgroundColor = [UIColor redColor];
    [_bgView addSubview:_redLineView];
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(0, HEIGHT-50, WIDTH, 50);
    [pushBtn setTitle:@"提交" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    pushBtn.backgroundColor = [UIColor redColor];
    pushBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:pushBtn];
    

}

- (void)privateBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _redLineView.frame = CGRectMake(WIDTH*0.5*0.5-35 + WIDTH*0.5*(sender.tag-2014), 142+10+40, 70, 2);
    }];
    
    self.popView.hidden = YES;
    self.pop1View.hidden = YES;
    self.statusPopView.hidden = YES;

    switch (sender.tag) {
        case 2014:
        {
            self.centerView.hidden = NO;
            self.secondView.hidden = YES;
        }
            break;
        case 2015:
        {
            self.centerView.hidden = YES;
            self.secondView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

- (void)reasonBtnClick:(UIButton *)sender{
    if ([sender.superview.superview.superview isKindOfClass:[MSURefundCenterView class]]) {
        self.popView.hidden = NO;
    } else if ([sender.superview.superview.superview isKindOfClass:[MSURefundSecondView class]]){
        self.pop1View.hidden = NO;
    }
}

- (void)popBtnClick:(UIButton *)sender{
    if ([sender.superview.superview isKindOfClass:[MSURefundCenterView class]]) {
        self.centerView.reasonLab.text = self.reasonArr[sender.tag-2013];
        self.popView.hidden = YES;
    } else if ([sender.superview.superview isKindOfClass:[MSURefundSecondView class]]){
        self.secondView.reasonLab.text = self.reasonArr[sender.tag-2013];
        self.pop1View.hidden = YES;
    }
    
}

- (void)statusBtnClick:(UIButton *)sender{
    self.statusPopView.hidden = NO;
}

- (void)statusPopBtnClick:(UIButton *)sender{
    self.secondView.statusLab.text = self.statusArr[sender.tag-2013];
    self.statusPopView.hidden = YES;
}


#pragma mark - 初始化
- (MSURefundCenterView *)centerView{
    if (!_centerView) {
        self.centerView = [[MSURefundCenterView alloc] initWithFrame:CGRectMake(0, 142+10+40, WIDTH, 120)];
        [_bgView addSubview:_centerView];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.hidden = YES;
        [_centerView.reasonBtn addTarget:self action:@selector(reasonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _centerView;
}

- (MSURefundSecondView *)secondView{
    if (!_secondView) {
        self.secondView = [[MSURefundSecondView alloc] initWithFrame:CGRectMake(0, 142+10+40, WIDTH, 120)];
        [_bgView addSubview:_secondView];
        _secondView.backgroundColor = [UIColor whiteColor];
        _secondView.hidden = YES;
        [_secondView.reasonBtn addTarget:self action:@selector(reasonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_secondView.statusBtn addTarget:self action:@selector(statusBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _secondView;
}

- (MSURefuncPopView *)popView{
    if (!_popView) {
        CGFloat popHeight = _reasonArr.count*30;
        self.popView = [[MSURefuncPopView alloc] initWithFrame:CGRectMake(10+70, 40, 140,popHeight) popHeight:popHeight arr:_reasonArr];
        [self.centerView addSubview:_popView];
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.hidden = YES;
        for (UIButton *btn in _popView.btnArr) {
            [btn addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _popView;
}

- (MSURefuncPopView *)pop1View{
    if (!_pop1View) {
        CGFloat popHeight = _reasonArr.count*30;
        self.pop1View = [[MSURefuncPopView alloc] initWithFrame:CGRectMake(10+70, 40, 140,popHeight) popHeight:popHeight arr:_reasonArr];
        [self.secondView addSubview:_pop1View];
        _pop1View.backgroundColor = [UIColor whiteColor];
        _pop1View.hidden = YES;
        for (UIButton *btn in _pop1View.btnArr) {
            [btn addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _pop1View;
}

- (MSURefuncPopView *)statusPopView{
    if (!_statusPopView) {
        CGFloat popHeight = _statusArr.count*30;
        self.statusPopView = [[MSURefuncPopView alloc] initWithFrame:CGRectMake(10+70, 40+40, 140,popHeight) popHeight:popHeight arr:_statusArr];
        [self.secondView addSubview:_statusPopView];
        _statusPopView.backgroundColor = [UIColor whiteColor];
        _statusPopView.hidden = YES;
        for (UIButton *btn in _statusPopView.btnArr) {
            [btn addTarget:self action:@selector(statusPopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _statusPopView;
}

@end
