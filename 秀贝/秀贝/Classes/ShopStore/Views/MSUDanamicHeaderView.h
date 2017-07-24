//
//  MSUDanamicHeaderView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>
//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface MSUDanamicHeaderView : UIView

/// 附近的人视图
@property (nonatomic , strong) UIView *nearbyView;

/// 附近的人点击按钮
@property (nonatomic , strong) UIButton *nearbyBtn;

/// 第一个头像
@property (nonatomic , strong) UIImageView *firstImaView;
/// 第二个头像
@property (nonatomic , strong) UIImageView *secondImaView;
/// 第三个头像
@property (nonatomic , strong) UIImageView *thirdImaView;

// 初始化
- (instancetype)initWithFrame:(CGRect)frame isAttention:(BOOL)attention;

@end
