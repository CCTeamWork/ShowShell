//
//  MSUTranspodTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//


#import "MSUTranspodTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width

@implementation MSUTranspodTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.iconImaView = [[UIImageView alloc] init];
    [self addSubview:_iconImaView];
    [_iconImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(100);
        make.height.equalTo(100);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(_iconImaView.right).offset(10);
        make.width.equalTo(SelfWidth - 20 - 100 - 10);
        make.height.equalTo(20);
    }];
    
    // 正文
    self.contentLab = [[UILabel alloc] init];
    _contentLab.font = [UIFont systemFontOfSize:12];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    _contentLab.textColor = [UIColor grayColor];
    _contentLab.numberOfLines = 0;
    [self addSubview:_contentLab];
    [_contentLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.bottom).offset(0);
        make.left.equalTo(_iconImaView.right).offset(10);
        make.width.equalTo(SelfWidth - 20 - 100 - 10);
        make.height.equalTo(70);
    }];

}

@end
