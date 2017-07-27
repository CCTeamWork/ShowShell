//
//  MSUNearbyCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/25.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUNearbyCell.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SLIVERYCOLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:241/255.0 alpha:1.0]

@implementation MSUNearbyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    // 头像
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.layer.cornerRadius = 25;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.contentView addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(5);
        make.left.equalTo(self.contentView.left).offset(10);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(5);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfContentWidth * 0.5);
        make.height.equalTo(30);
    }];
    
    // 时间
    self.timeLab = [[UILabel alloc] init];
    [_timeLab setTextColor:[UIColor grayColor]];
    //    _timeLab.backgroundColor = [UIColor redColor];
    _timeLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.bottom).offset(-8);
        make.left.equalTo(_nickLab.left).offset(0);
        make.width.equalTo(SelfContentWidth * 0.5);
        make.height.equalTo(20);
    }];

    // 转发评论
    self.transpodLab = [[UILabel alloc] init];
    //    _tittleLab.backgroundColor = [UIColor yellowColor];
    _transpodLab.font = [UIFont systemFontOfSize:12];
    _transpodLab.numberOfLines = 0;
    [self.contentView addSubview:_transpodLab];
    
    /* 正文内容相关 */
    // 正文背景
    self.tittleBGView = [[UIView alloc] init];
    [self addSubview:_tittleBGView];
    
    // 正文内容
    self.tittleLab = [[UILabel alloc] init];
    //    _tittleLab.backgroundColor = [UIColor yellowColor];
    _tittleLab.font = [UIFont systemFontOfSize:12];
    _tittleLab.numberOfLines = 0;
    [_tittleBGView addSubview:_tittleLab];
    
    /* 视频相关 */
    // 视图背景
    self.videoBGView = [[UIView alloc] init];
    [self addSubview:_videoBGView];
    
    // 视图图片
    self.videoImaView = [[UIImageView alloc] init];
    [_videoBGView addSubview:_videoImaView];
    _videoImaView.backgroundColor = [UIColor brownColor];
    [_videoImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_videoBGView.top).offset(10);
        make.left.equalTo(_videoBGView.left).offset(10);
        make.right.equalTo(_videoBGView.right).offset(-10);
        make.height.equalTo(200);
    }];
    
    // 视图播放按钮
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.backgroundColor = [UIColor blueColor];
    [_videoBGView addSubview:_playBtn];
    [_playBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_videoBGView.center).offset(0);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    
    // 位置图标
    self.locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _locationBtn.backgroundColor = [UIColor blueColor];
    _locationBtn.layer.cornerRadius = 10;
    _locationBtn.layer.shouldRasterize = YES;
    _locationBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _locationBtn.layer.borderWidth = 1;
    _locationBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:_locationBtn];
    [_locationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_videoBGView.bottom).offset(5);
        make.left.equalTo(_videoImaView.left).offset(0);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];
    
    // 位置图标
    self.dictanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dictanceBtn.backgroundColor = [UIColor yellowColor];
    _dictanceBtn.layer.cornerRadius = 10;
    _dictanceBtn.layer.shouldRasterize = YES;
    _dictanceBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _dictanceBtn.layer.borderWidth = 1;
    _dictanceBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:_dictanceBtn];
    [_dictanceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationBtn.top).offset(0);
        make.left.equalTo(_locationBtn.right).offset(5);
        make.width.equalTo(50);
        make.height.equalTo(25);
    }];
    
    // 阴影线
    self.lineView = [[UIView alloc] init];
    _lineView.backgroundColor = SLIVERYCOLOR;
    [self addSubview:_lineView];
    
    // 点赞按钮
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    _likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [_likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:_likeBtn];
    [_likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth * 0.25);
        make.height.equalTo(40);
    }];
    
    // 评论按钮
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:_commentBtn];
    [_commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom).offset(0);
        make.left.equalTo(_likeBtn.right).offset(0);
        make.width.equalTo(SelfWidth * 0.25);
        make.height.equalTo(40);
    }];
    
    // 转发按钮
    self.transpodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_transpodBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    _transpodBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [_transpodBtn setTitle:@"转发" forState:UIControlStateNormal];
    [_transpodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _transpodBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _transpodBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:_transpodBtn];
    [_transpodBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom).offset(0);
        make.left.equalTo(_commentBtn.right).offset(0);
        make.width.equalTo(SelfWidth * 0.25);
        make.height.equalTo(40);
    }];
    
    // 分享按钮
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:_shareBtn];
    [_shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom).offset(0);
        make.left.equalTo(_transpodBtn.right).offset(0);
        make.width.equalTo(SelfWidth * 0.25);
        make.height.equalTo(40);
    }];
    
    // 底部阴影
    UIView *navView = [[UIView alloc] init];
    [self addSubview:navView];
    navView.backgroundColor = [UIColor colorWithRed:243/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shareBtn.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(20);
    }];

    
}

@end
