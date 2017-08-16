//
//  MSUVideoDetailView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUVideoDetailView.h"

#import "MSUPathTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


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
    _iconBtn.layer.cornerRadius = 41*0.5;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(41);
        make.height.equalTo(41);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = HEXCOLOR(0x333333);
    _nickLab.textColor = HEXCOLOR(0x333333);
    [self addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(16);
        make.left.equalTo(_iconBtn.right).offset(14);
        make.width.equalTo(SelfWidth * 0.5);
        make.height.equalTo(10);
    }];
    
    // 时间
    self.timeLab = [[UILabel alloc] init];
    [_timeLab setTextColor:[UIColor grayColor]];
    //    _timeLab.backgroundColor = [UIColor redColor];
    _timeLab.font = [UIFont systemFontOfSize:12];
    _timeLab.textColor = HEXCOLOR(0x989898);
    [self addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.bottom).offset(8);
        make.left.equalTo(_nickLab.left).offset(0);
        make.width.equalTo(SelfWidth * 0.5);
        make.height.equalTo(10);
    }];
    
    // 下拉
    self.pullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pullBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_pullBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"WechatIMG454"] forState:UIControlStateNormal];
    [self addSubview:_pullBtn];
    [_pullBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(19);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(10);
        make.height.equalTo(6);
    }];
    [_pullBtn addTarget:self action:@selector(pullBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 关注
    self.attenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attenBtn setTitle:@"╋ 关注" forState:UIControlStateNormal];
    [_attenBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_attenBtn setTitleColor:HEXCOLOR(0xf7d721) forState:UIControlStateNormal];
    [_attenBtn setTitleColor:HEXCOLOR(0x989898) forState:UIControlStateSelected];
    _attenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _attenBtn.layer.borderWidth = 1;
    _attenBtn.layer.borderColor = HEXCOLOR(0xc3c3c3).CGColor;
    _attenBtn.layer.cornerRadius = 2.5;
    _attenBtn.layer.shouldRasterize = YES;
    _attenBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _attenBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_attenBtn];
    [_attenBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(19);
        make.right.equalTo(_pullBtn.left).offset(-15);
        make.width.equalTo(60);
        make.height.equalTo(24);
    }];

    // 转发评论
    self.transpodLab = [[UILabel alloc] init];
    //    _tittleLab.backgroundColor = [UIColor yellowColor];
    _transpodLab.font = [UIFont systemFontOfSize:12];
    _transpodLab.textColor = HEXCOLOR(0x333333);
    _transpodLab.numberOfLines = 0;
    [self addSubview:_transpodLab];
    
    /* 正文内容相关 */
    // 正文背景
    self.tittleBGView = [[UIView alloc] init];
    [self addSubview:_tittleBGView];
    
    // 正文内容
    self.tittleLab = [[UILabel alloc] init];
    //    _tittleLab.backgroundColor = [UIColor yellowColor];
    _tittleLab.textColor = HEXCOLOR(0x333333);
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
        make.left.equalTo(_videoBGView.left).offset(14);
        make.right.equalTo(_videoBGView.right).offset(-10);
        make.height.equalTo(171.5);
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
    _locationBtn.backgroundColor = HEXCOLOR(0xf2f2f2);
    _locationBtn.layer.cornerRadius = 10;
    _locationBtn.layer.shouldRasterize = YES;
    _locationBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _locationBtn.layer.borderWidth = 1;
    _locationBtn.layer.borderColor = HEXCOLOR(0xc3c3c3).CGColor;
    [_locationBtn setTitle:@"马尔代夫" forState:UIControlStateNormal];
    [_locationBtn setTitleColor:HEXCOLOR(0x757575) forState:UIControlStateNormal];
    _locationBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    _locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_locationBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"state-location"] forState:UIControlStateNormal];
    _locationBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:_locationBtn];
    [_locationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_videoBGView.bottom).offset(5);
        make.left.equalTo(_videoImaView.left).offset(0);
        make.width.equalTo(72);
        make.height.equalTo(20);
    }];
    
    
    // 位置图标
    self.dictanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dictanceBtn.backgroundColor = HEXCOLOR(0xf7d721);
    _dictanceBtn.layer.cornerRadius = 10;
    _dictanceBtn.layer.shouldRasterize = YES;
    _dictanceBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _dictanceBtn.layer.borderWidth = 1;
    _dictanceBtn.layer.borderColor = HEXCOLOR(0xc3c3c3).CGColor;
    [self addSubview:_dictanceBtn];
    [_dictanceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationBtn.top).offset(0);
        make.left.equalTo(_locationBtn.right).offset(5);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
}

- (void)pullBtnClick:(UIButton *)sender{
    if (self.pullBtnClickBlock) {
        self.pullBtnClickBlock(sender);
    }
}

@end
