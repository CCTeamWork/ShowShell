//
//  MSUHomeCollectionCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/20.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUHomeCollectionCell : UICollectionViewCell

/// 视频页面
@property (nonatomic,strong)UIImageView *imageView;

/// 昵称
@property (nonatomic,strong)UILabel *titleLabel;

/// 头像
@property (nonatomic , strong) UIImageView *iconImage;

/// 按钮点击
@property (nonatomic , strong) UIButton *publisherBtn;

/// 点赞
@property (nonatomic , strong) UIButton *likeBtn;

/// 点赞数
@property (nonatomic , strong) UILabel *likeNumLab;

@end
