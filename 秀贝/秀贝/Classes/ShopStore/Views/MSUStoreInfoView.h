//
//  MSUStoreInfoView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUStoreInfoView : UIView

/// 店铺头像
@property (nonatomic , strong) UIButton *imaBtn;

/// 店铺昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 关注按钮
@property (nonatomic , strong) UIButton *attentionBtn;

/// 关注人数
@property (nonatomic , strong) UILabel *attNumLab;
@property (nonatomic , strong) UIButton *attNumBtn;

/// 商品数量
@property (nonatomic , strong) UILabel *shopNumLab;
@property (nonatomic , strong) UIButton *shopNumBtn;

@end
