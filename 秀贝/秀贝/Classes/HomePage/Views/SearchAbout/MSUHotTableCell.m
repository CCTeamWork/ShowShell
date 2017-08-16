//
//  MSUHotTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUHotTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@implementation MSUHotTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}


- (void)createView{
    // 背景视图
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0].CGColor;
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(SelfWidth-30);
        make.height.equalTo(90);
    }];
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(3, 3);
    bgView.layer.shadowOpacity = 0.6;
    bgView.layer.shadowRadius = 3;
    
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
    
    CGFloat labWid = SelfWidth -20 - 5-80-10;
    // 价格
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:16];
//    _priceLab.textColor = [UIColor redColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [bgView addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(3);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];
    
    // 加入购物车
    self.shopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shopCarBtn.backgroundColor = [UIColor blueColor];
    [bgView addSubview:_shopCarBtn];
    [_shopCarBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(0);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];

    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor whiteColor];
    [self addSubview:navView];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.bottom).offset(2);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(5);
    }];

    
}
@end
