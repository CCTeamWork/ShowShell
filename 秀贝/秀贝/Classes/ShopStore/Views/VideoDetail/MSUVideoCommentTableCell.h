//
//  MSUVideoCommentTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUVideoCommentTableCell : UITableViewCell

/// 头像
@property (nonatomic , strong) UIButton *iconBtn;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 评论
@property (nonatomic , strong) UIButton *commentBtn;

/// 点赞
@property (nonatomic , strong) UIButton *likeBtn;

/// 内容
@property (nonatomic , strong) UILabel *commentLab;

/// 背景线
@property (nonatomic , strong) UIView *lineView;

/// 评论列表
@property (nonatomic , strong) UITableView *commentTableView;

//- (void)configCellWithModel:(MessageModel *)model indexPath:(NSIndexPath *)indexPath;


@end
