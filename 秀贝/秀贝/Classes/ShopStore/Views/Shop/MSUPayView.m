//
//  MSUPayView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPayView.h"
#import "MSUPathTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]


//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUPayView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    // 选择支付方式
    UILabel *chooseLab = [[UILabel alloc] init];
    chooseLab.text = @"选择支付方式";
    chooseLab.font = [UIFont systemFontOfSize:16];
    [chooseLab setTextColor:[UIColor blackColor]];
    [self addSubview:chooseLab];
    [chooseLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(20);
    }];
    
#pragma mark - 支付宝
    // 支付宝
    UIImageView *wolfIma = [[UIImageView alloc] init];
    wolfIma.image = [MSUPathTools showImageWithContentOfFileByName:@"icon-z"];
    [self addSubview:wolfIma];
    [wolfIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseLab.bottom).offset(5);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    UILabel *aliLab = [[UILabel alloc] init];
    aliLab.text = @"支付宝";
    aliLab.font = [UIFont systemFontOfSize:16];
    aliLab.textColor = [UIColor blackColor];
    [self addSubview:aliLab];
    [aliLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wolfIma.top).offset(0);
        make.left.equalTo(wolfIma.right).offset(10);
        make.width.equalTo(60);
        make.height.equalTo(40);
    }];
    
    // 第一个圈圈
    self.firstCicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstCicBtn.backgroundColor = [UIColor redColor];
    [_firstCicBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateNormal];
    [_firstCicBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateSelected];
    [self addSubview:_firstCicBtn];
    [_firstCicBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wolfIma.top).offset(5);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];

    // 第一条线
    UIView *firstLineView = [[UIView alloc] init];
    firstLineView.backgroundColor = BGLINECOLOR;
    [self addSubview:firstLineView];
    [firstLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wolfIma.bottom).offset(5);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(SelfWidth-30);
        make.height.equalTo(1);
    }];

#pragma mark - 微信
    // 微信
    UIImageView *weIma = [[UIImageView alloc] init];
    weIma.image = [MSUPathTools showImageWithContentOfFileByName:@"icon-z"];
    [self addSubview:weIma];
    [weIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstLineView.bottom).offset(5);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    UILabel *weLab = [[UILabel alloc] init];
    weLab.text = @"微信";
    weLab.font = [UIFont systemFontOfSize:16];
    weLab.textColor = [UIColor blackColor];
    [self addSubview:weLab];
    [weLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weIma.top).offset(0);
        make.left.equalTo(weIma.right).offset(10);
        make.width.equalTo(60);
        make.height.equalTo(40);
    }];
    
    // 第二个圈圈
    self.secondCicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _secondCicBtn.backgroundColor = [UIColor redColor];
    [_secondCicBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateNormal];
    [_secondCicBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateSelected];
    [self addSubview:_secondCicBtn];
    [_secondCicBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weIma.top).offset(5);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
    
    // 第二条线
    UIView *secLineView = [[UIView alloc] init];
    secLineView.backgroundColor = BGLINECOLOR;
    [self addSubview:secLineView];
    [secLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weIma.bottom).offset(5);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(SelfWidth-30);
        make.height.equalTo(1);
    }];

#pragma mark - 秀贝
    // 秀贝
    UIImageView *showIma = [[UIImageView alloc] init];
    showIma.image = [MSUPathTools showImageWithContentOfFileByName:@"icon-z"];
    [self addSubview:showIma];
    [showIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secLineView.bottom).offset(5);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    UILabel *showLab = [[UILabel alloc] init];
    showLab.text = @"钱包";
    showLab.font = [UIFont systemFontOfSize:16];
    showLab.textColor = [UIColor blackColor];
    [self addSubview:showLab];
    [showLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showIma.top).offset(0);
        make.left.equalTo(showIma.right).offset(10);
        make.width.equalTo(60);
        make.height.equalTo(40);
    }];
    
    // 第三个圈圈
    self.thirdCicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _thirdCicBtn.backgroundColor = [UIColor redColor];
    [_thirdCicBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateNormal];
    [_thirdCicBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateSelected];
    [self addSubview:_thirdCicBtn];
    [_thirdCicBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showIma.top).offset(5);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
    
    // 第三条线
    UIView *thirdLineView = [[UIView alloc] init];
    thirdLineView.backgroundColor = BGLINECOLOR;
    [self addSubview:thirdLineView];
    [thirdLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showIma.bottom).offset(5);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(SelfWidth-30);
        make.height.equalTo(1);
    }];

    
    
}

@end
