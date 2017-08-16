//
//  MSUSearchTotalView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSearchTotalView : UIView

/// 背景滚动视图
@property (nonatomic , strong) UIScrollView *bgScrollView;

/// 相关用户
@property (nonatomic , strong) UILabel *userLab;
@property (nonatomic , strong) UIButton *userBtn;
@property (nonatomic , strong) UIButton *moreUserBtn;
@property (nonatomic , strong) UIButton *moreVideoBtn;
@property (nonatomic , strong) UIButton *moreShopBtn;

/// 个别人
@property (nonatomic , strong) UIButton *iconBtn;
@property (nonatomic , strong) UILabel *userNickLab;
@property (nonatomic , strong) UILabel *introLab;
@property (nonatomic , strong) UIButton *attenBtn;

/// 相关用户头像
@property (nonatomic , strong) UIButton *infoBtn;
@property (nonatomic , strong) NSMutableArray *infoArr;

/// 箭头
@property (nonatomic , strong) UIButton *arrowBtn;

/// 动态
@property (nonatomic , strong) UITableView *danamicTableView;

/// 底部热卖
@property (nonatomic , strong) UITableView *hotTableView;

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)arr tableHeight:(CGFloat)height;
@end
