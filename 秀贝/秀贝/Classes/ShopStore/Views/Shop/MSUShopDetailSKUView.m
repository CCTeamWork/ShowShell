//
//  MSUShopDetailSKUView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopDetailSKUView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define SeleWidth SelfWidth - 30 - 25

@implementation MSUShopDetailSKUView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    // 商品图片
    self.shopIma = [[UIImageView alloc] init];
    _shopIma.contentMode = UIViewContentModeScaleAspectFit;
    _shopIma.backgroundColor = [UIColor redColor];
    [self addSubview:_shopIma];
    [_shopIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.numberOfLines = 0;
    [self addSubview:_shopNameLab];
    
    CGFloat labWid = SelfWidth -20 - 5-80-10;
    // 价格
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:16];
    //    _priceLab.textColor = [UIColor redColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [self addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(3);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];

    UILabel *seleLab = [[UILabel alloc] init];
    seleLab.text = @"选择商品规格 :";
    seleLab.font = [UIFont systemFontOfSize:14];
    seleLab.textColor = [UIColor blackColor];
    [self addSubview:seleLab];
    [seleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopIma.bottom).offset(10);
        make.left.equalTo(_shopIma.left).offset(0);
        make.width.equalTo(SeleWidth);
        make.height.equalTo(20);
    }];

    UILabel *colorLab = [[UILabel alloc] init];
    colorLab.text = @"颜色 :";
    colorLab.font = [UIFont systemFontOfSize:14];
    colorLab.textColor = [UIColor blackColor];
    [self addSubview:colorLab];
    [colorLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seleLab.bottom).offset(10);
        make.left.equalTo(seleLab.left).offset(0);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];

    UILabel *numberLab = [[UILabel alloc] init];
    numberLab.text = @"数量 :";
    numberLab.font = [UIFont systemFontOfSize:14];
    numberLab.textColor = [UIColor blackColor];
    [self addSubview:numberLab];
    [numberLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(colorLab.bottom).offset(10);
        make.left.equalTo(colorLab.left).offset(0);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];

    
    for (NSInteger i = 0; i < 3; i++) {
        self.colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _colorBtn.layer.cornerRadius = 5;
        _colorBtn.layer.shouldRasterize = YES;
        _colorBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [_colorBtn setTitle:@"黑色原点" forState:UIControlStateNormal];
        [_colorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _colorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _colorBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _colorBtn.layer.borderWidth = 1;
        _colorBtn.backgroundColor = [UIColor blueColor];
        [self addSubview:_colorBtn];
        [_colorBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(colorLab.top).offset(0);
            make.left.equalTo(colorLab.right).offset(5+(60+5)*i);
            make.width.equalTo(60);
            make.height.equalTo(20);
        }];
        [self.colorBtnArr addObject:_colorBtn];
    }


    self.cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cutBtn.backgroundColor = [UIColor blueColor];
    [self addSubview:_cutBtn];
    [_cutBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberLab.top).offset(0);
        make.left.equalTo(numberLab.right).offset(5);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];

    self.numLab = [[UILabel alloc] init];
    _numLab.backgroundColor = [UIColor redColor];
    _numLab.text = @"2";
    _numLab.font = [UIFont systemFontOfSize:12];
    _numLab.textColor = [UIColor blackColor];
    _numLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberLab.top).offset(0);
        make.left.equalTo(_cutBtn.right).offset(0);
        make.width.equalTo(30);
        make.height.equalTo(20);
    }];

    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.backgroundColor = [UIColor blueColor];
    [self addSubview:_addBtn];
    [_addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberLab.top).offset(0);
        make.left.equalTo(_numLab.right).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];

    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.backgroundColor = [UIColor redColor];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_sureBtn];
    [_sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberLab.bottom).offset(10);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(40);
    }];
    
}

@end
