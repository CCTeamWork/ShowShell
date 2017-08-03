//
//  MSUPopTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPopTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth self.frame.size.width
#define SelfHeight self.frame.size.height

@implementation MSUPopTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier popHeight:(CGFloat)height{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imaBtnArr = [NSMutableArray array];
        [self createContentViewWithHeight:height];
    }
    return self;
}

- (void)createContentViewWithHeight:(CGFloat)height{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 7;
    bgView.clipsToBounds = YES;
    bgView.layer.shouldRasterize = YES;
    bgView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.height.equalTo(60+80+5);
    }];

    
    // 头像
    self.iconIma = [[UIImageView alloc] init];
    _iconIma.image = nil;
//    _iconIma.backgroundColor = [UIColor blackColor];
    _iconIma.layer.cornerRadius = 25;
    _iconIma.layer.shouldRasterize = YES;
    _iconIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [bgView addSubview:_iconIma];
    [_iconIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(5);
        make.left.equalTo(bgView.left).offset(10);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
//    _nickLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconIma.top).offset(5);
        make.left.equalTo(_iconIma.right).offset(5);
        make.width.equalTo(SelfWidth * 0.5);
        make.height.equalTo(20);
    }];
    
    // 个人简介
    self.introLab = [[UILabel alloc] init];
    [_introLab setTextColor:[UIColor grayColor]];
//    _introLab.backgroundColor = [UIColor redColor];
    _introLab.font = [UIFont systemFontOfSize:10];
    [bgView addSubview:_introLab];
    [_introLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.bottom).offset(0);
        make.left.equalTo(_nickLab.left).offset(0);
        make.width.equalTo(SelfWidth * 0.5);
        make.height.equalTo(20);
    }];
    
    // 箭头图片
    UIImageView *arrowIma = [[UIImageView alloc] init];
    arrowIma.image = nil;
    arrowIma.backgroundColor = [UIColor blackColor];
    [bgView addSubview:arrowIma];
    [arrowIma makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_introLab.bottom).offset(0);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(20);
        make.height.equalTo(30);
    }];

    // 关注按钮
    self.attenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attenBtn.layer.cornerRadius = 5;
    _attenBtn.layer.shouldRasterize = YES;
    _attenBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _attenBtn.layer.borderColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0].CGColor;
    _attenBtn.layer.borderWidth = 1;
    [_attenBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    [_attenBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    _attenBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:_attenBtn];
    [_attenBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_introLab.bottom).offset(0);
        make.right.equalTo(arrowIma.left).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    
    // 内容视图
    for (NSInteger i = 0; i < 3; i++) {
        self.contentImaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentImaBtn.backgroundColor = [UIColor brownColor];
        [bgView addSubview:_contentImaBtn];
        [_contentImaBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconIma.bottom).offset(5);
            make.left.equalTo(_iconIma.left).offset(((height-20-20)/3+10)*i);
            make.width.equalTo((height-20-20)/3);
            make.height.equalTo(80);
        }];
        NSLog(@"高高高%f",height);
        [self.imaBtnArr addObject:_contentImaBtn];
    } 
}

@end
