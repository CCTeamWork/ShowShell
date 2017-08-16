//
//  MSUShopHouseTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/4.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopHouseTableCell.h"
#import "MSUPathTools.h"
//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUShopHouseTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    // 背景视图
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [UIColor grayColor].CGColor;
//    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
//    bgView.layer.shadowOffset = CGSizeMake(3, 3);
//    bgView.layer.shadowOpacity = 1;
//    bgView.layer.shadowRadius = 3;
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth-30-30);
        make.height.equalTo(101);
    }];
    
    self.seleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _seleBtn.backgroundColor = [UIColor blueColor];
    [_seleBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"video-product-choose"] forState:UIControlStateNormal];
    [_seleBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"WechatIMG570"] forState:UIControlStateSelected];
    _seleBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:_seleBtn];
    [_seleBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.centerY).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.width.equalTo(15);
        make.height.equalTo(15);
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
        make.top.equalTo(bgView.top).offset(11);
        make.left.equalTo(bgView.left).offset(5);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.textColor = HEXCOLOR(0x333333);
    _shopNameLab.numberOfLines = 0;
    [bgView addSubview:_shopNameLab];
    
    CGFloat labWid = SelfWidth -28 - 5-80-10;
    // 价格
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:15];
    _priceLab.textColor = HEXCOLOR(0x333333);
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [bgView addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(0);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];
    
    self.tuiGuangLab = [[UILabel alloc] init];
    _tuiGuangLab.font = [UIFont systemFontOfSize:16];
    _tuiGuangLab.textColor = HEXCOLOR(0xf49418);
    _tuiGuangLab.textAlignment = NSTextAlignmentRight;
//        _tuiGuangLab.backgroundColor = [UIColor redColor];
    [bgView addSubview:_tuiGuangLab];
    [_tuiGuangLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_priceLab.bottom).offset(0);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];
    
    self.infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_infoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _infoBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    _infoBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _infoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _infoBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _infoBtn.backgroundColor = [UIColor clearColor];
    _infoBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:_infoBtn];
    [_infoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_tuiGuangLab.top).offset(-2);
        make.right.equalTo(bgView.right).offset(-11);
        make.left.equalTo(_tuiGuangLab.left).offset(10);
        make.height.equalTo(20);
    }];


}

@end
