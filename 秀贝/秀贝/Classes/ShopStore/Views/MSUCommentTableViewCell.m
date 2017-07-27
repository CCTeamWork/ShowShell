//
//  MSUCommentTableViewCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUCommentTableViewCell.h"
//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfContentHeight self.contentView.frame.size.height
#define SelfWidth [UIScreen mainScreen].bounds.size.width

@implementation MSUCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    // 头像
    self.iconIma = [[UIImageView alloc] init];
    _iconIma.layer.cornerRadius = 25;
    _iconIma.layer.shouldRasterize = YES;
    _iconIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _iconIma.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconIma];
    [_iconIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(5);
        make.left.equalTo(self.contentView.left).offset(15);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(10);
        make.left.equalTo(_iconIma.right).offset(10);
        make.width.equalTo(SelfContentWidth * 0.5);
        make.height.equalTo(30);
    }];
    
    // 时间
    self.timeLab = [[UILabel alloc] init];
    [_timeLab setTextColor:[UIColor grayColor]];
    //    _timeLab.backgroundColor = [UIColor redColor];
    _timeLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.bottom).offset(-8);
        make.left.equalTo(_nickLab.left).offset(0);
        make.width.equalTo(SelfContentWidth * 0.5);
        make.height.equalTo(20);
    }];
    
    // 正文内容
    self.tittleLab = [[UILabel alloc] init];
    //    _tittleLab.backgroundColor = [UIColor yellowColor];
    _tittleLab.font = [UIFont systemFontOfSize:12];
    _tittleLab.numberOfLines = 0;
    [self addSubview:_tittleLab];
}


@end
