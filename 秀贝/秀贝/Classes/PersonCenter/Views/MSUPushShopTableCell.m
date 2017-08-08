//
//  MSUPushShopTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/8.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPushShopTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width

@implementation MSUPushShopTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor whiteColor];
    [self addSubview:navView];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(130);
    }];
    
    // 店头像
    self.userIma = [[UIImageView alloc] init];
    _userIma.contentMode = UIViewContentModeScaleAspectFit;
    _userIma.backgroundColor = [UIColor redColor];
    _userIma.layer.cornerRadius = 10;
    _userIma.layer.shouldRasterize = YES;
    _userIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [navView addSubview:_userIma];
    [_userIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.top).offset(5);
        make.left.equalTo(navView.left).offset(5);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
    // 店名字
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    _nickLab.textColor = [UIColor blackColor];
    [navView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.top).offset(5);
        make.left.equalTo(_userIma.right).offset(10);
        make.width.equalTo(SelfWidth-20-35);
        make.height.equalTo(20);
    }];

    // 商品图片
    self.shopIma = [[UIImageView alloc] init];
    _shopIma.contentMode = UIViewContentModeScaleAspectFit;
    _shopIma.backgroundColor = [UIColor redColor];
    [navView addSubview:_shopIma];
    [_shopIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIma.bottom).offset(10);
        make.left.equalTo(navView.left).offset(5);
        make.width.equalTo(90);
        make.height.equalTo(90);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.numberOfLines = 0;
    [navView addSubview:_shopNameLab];
    
    CGFloat labWid = SelfWidth -20 - 5-80-10;
    // 价格
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:16];
    //    _priceLab.textColor = [UIColor redColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [navView addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopNameLab.bottom).offset(5);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];

    // 总佣金
    self.yongjinLab = [[UILabel alloc] init];
    _yongjinLab.font = [UIFont systemFontOfSize:16];
    _yongjinLab.textAlignment = NSTextAlignmentRight;
    _yongjinLab.textColor = [UIColor orangeColor];
    [navView addSubview:_yongjinLab];
    [_yongjinLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopNameLab.bottom).offset(5);
        make.right.equalTo(navView.right).offset(-10);
        make.width.equalTo(120);
        make.height.equalTo(20);
    }];
    
    self.pushImaView = [[UIImageView alloc] init];
    _pushImaView.image = nil;
    _pushImaView.alpha = 0.5;
    _pushImaView.backgroundColor = [UIColor orangeColor];
    _pushImaView.layer.cornerRadius = 30;
    _pushImaView.layer.shouldRasterize = YES;
    _pushImaView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [navView addSubview:_pushImaView];
    [_pushImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopIma.top).offset(5);
        make.right.equalTo(navView.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(60);
    }];
    
    // 有效期
    self.timeLab = [[UILabel alloc] init];
    _timeLab.font = [UIFont systemFontOfSize:14];
    _timeLab.textColor = [UIColor blackColor];
    [navView addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(0);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(SelfWidth-20-5-80-10);
        make.height.equalTo(20);
    }];
    
}

@end
