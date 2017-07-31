//
//  MSUSearchUserTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSearchUserTableCell : UITableViewCell

/// 头像
@property (nonatomic , strong) UIButton *iconBtn;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 简介
@property (nonatomic , strong) UILabel *introLab;

/// 关注
@property (nonatomic , strong) UIButton *attenBtn;;

@end
