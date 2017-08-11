//
//  MSURefundDetailView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSURefundDetailView : UIView

/// 退款方式
@property (nonatomic , strong) UILabel *funcLab;

/// 退款金额
@property (nonatomic , strong) UILabel *moneyLab;

/// 退款原因
@property (nonatomic , strong) UILabel *reasonLab;

/// 退款说明
@property (nonatomic , strong) UILabel *introLab;
@property (nonatomic , strong) UILabel *introReasonLab;

/// 凭证
@property (nonatomic , strong) UIImageView *imaView;
@property (nonatomic , strong) NSMutableArray *imaArr;

- (instancetype)initWithFrame:(CGRect)frame imaNum:(NSInteger)num;

@end
