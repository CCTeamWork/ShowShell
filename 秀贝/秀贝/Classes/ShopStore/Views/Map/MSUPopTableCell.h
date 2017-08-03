//
//  MSUPopTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUPopTableCell : UITableViewCell

/// 头像
@property (nonatomic , strong) UIImageView *iconIma;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 介绍
@property (nonatomic , strong) UILabel *introLab;

/// 关注
@property (nonatomic , strong) UIButton *attenBtn;

/// 内容
@property (nonatomic , strong) UIButton *contentImaBtn;
@property (nonatomic , strong) NSMutableArray *imaBtnArr;

/* 初始化 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier popHeight:(CGFloat)height;

@end
