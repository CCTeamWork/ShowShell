//
//  MSUGeussCollectionViewCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUGeussCollectionViewCell.h"
#define SelfWidth self.contentView.frame.size.width

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUGeussCollectionViewCell

/* 视频页面 */
- (UIImageView *)iconIma{
    if (!_iconIma) {
        self.iconIma = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconIma];
//        _iconIma.backgroundColor = [UIColor redColor];
        _iconIma.contentMode = UIViewContentModeScaleAspectFit;
        _iconIma.layer.cornerRadius = SelfWidth *0.5;
        _iconIma.layer.shouldRasterize = YES;
        _iconIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [_iconIma makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(0);
            make.left.equalTo(self.left).offset(-10);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(SelfWidth);
        }];
    }
    return _iconIma;
}

/* 商品名字 */
- (UILabel *)shopLab{
    if (!_shopLab) {
        self.shopLab = [[UILabel alloc] init];
        [self.contentView addSubview:_shopLab];
        _shopLab.font = [UIFont systemFontOfSize:10];
//        _shopLab.backgroundColor = [UIColor yellowColor];
        [_shopLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconIma.bottom).offset(3);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(15);
        }];
    }
    return _shopLab;
}

/* 价格 */
- (UILabel *)priceLab{
    if (!_priceLab) {
        self.priceLab = [[UILabel alloc] init];
        _priceLab.font = [UIFont systemFontOfSize:18];
        _priceLab.textColor = [UIColor redColor];
//        _priceLab.backgroundColor = [UIColor redColor];
        _priceLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_priceLab];
        [_priceLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_shopLab.bottom).offset(0);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(30);
        }];
    }
    return _priceLab;
}

@end
