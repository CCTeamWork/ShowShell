//
//  MSUCommentView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUCommentView : UIView

/// 评论标题
@property (nonatomic , strong) UILabel *titLab;

/// 内容
@property (nonatomic , strong) UITableView *tableView;

/// 全部评价
@property (nonatomic , strong) UIButton *allBtn;

/* 方法 */
- (instancetype)initWithFrame:(CGRect)frame tableViewHeight:(CGFloat)height;

@end
