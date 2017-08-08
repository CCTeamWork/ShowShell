//
//  MSUSeleHeaderView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSeleHeaderView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


@implementation MSUSeleHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.userLab = [[UILabel alloc] init];
    _userLab.textColor = [UIColor blackColor];
    _userLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:_userLab];
    [_userLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(100);
        make.height.equalTo(20);
    }];
    
    self.numLab = [[UILabel alloc] init];
    _numLab.textAlignment = NSTextAlignmentRight;
    _numLab.textColor = [UIColor blackColor];
    _numLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(100);
        make.height.equalTo(20);
    }];
    
    self.addressLab = [[UILabel alloc] init];
    _addressLab.textColor = [UIColor blackColor];
    _addressLab.font = [UIFont systemFontOfSize:12];
    _addressLab.numberOfLines = 0;
    [self addSubview:_addressLab];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLab.bottom).offset(5);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.equalTo(5);
    }];
}

@end
