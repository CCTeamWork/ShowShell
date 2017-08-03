//
//  MSUVideoDetailCommentView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUVideoDetailCommentView : UIView

/// 评论标题
@property (nonatomic , strong) UILabel *titLab;

/// 内容
@property (nonatomic , strong) UITableView *tableView;


/* 方法 */
- (instancetype)initWithFrame:(CGRect)frame tableViewHeight:(CGFloat)height;

@end
