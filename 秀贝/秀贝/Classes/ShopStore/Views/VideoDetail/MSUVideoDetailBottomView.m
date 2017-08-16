//
//  MSUVideoDetailBottomView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUVideoDetailBottomView.h"
#import "MSUPathTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUVideoDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = HEXCOLOR(0xf49418);
    [self addSubview:navView];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(1);
    }];

    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeBtn.backgroundColor = HEXCOLOR(0xffffff);
    [_likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [_likeBtn setTitleColor:HEXCOLOR(0x757575) forState:UIControlStateNormal];
    _likeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_likeBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"home-unlike"] forState:UIControlStateNormal];
    _likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    _likeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_likeBtn];
//    [_likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(1);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(80);
        make.height.equalTo(46);
    }];
    
    self.pingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pingBtn.backgroundColor = HEXCOLOR(0xffffff);
    [_pingBtn setTitle:@"评论" forState:UIControlStateNormal];
    [_pingBtn setTitleColor:HEXCOLOR(0x757575) forState:UIControlStateNormal];
    _pingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _pingBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_pingBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"state-comment"] forState:UIControlStateNormal];
    _pingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:_pingBtn];
    //    [_likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_pingBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(1);
        make.left.equalTo(_likeBtn.right).offset(0);
        make.width.equalTo(80);
        make.height.equalTo(46);
    }];
    
    self.sharBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sharBtn.backgroundColor = HEXCOLOR(0xffffff);
    [_sharBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_sharBtn setTitleColor:HEXCOLOR(0x757575) forState:UIControlStateNormal];
    _sharBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _sharBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_sharBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"state-detail-more-share"] forState:UIControlStateNormal];
    _sharBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:_sharBtn];
    //    [_likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_sharBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(1);
        make.left.equalTo(_pingBtn.right).offset(0);
        make.width.equalTo(80);
        make.height.equalTo(46);
    }];
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.backgroundColor = HEXCOLOR(0xf49418);
    [_buyBtn setTitle:@"我要买" forState:UIControlStateNormal];
    [_buyBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_buyBtn];
    //    [_likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_buyBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(1);
        make.left.equalTo(_sharBtn.right).offset(0);
        make.width.equalTo(SelfWidth-240);
        make.height.equalTo(46);
    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = HEXCOLOR(0xf49418);
        [self addSubview:lineView];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.bottom).offset(0);
            make.left.equalTo(self.left).offset(80*(i+1));
            make.width.equalTo(1);
            make.height.equalTo(46);
        }];

    }

}

@end
