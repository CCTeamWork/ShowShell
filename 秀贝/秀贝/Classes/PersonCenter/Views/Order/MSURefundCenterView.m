//
//  MSURefundCenterView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/11.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSURefundCenterView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUPathTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@interface MSURefundCenterView ()<UITextViewDelegate>

@property (nonatomic , strong) UITextView *textView;

@end

@implementation MSURefundCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(300);
    }];
    
    // 退款原因
    UILabel *reasonTitLab = [[UILabel alloc] init];
    reasonTitLab.text = @"退款原因 : ";
    reasonTitLab.textColor = [UIColor blackColor];
    reasonTitLab.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:reasonTitLab];
    [reasonTitLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(10);
        make.left.equalTo(bgView.left).offset(10);
        make.width.equalTo(70);
        make.height.equalTo(30);
    }];
    
    UIView *reasonView = [[UIView alloc] init];
    reasonView.backgroundColor = [UIColor whiteColor];
    reasonView.layer.borderWidth = 1;
    reasonView.layer.borderColor = BGLINECOLOR.CGColor;
    [bgView addSubview:reasonView];
    [reasonView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(reasonTitLab.centerY).offset(0);
        make.left.equalTo(reasonTitLab.right).offset(0);
        make.width.equalTo(140);
        make.height.equalTo(30);
    }];
    
    self.reasonLab = [[UILabel alloc] init];
    _reasonLab.text = @"退款原因";
    _reasonLab.textColor = [UIColor blackColor];
    _reasonLab.font = [UIFont systemFontOfSize:14];
    [reasonView addSubview:_reasonLab];
    [_reasonLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(reasonTitLab.centerY).offset(0);
        make.left.equalTo(reasonView.left).offset(10);
        make.width.equalTo(100);
        make.height.equalTo(30);
    }];
    
    UIImageView *wolfIma = [[UIImageView alloc] init];
    wolfIma.image = nil;
    wolfIma.contentMode = UIViewContentModeScaleAspectFit;
    wolfIma.backgroundColor = [UIColor brownColor];
    [bgView addSubview:wolfIma];
    [wolfIma makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(reasonTitLab.centerY).offset(0);
        make.right.equalTo(reasonView.right).offset(-10);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
    self.reasonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reasonBtn.backgroundColor = [UIColor clearColor];
    _reasonBtn.adjustsImageWhenHighlighted = NO;
    [reasonView addSubview:_reasonBtn];
    [_reasonBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(reasonTitLab.centerY).offset(0);
        make.left.equalTo(reasonTitLab.right).offset(0);
        make.width.equalTo(140);
        make.height.equalTo(30);
    }];

    
    // 退款金额
    UILabel *moneyTitLab = [[UILabel alloc] init];
    moneyTitLab.text = @"退款金额 : ";
    moneyTitLab.textColor = [UIColor blackColor];
    moneyTitLab.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:moneyTitLab];
    [moneyTitLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(reasonTitLab.bottom).offset(10);
        make.left.equalTo(bgView.left).offset(10);
        make.width.equalTo(70);
        make.height.equalTo(30);
    }];
    
    UIView *moneyView = [[UIView alloc] init];
    moneyView.backgroundColor = [UIColor whiteColor];
    moneyView.layer.borderWidth = 1;
    moneyView.layer.borderColor = BGLINECOLOR.CGColor;
    [bgView addSubview:moneyView];
    [moneyView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyTitLab.centerY).offset(0);
        make.left.equalTo(moneyTitLab.right).offset(0);
        make.width.equalTo(140);
        make.height.equalTo(30);
    }];
    
    UILabel *moneyLab = [[UILabel alloc] init];
    moneyLab.text = @"¥88.80";
    moneyLab.textColor = [UIColor grayColor];
    moneyLab.font = [UIFont systemFontOfSize:14];
    [moneyView addSubview:moneyLab];
    [moneyLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyTitLab.centerY).offset(0);
        make.left.equalTo(moneyView.left).offset(10);
        make.width.equalTo(100);
        make.height.equalTo(30);
    }];
    
    UILabel *introLab = [[UILabel alloc] init];
    introLab.text = @"最多88.80元，含运费:6元。";
    introLab.textColor = [UIColor grayColor];
    introLab.font = [UIFont systemFontOfSize:10];
    [bgView addSubview:introLab];
    [introLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyTitLab.centerY).offset(0);
        make.left.equalTo(moneyView.right).offset(10);
        make.width.equalTo(140);
        make.height.equalTo(30);
    }];

    // 退款说明
    UILabel *reIntroTitLab = [[UILabel alloc] init];
    reIntroTitLab.text = @"退款说明 : ";
    reIntroTitLab.textColor = [UIColor blackColor];
    reIntroTitLab.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:reIntroTitLab];
    [reIntroTitLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyTitLab.bottom).offset(10);
        make.left.equalTo(bgView.left).offset(10);
        make.width.equalTo(70);
        make.height.equalTo(30);
    }];
    
    self.textView = [[UITextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.delegate = self;
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = BGLINECOLOR.CGColor;
    _textView.textColor = [UIColor blackColor];
    [bgView addSubview:_textView];
    [_textView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(reIntroTitLab.top).offset(0);
        make.left.equalTo(reIntroTitLab.right).offset(0);
        make.width.equalTo(SelfWidth-10-70-20);
        make.height.equalTo(100);
    }];
    
    // 上传凭证
    UILabel *publishTitLab = [[UILabel alloc] init];
    publishTitLab.text = @"上传凭证 : ";
    publishTitLab.textColor = [UIColor blackColor];
    publishTitLab.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:publishTitLab];
    [publishTitLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.bottom).offset(10);
        make.left.equalTo(bgView.left).offset(10);
        make.width.equalTo(70);
        make.height.equalTo(30);
    }];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor orangeColor];
//    [addBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"location_back_icon"] forState:UIControlStateNormal];
    addBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:addBtn];
    [addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(publishTitLab.bottom).offset(0);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(60);
        make.height.equalTo(60);
    }];
}


@end
