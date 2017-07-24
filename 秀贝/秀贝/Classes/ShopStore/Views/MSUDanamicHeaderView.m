//
//  MSUDanamicHeaderView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUDanamicHeaderView.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define NearbyWidth 50

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
    _nearbyView.backgroundColor = [UIColor whiteColor];
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
    textLab.font = [UIFont systemFontOfSize:18];
    textLab.textColor = [UIColor blackColor];
    [_nearbyView addSubview:textLab];
    [textLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nearbyView.top).offset(0);
        make.left.equalTo(_nearbyView.left).offset(20);
        make.width.equalTo(100);
        make.height.equalTo(NearbyWidth);
    }];
    
    // 箭头
    UIImageView *arrowIma = [[UIImageView alloc] init];
    arrowIma.backgroundColor = [UIColor redColor];
    arrowIma.image = [UIImage imageNamed:@""];
    [_nearbyView addSubview:arrowIma];
    [arrowIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nearbyView.top).offset(0);
        make.right.equalTo(_nearbyView.right).offset(10);
        make.width.equalTo(50);
        make.height.equalTo(NearbyWidth);
    }];

    
    // 三个头像
    self.thirdImaView = [[UIImageView alloc] init];
    _thirdImaView.backgroundColor = [UIColor blueColor];
    _thirdImaView.layer.cornerRadius = 20;
    _thirdImaView.layer.shouldRasterize = YES;
    _thirdImaView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_nearbyView addSubview:_thirdImaView];
    [_thirdImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(arrowIma.left).offset(-10);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    self.secondImaView = [[UIImageView alloc] init];
    _secondImaView.backgroundColor = [UIColor blueColor];
    _secondImaView.layer.cornerRadius = 20;
    _secondImaView.layer.shouldRasterize = YES;
    _secondImaView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_nearbyView addSubview:_secondImaView];
    [_secondImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(_thirdImaView.left).offset(-10);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    self.firstImaView = [[UIImageView alloc] init];
    _firstImaView.backgroundColor = [UIColor blueColor];
    _firstImaView.layer.cornerRadius = 20;
    _firstImaView.layer.shouldRasterize = YES;
    _firstImaView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_nearbyView addSubview:_firstImaView];
    [_firstImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(_secondImaView.left).offset(-10);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];

    

    if (!attention) {
        // 暂时无关注视图
        UILabel *attentionLab = [[UILabel alloc] init];
        attentionLab.backgroundColor = [UIColor whiteColor];
        attentionLab.text = @"暂时没有关注的人~";
        attentionLab.font = [UIFont systemFontOfSize:14];
        attentionLab.textAlignment = NSTextAlignmentCenter;
        attentionLab.textColor = [UIColor grayColor];
        [self addSubview:attentionLab];
        [attentionLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nearbyView.bottom).offset(15);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(80);
        }];

        // 猜你喜欢背景图
        UIView *bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        bgView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        [bgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(attentionLab.bottom).offset(0);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(70);
        }];
  
        // 猜你喜欢
        UILabel *geussLab = [[UILabel alloc] init];
        geussLab.text = @"猜你喜欢";
        geussLab.font = [UIFont systemFontOfSize:20];
        geussLab.textColor = [UIColor blackColor];
        geussLab.textAlignment = NSTextAlignmentCenter;
        geussLab.backgroundColor = [UIColor yellowColor];
        [self addSubview:geussLab];
        [geussLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.top).offset(20);
            make.left.equalTo(self.left).offset(SelfWidth * 0.5-50);
            make.width.equalTo(110);
            make.height.equalTo(40);
        }];
        geussLab.layer.cornerRadius = 20;
        geussLab.clipsToBounds = YES;
        geussLab.layer.shouldRasterize = YES;
        geussLab.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
}

@end
