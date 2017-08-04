//
//  MSUTranspodTableCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUTranspodTableCell : UITableViewCell

/// 图片
@property (nonatomic , strong) UIImageView *iconImaView;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 正文
@property (nonatomic , strong) UILabel *contentLab;

@end
