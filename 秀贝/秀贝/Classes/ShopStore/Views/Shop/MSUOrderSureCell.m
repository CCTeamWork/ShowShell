//
//  MSUOrderSureCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUOrderSureCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfContentHeight self.frame.size.height

@implementation MSUOrderSureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    // 头像
    self.iconIma = [[UIImageView alloc] init];
//    _iconIma.backgroundColor = [UIColor brownColor];
    _iconIma.layer.cornerRadius = 15;
    _iconIma.layer.shouldRasterize = YES;
    _iconIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _iconIma.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconIma];
    [_iconIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(5);
        make.left.equalTo(self.contentView.left).offset(10);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(5);
        make.left.equalTo(_iconIma.right).offset(10);
        make.width.equalTo(SelfWidth - 50);
        make.height.equalTo(30);
    }];
    
    // 背景视图
    self.bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:241/255.0 alpha:1.0];
    [self addSubview:_bgView];
    [_bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconIma.bottom).offset(10);
        make.left.equalTo(_iconIma.left).offset(0);
        make.width.equalTo(SelfWidth - 20);
        make.height.equalTo(90);
    }];
    
    // 商品图片
    self.shopIma = [[UIImageView alloc] init];
//    _shopIma.layer.cornerRadius = 15;
//    _shopIma.layer.shouldRasterize = YES;
//    _shopIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _shopIma.contentMode = UIViewContentModeScaleAspectFit;
    _shopIma.backgroundColor = [UIColor redColor];
    [_bgView addSubview:_shopIma];
    [_shopIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.top).offset(5);
        make.left.equalTo(_bgView.left).offset(5);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.numberOfLines = 0;
    [_bgView addSubview:_shopNameLab];
    
    CGFloat labWid = SelfWidth -20 - 5-80-10;
    // 价格
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:16];
    _priceLab.textColor = [UIColor redColor];
//    _priceLab.backgroundColor = [UIColor blackColor];
    [_bgView addSubview:_priceLab];
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
    [_bgView addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bgView.bottom).offset(0);
        make.right.equalTo(_bgView.right).offset(0);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];

}

@end
