//
//  MSUPublishView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPublishView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@interface MSUPublishView ()<UITextViewDelegate>


@end

@implementation MSUPublishView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(145 + 30);
    }];
    
    // 头像
    self.iconIma = [[UIImageView alloc] init];
    _iconIma.backgroundColor = [UIColor redColor];
    _iconIma.layer.cornerRadius = 15;
    _iconIma.layer.shouldRasterize = YES;
    _iconIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _iconIma.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:_iconIma];
    [_iconIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(10);
        make.left.equalTo(bgView.left).offset(10);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconIma.centerY).offset(0);
        make.left.equalTo(_iconIma.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(30);
    }];
    
    UIView *shadowView = [[UIView alloc] init];
    shadowView.backgroundColor = BGLINECOLOR;
    [bgView addSubview:shadowView];
    [shadowView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconIma.bottom).offset(5);
        make.left.equalTo(_iconIma.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(90);
    }];
    
    
    // 商品图片
    self.shopIma = [[UIImageView alloc] init];
    //    _shopIma.layer.cornerRadius = 15;
    //    _shopIma.layer.shouldRasterize = YES;
    //    _shopIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _shopIma.contentMode = UIViewContentModeScaleAspectFit;
    _shopIma.backgroundColor = [UIColor redColor];
    [shadowView addSubview:_shopIma];
    [_shopIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconIma.bottom).offset(10);
        make.left.equalTo(shadowView.left).offset(5);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.numberOfLines = 0;
    [shadowView addSubview:_shopNameLab];
    
    self.timeLab = [[UILabel alloc] init];
    _timeLab.font = [UIFont systemFontOfSize:12];
    _timeLab.textColor = [UIColor grayColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [shadowView addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(0);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(SelfWidth-105-20);
        make.height.equalTo(20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BGLINECOLOR;
    [bgView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shadowView.bottom).offset(10);
        make.left.equalTo(shadowView.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(1);
    }];
    
    UILabel *seeLab = [[UILabel alloc] init];
    seeLab.text = @"评价";
    seeLab.textColor = [UIColor blackColor];
    seeLab.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:seeLab];
    [seeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(10);
        make.left.equalTo(bgView.left).offset(10);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
    
 
    
    
    
}



@end
