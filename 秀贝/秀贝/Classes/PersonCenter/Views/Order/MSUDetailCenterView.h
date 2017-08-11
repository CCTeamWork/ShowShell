//
//  MSUDetailCenterView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUDetailCenterView : UIView

/// 头像
@property (nonatomic , strong) UIImageView *iconIma;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 商品图片
@property (nonatomic , strong) UIImageView *shopIma;

/// 商品名字
@property (nonatomic , strong) UILabel *shopNameLab;

/// 规格
@property (nonatomic , strong) UILabel *sizeLab;;

/// 商品价格
@property (nonatomic , strong) UILabel *priceLab;

/// 商品数量
@property (nonatomic , strong) UILabel *numLab;



@end
