//
//  MSURefundDetailView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSURefundDetailView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@implementation MSURefundDetailView

- (instancetype)initWithFrame:(CGRect)frame imaNum:(NSInteger)num
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithImaNum:num];
        
    }
    return self;
}


- (void)createViewWithImaNum:(NSInteger)num{
    /// 退款方式
    self.funcLab = [[UILabel alloc] init];
    _funcLab.textColor = [UIColor blackColor];
    _funcLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_funcLab];
    [_funcLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];
    
    /// 退款金额
    self.moneyLab = [[UILabel alloc] init];
    _moneyLab.textColor = [UIColor blackColor];
    _moneyLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_moneyLab];
    [_moneyLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_funcLab.bottom).offset(5);
        make.left.equalTo(_funcLab.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];
    
    /// 退款原因
    self.reasonLab = [[UILabel alloc] init];
    _reasonLab.textColor = [UIColor blackColor];
    _reasonLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_reasonLab];
    [_reasonLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLab.bottom).offset(5);
        make.left.equalTo(_funcLab.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];
    
    /// 退款说明
    self.introLab = [[UILabel alloc] init];
    _introLab.textColor = [UIColor blackColor];
    _introLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_introLab];

    self.introReasonLab = [[UILabel alloc] init];
    _introReasonLab.textColor = [UIColor blackColor];
    _introReasonLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_introReasonLab];
 
    // 凭证
    UILabel *proofLab = [[UILabel alloc] init];
    proofLab.textColor = [UIColor blackColor];
    proofLab.text = @"凭证 : ";
    proofLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:proofLab];
    [proofLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introLab.bottom).offset(5);
        make.left.equalTo(_funcLab.left).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(20);
    }];

    for (NSInteger i = 0; i < num; i++) {
        UIImageView *wolfIma = [[UIImageView alloc] init];
        wolfIma.backgroundColor = [UIColor orangeColor];
        [self addSubview:wolfIma];
        [wolfIma makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(proofLab.top).offset(3);
            make.left.equalTo(proofLab.right).offset(10+i*(70+5));
            make.width.equalTo(70);
            make.height.equalTo(70);
        }];
        [self.imaArr addObject:wolfIma];
    }
    
}

- (NSMutableArray *)imaArr{
    if (!_imaArr) {
        self.imaArr = [NSMutableArray array];
    }
    return _imaArr;
}


@end
