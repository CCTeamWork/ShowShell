//
//  MSUPublishView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUPublishView : UIView

/// 头像
@property (nonatomic , strong) UIImageView *iconIma;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 状态
@property (nonatomic , strong) UILabel *statusLab;

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 交易时间
@property (nonatomic , strong) UILabel *timeLab;



@end
