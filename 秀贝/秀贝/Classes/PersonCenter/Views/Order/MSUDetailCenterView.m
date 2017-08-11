//
//  MSUDetailCenterView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUDetailCenterView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@implementation MSUDetailCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    // 头像
    self.iconIma = [[UIImageView alloc] init];
    _iconIma.backgroundColor = [UIColor redColor];
    _iconIma.layer.cornerRadius = 15;
    _iconIma.layer.shouldRasterize = YES;
    _iconIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _iconIma.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconIma];
    [_iconIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconIma.centerY).offset(0);
        make.left.equalTo(_iconIma.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(30);
    }];

    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = BGLINECOLOR;
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconIma.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
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
    [bgView addSubview:_shopIma];
    [_shopIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(5);
        make.left.equalTo(bgView.left).offset(5);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.numberOfLines = 0;
    [bgView addSubview:_shopNameLab];
    
    
    self.sizeLab = [[UILabel alloc] init];
    _sizeLab.font = [UIFont systemFontOfSize:10];
    _sizeLab.textColor = [UIColor grayColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [bgView addSubview:_sizeLab];
    [_sizeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopNameLab.bottom).offset(3);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(SelfWidth-105-20);
        make.height.equalTo(20);
    }];
    
    
    CGFloat labWid = SelfWidth -20 - 5-80-10;
    // 价格
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:16];
    _priceLab.textColor = [UIColor blackColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [bgView addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(3);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];
    
    // 数量
    self.numLab = [[UILabel alloc] init];
    _numLab.font = [UIFont systemFontOfSize:14];
    _numLab.textAlignment = NSTextAlignmentRight;
    //    _numLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(0);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BGLINECOLOR;
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(1);
    }];

    
}

@end
