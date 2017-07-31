//
//  MSUSearchUserTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchUserTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@implementation MSUSearchUserTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}


- (void)createView{
    // 头像
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _iconBtn.backgroundColor = [UIColor blueColor];
    _iconBtn.layer.cornerRadius = 25;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.contentView addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    _nickLab.textColor = [UIColor blackColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconBtn.top).offset(5);
        make.left.equalTo(_iconBtn.right).offset(5);
        make.width.equalTo(SelfWidth-15-40-10-40);
        make.height.equalTo(20);
    }];
    
    // 简介
    self.introLab = [[UILabel alloc] init];
    _introLab.font = [UIFont systemFontOfSize:12];
    _introLab.textColor = [UIColor grayColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_introLab];
    [_introLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.bottom).offset(0);
        make.left.equalTo(_nickLab.left).offset(0);
        make.width.equalTo(SelfWidth-15-50-10-70);
        make.height.equalTo(20);
    }];
    
    // 关注
    self.attenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attenBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    [_attenBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    _attenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _attenBtn.layer.cornerRadius = 5;
    _attenBtn.layer.shouldRasterize = YES;
    _attenBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _attenBtn.layer.borderColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0].CGColor;
    _attenBtn.layer.borderWidth = 1;
    [self addSubview:_attenBtn];
    [_attenBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(20);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(70);
        make.height.equalTo(30);
    }];
    
    // 背景线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:241/255.0 alpha:1.0];
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(1);
        make.left.equalTo(_nickLab.left).offset(0);
        make.width.equalTo(SelfWidth-15-50-10-10);
        make.height.equalTo(1);
    }];

    
}

@end
