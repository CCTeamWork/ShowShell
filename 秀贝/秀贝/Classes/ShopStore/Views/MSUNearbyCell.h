//
//  MSUNearbyCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/25.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface MSUNearbyCell : UITableViewCell

/// 头像
@property (nonatomic , strong) UIButton *iconBtn;

/// 昵称
@property (nonatomic , strong) UILabel *nickLab;

/// 时间
@property (nonatomic , strong) UILabel *timeLab;

/// 内容
@property (nonatomic , strong) UIView *tittleBGView;
@property (nonatomic , strong) UILabel *tittleLab;

/// 转发内容
@property (nonatomic , assign) BOOL isTranspod;
@property (nonatomic , strong) UILabel *transpodLab;

/// 视频
@property (nonatomic , strong) UIView *videoBGView;
@property (nonatomic , strong) UIImageView *videoImaView;
@property (nonatomic , strong) UIButton *playBtn;

/// 位置按钮
@property (nonatomic , assign) BOOL isLocation;
@property (nonatomic , strong) UIButton *locationBtn;
@property (nonatomic , strong) UIButton *dictanceBtn;

/// 阴影线
@property (nonatomic , strong) UIView *lineView;

/// 点赞
@property (nonatomic , strong) UIButton *likeBtn;

/// 评论
@property (nonatomic , strong) UIButton *commentBtn;

/// 转发
@property (nonatomic , strong) UIButton *transpodBtn;

/// 分享
@property (nonatomic , strong) UIButton *shareBtn;


@end
