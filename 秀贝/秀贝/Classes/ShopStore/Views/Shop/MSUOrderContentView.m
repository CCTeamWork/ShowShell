//
//  MSUOrderContentView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUOrderContentView.h"
#import "MSUStringTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUOrderContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    // 第一条背景图
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor whiteColor];
    [self addSubview:firstView];
    [firstView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(40);
    }];

    // 运费
    UILabel *frightLab = [[UILabel alloc] init];
    frightLab.text = @"运费:";
    frightLab.font = [UIFont systemFontOfSize:14];
    [firstView addSubview:frightLab];
    [frightLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.top).offset(0);
        make.left.equalTo(firstView.left).offset(15);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(40);
    }];
    
    // 金额
    self.numLab = [[UILabel alloc] init];
    _numLab.font = [UIFont systemFontOfSize:14];
    _numLab.textAlignment = NSTextAlignmentRight;
    [firstView addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.top).offset(0);
        make.right.equalTo(firstView.right).offset(-10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(40);
    }];
    
    // 第二条背景图
    UIView *secondView = [[UIView alloc] init];
    secondView.backgroundColor = [UIColor whiteColor];
    [self addSubview:secondView];
    [secondView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.bottom).offset(15);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(40);
    }];
    
    // 添加收货地址
    UILabel *addressLab = [[UILabel alloc] init];
    addressLab.attributedText = [MSUStringTools changeLabelWithText:@"+添加收货地址" AndFromOrigiFont:14 toChangeFont:14 AndFromOrigiLoca:1 WithBeforePart:0];
    addressLab.font = [UIFont systemFontOfSize:14];
    [secondView addSubview:addressLab];
    [addressLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.top).offset(0);
        make.left.equalTo(secondView.left).offset(15);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(40);
    }];
    
    self.addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addAddressBtn.backgroundColor = [UIColor clearColor];
    _addAddressBtn.adjustsImageWhenHighlighted = NO;
    [secondView addSubview:_addAddressBtn];
    [_addAddressBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.top).offset(0);
        make.left.equalTo(secondView.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(40);
    }];
    
    // 第三个ciew
    UIView *thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = [UIColor whiteColor];
    [self addSubview:thirdView];
    [thirdView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.bottom).offset(15);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(40);
    }];
    
    // 买家留言
    UILabel *messageLab = [[UILabel alloc] init];
    messageLab.text = @"买家留言";
    messageLab.font = [UIFont systemFontOfSize:14];
    [thirdView addSubview:messageLab];
    [messageLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdView.top).offset(0);
        make.left.equalTo(thirdView.left).offset(15);
        make.width.equalTo(70);
        make.height.equalTo(40);
    }];

    // 合计
    self.totalLab = [[UILabel alloc] init];
    _totalLab.font = [UIFont systemFontOfSize:14];
    _totalLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:_totalLab];
    [_totalLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(40);
    }];

    
}


@end
