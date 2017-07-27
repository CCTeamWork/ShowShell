//
//  MSUCommentTableViewCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUCommentTableViewCell : UITableViewCell

/// 头像
@property (nonatomic , strong) UIImageView *iconIma;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 时间
@property (nonatomic , strong) UILabel *timeLab;

/// 内容
@property (nonatomic , strong) UILabel *tittleLab;


@end
