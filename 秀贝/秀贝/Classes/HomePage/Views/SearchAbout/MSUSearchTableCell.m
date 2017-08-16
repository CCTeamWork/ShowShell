//
//  MSUSearchTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchTableCell.h"
#import "MSUPathTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


@implementation MSUSearchTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier historyNum:(NSInteger)num{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createViewWithHistoryNum:num];
    }
    return self;
}

- (void)createViewWithHistoryNum:(NSInteger)num{
    self.searIma = [[UIImageView alloc] init];
    _searIma.contentMode = UIViewContentModeScaleAspectFit;
    _searIma.image = [MSUPathTools showImageWithContentOfFileByName:@"search-searchicon"];
    [self addSubview:_searIma];
    [_searIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(11);
        make.left.equalTo(self.left).offset(24);
        make.width.equalTo(13);
        make.height.equalTo(13);
    }];

    self.searLab = [[UILabel alloc] init];
    _searLab.font = [UIFont systemFontOfSize:14];
    _searLab.textColor = HEXCOLOR(0x757575);
    [self addSubview:_searLab];
    [_searLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(_searIma.right).offset(10);
        make.width.equalTo(SelfWidth-28-10-13-10-10);
        make.height.equalTo(35);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xc3c3c3);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-0.5);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(0.5);
    }];

    
    if (num) {
        self.forkIma = [[UIImageView alloc] init];
        _forkIma.contentMode = UIViewContentModeScaleAspectFit;
        _forkIma.image = [MSUPathTools showImageWithContentOfFileByName:@"search-close"];
        [self addSubview:_forkIma];
        [_forkIma makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(12.5);
            make.right.equalTo(self.right).offset(-24);
            make.width.equalTo(10);
            make.height.equalTo(10);
        }];
    }

    
}

@end
