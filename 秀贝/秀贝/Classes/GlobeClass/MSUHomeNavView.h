//
//  MSUHomeNavView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUHomeNavView : UIView

#pragma mark - 首页页面相关
/// 定位位置按钮
@property (nonatomic , strong) UIButton *LocationBtn;
/// 二维码扫描按钮
@property (nonatomic , strong) UIButton *scanBtn;
/// 首页搜索框按钮
@property (nonatomic , strong) UIButton *homeSearchBtn;

#pragma mark - 二维码页面相关
/// 返回箭头按钮
@property (nonatomic , strong) UIButton *arrowBtn;
/// 相册按钮
@property (nonatomic , strong) UIButton *photoBtn;

#pragma mark - 视频页面相关
/// 推荐、热点选择按钮
@property (nonatomic , strong) UIButton *titBtn;
/// 搜索按钮
@property (nonatomic , strong) UIButton *searchBtn;

#pragma mark - 城市定位页面相关
/// 取消按钮
@property (nonatomic , strong) UIButton *cancelBtn;

#pragma mark - 搜索页面相关
/// 搜索框按钮
@property (nonatomic , strong) UISearchBar *search;
/// 取消按钮
@property (nonatomic , strong) UIButton *searchCancleBtn;



/// 初始化
- (instancetype)initWithFrame:(CGRect)frame showNavWithNumber:(NSInteger)number;


@end
