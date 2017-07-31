//
//  MSUSearchUserView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSearchUserView : UIView

/// 背景滚动视图
@property (nonatomic , strong) UIScrollView *bgScrollView;
/// 列表视图
@property (nonatomic , strong) UITableView *userTableView;


/* 方法 */
- (instancetype)initWithFrame:(CGRect)frame tableHeight:(CGFloat)height;

@end
