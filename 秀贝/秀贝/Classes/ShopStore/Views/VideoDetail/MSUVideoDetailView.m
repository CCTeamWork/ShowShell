//
//  MSUVideoDetailView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUVideoDetailView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width


@implementation MSUVideoDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    // 头像
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.layer.cornerRadius = 25;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth * 0.5);
        make.height.equalTo(30);
    }];
    
    // 时间
    self.timeLab = [[UILabel alloc] init];
    [_timeLab setTextColor:[UIColor grayColor]];
    //    _timeLab.backgroundColor = [UIColor redColor];
    _timeLab.font = [UIFont systemFontOfSize:10];
    [self addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.bottom).offset(-8);
        make.left.equalTo(_nickLab.left).offset(0);
        make.width.equalTo(SelfWidth * 0.5);
        make.height.equalTo(20);
    }];
    
    // 下拉菜单
    self.pullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pullBtn.backgroundColor = [UIColor blueColor];
    [self addSubview:_pullBtn];
    [_pullBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.top).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_pullBtn addTarget:self action:@selector(pullBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    // 转发评论
    self.transpodLab = [[UILabel alloc] init];
    //    _tittleLab.backgroundColor = [UIColor yellowColor];
    _transpodLab.font = [UIFont systemFontOfSize:12];
    _transpodLab.numberOfLines = 0;
    [self addSubview:_transpodLab];
    
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
    [self addSubview:_locationBtn];
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
    [self addSubview:_dictanceBtn];
    [_dictanceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationBtn.top).offset(0);
        make.left.equalTo(_locationBtn.right).offset(5);
        make.width.equalTo(50);
        make.height.equalTo(25);
    }];  
}

- (void)pullBtnClick:(UIButton *)sender{
    if (self.pullBtnClickBlock) {
        self.pullBtnClickBlock(sender);
    }
}

@end
