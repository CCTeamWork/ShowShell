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
    _searIma.image = [MSUPathTools showImageWithContentOfFileByName:@"like"];
    [self addSubview:_searIma];
    [_searIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(20);
        make.width.equalTo(30);
        make.height.equalTo(20);
    }];

    self.searLab = [[UILabel alloc] init];
    _searLab.font = [UIFont systemFontOfSize:16];
    _searLab.textColor = [UIColor blackColor];
    [self addSubview:_searLab];
    [_searLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(2);
        make.left.equalTo(_searIma.right).offset(10);
        make.width.equalTo(SelfWidth-20-30-10-20-30);
        make.height.equalTo(40);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-1);
        make.left.equalTo(self.left).offset(20);
        make.width.equalTo(SelfWidth-40);
        make.height.equalTo(1);
    }];

    
    if (num) {
        self.forkIma = [[UIImageView alloc] init];
        _forkIma.contentMode = UIViewContentModeScaleAspectFit;
        _forkIma.image = [MSUPathTools showImageWithContentOfFileByName:@"like"];
        [self addSubview:_forkIma];
        [_forkIma makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(10);
            make.right.equalTo(self.right).offset(-20);
            make.width.equalTo(30);
            make.height.equalTo(20);
        }];
    }

    
}

@end
