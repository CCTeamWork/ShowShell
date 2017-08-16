//
//  MSUDanamicHeaderView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUDanamicHeaderView.h"
#import "MSUPathTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define NearbyWidth 45


#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUDanamicHeaderView

- (instancetype)initWithFrame:(CGRect)frame isAttention:(BOOL)attention{
    if (self = [super initWithFrame:frame]) {
        [self createContentViewWithAttention:attention];
    }
    return self;
}

- (void)createContentViewWithAttention:(BOOL)attention{
    // 附近人视图
    self.nearbyView = [[UIView alloc] init];
    _nearbyView.backgroundColor = HEXCOLOR(0xffffff);
    [self addSubview:_nearbyView];
    [_nearbyView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(NearbyWidth);
    }];
    
    // 附近人点击按钮
    self.nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nearbyBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_nearbyBtn];
    [_nearbyBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(NearbyWidth);
    }];
    
    // 附近的人 label
    UILabel *textLab = [[UILabel alloc] init];
    textLab.text = @"附近的人";
    textLab.font = [UIFont systemFontOfSize:14];
    textLab.textColor = [UIColor blackColor];
    [_nearbyView addSubview:textLab];
    [textLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nearbyView.top).offset(0);
        make.left.equalTo(_nearbyView.left).offset(14);
        make.width.equalTo(100);
        make.height.equalTo(NearbyWidth);
    }];
    
    // 箭头
    UIImageView *arrowIma = [[UIImageView alloc] init];
//    arrowIma.backgroundColor = [UIColor redColor];
    arrowIma.contentMode = UIViewContentModeScaleAspectFit;
    arrowIma.image = [MSUPathTools showImageWithContentOfFileByName:@"more"];
    [_nearbyView addSubview:arrowIma];
    [arrowIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nearbyView.top).offset(12.5);
        make.right.equalTo(_nearbyView.right).offset(-14);
        make.width.equalTo(8);
        make.height.equalTo(14);
    }];

    
    // 三个头像
    self.thirdImaView = [[UIImageView alloc] init];
    _thirdImaView.backgroundColor = [UIColor blueColor];
    _thirdImaView.layer.cornerRadius = 18;
    _thirdImaView.layer.shouldRasterize = YES;
    _thirdImaView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_nearbyView addSubview:_thirdImaView];
    [_thirdImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(4.5);
        make.right.equalTo(arrowIma.left).offset(-10);
        make.width.equalTo(36);
        make.height.equalTo(36);
    }];
    
    self.secondImaView = [[UIImageView alloc] init];
    _secondImaView.backgroundColor = [UIColor blueColor];
    _secondImaView.layer.cornerRadius = 18;
    _secondImaView.layer.shouldRasterize = YES;
    _secondImaView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_nearbyView addSubview:_secondImaView];
    [_secondImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(4.5);
        make.right.equalTo(_thirdImaView.left).offset(-10);
        make.width.equalTo(36);
        make.height.equalTo(36);
    }];
    
    self.firstImaView = [[UIImageView alloc] init];
    _firstImaView.backgroundColor = [UIColor blueColor];
    _firstImaView.layer.cornerRadius = 18;
    _firstImaView.layer.shouldRasterize = YES;
    _firstImaView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_nearbyView addSubview:_firstImaView];
    [_firstImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(4.5);
        make.right.equalTo(_secondImaView.left).offset(-10);
        make.width.equalTo(36);
        make.height.equalTo(36);
    }];

    

    if (!attention) {
        // 暂时无关注视图
        UILabel *attentionLab = [[UILabel alloc] init];
        attentionLab.backgroundColor = HEXCOLOR(0xffffff);
        attentionLab.text = @"暂时没有关注的人~";
        attentionLab.font = [UIFont systemFontOfSize:11];
        attentionLab.textAlignment = NSTextAlignmentCenter;
        attentionLab.textColor = HEXCOLOR(0x757575);
        [self addSubview:attentionLab];
        [attentionLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nearbyView.bottom).offset(10);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(66);
        }];

        // 猜你喜欢背景图
        UIView *bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        bgView.backgroundColor = HEXCOLOR(0xf4f4f4);
        [bgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(attentionLab.bottom).offset(0);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(54);
        }];
  
        // 猜你喜欢
        UILabel *geussLab = [[UILabel alloc] init];
        geussLab.text = @"猜你喜欢";
        geussLab.font = [UIFont systemFontOfSize:14];
        geussLab.textColor = HEXCOLOR(0x333333);
        geussLab.textAlignment = NSTextAlignmentCenter;
        geussLab.backgroundColor = HEXCOLOR(0xf7d721);
        [self addSubview:geussLab];
        [geussLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.top).offset(15);
            make.left.equalTo(self.left).offset(SelfWidth * 0.5-40);
            make.width.equalTo(80);
            make.height.equalTo(29);
        }];
        geussLab.layer.cornerRadius = 14;
        geussLab.clipsToBounds = YES;
        geussLab.layer.shouldRasterize = YES;
        geussLab.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
}

@end
