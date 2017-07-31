//
//  MSUSearchTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSearchTableCell : UITableViewCell

/// 小搜索图标
@property (nonatomic , strong) UIImageView *searIma;

/// 搜索记录
@property (nonatomic , strong) UILabel *searLab;

/// 叉叉图标
@property (nonatomic , strong) UIImageView *forkIma;

/* 初始化 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier historyNum:(NSInteger)num;

@end
