//
//  MSUSellerTotalTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/11.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSellerTotalTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@implementation MSUSellerTotalTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(130+40);
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
        make.top.equalTo(bgView.top).offset(5);
        make.left.equalTo(bgView.left).offset(5);
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
    
    // 状态
    self.statusLab = [[UILabel alloc] init];
    //    _statusLab.backgroundColor = [UIColor yellowColor];
    _statusLab.font = [UIFont systemFontOfSize:14];
    _statusLab.textColor = [UIColor orangeColor];
    _statusLab.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:_statusLab];
    [_statusLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconIma.centerY).offset(0);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(30);
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
        make.top.equalTo(_iconIma.bottom).offset(10);
        make.left.equalTo(bgView.left).offset(5);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.numberOfLines = 0;
    [bgView addSubview:_shopNameLab];
    
    // 规格 颜色等
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
        make.bottom.equalTo(_shopIma.bottom).offset(0);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(labWid*2/3);
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
    [bgView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopIma.bottom).offset(5);
        make.left.equalTo(bgView.left).offset(5);
        make.width.equalTo(SelfWidth-30);
        make.height.equalTo(1);
    }];

    self.agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_agreeBtn setTitle:@"拒绝申请" forState:UIControlStateNormal];
    [_agreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _agreeBtn.backgroundColor = [UIColor redColor];
    _agreeBtn.adjustsImageWhenHighlighted = NO;
    _agreeBtn.layer.cornerRadius = 3;
    _agreeBtn.layer.shouldRasterize = YES;
    _agreeBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [bgView addSubview:_agreeBtn];
    [_agreeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(7.5);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(25);
    }];
    _agreeBtn.hidden = YES;
    
    
    self.disagreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_disagreeBtn setTitle:@"退货/换货" forState:UIControlStateNormal];
    [_disagreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _disagreeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _disagreeBtn.backgroundColor = BGLINECOLOR;
    _disagreeBtn.adjustsImageWhenHighlighted = NO;
    _disagreeBtn.layer.cornerRadius = 3;
    _disagreeBtn.layer.shouldRasterize = YES;
    _disagreeBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:_disagreeBtn];
    [_disagreeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_agreeBtn.top).offset(0);
        make.right.equalTo(_agreeBtn.left).offset(-30);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];
    _disagreeBtn.hidden = YES;
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _sureBtn.backgroundColor = [UIColor orangeColor];
    _sureBtn.adjustsImageWhenHighlighted = NO;
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.layer.shouldRasterize = YES;
    _sureBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [bgView addSubview:_sureBtn];
    [_sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(7.5);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(25);
    }];
    _sureBtn.hidden = YES;
    
}

@end
