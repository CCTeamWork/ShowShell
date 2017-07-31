//
//  MSUSearchUserView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchUserView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@implementation MSUSearchUserView

- (instancetype)initWithFrame:(CGRect)frame tableHeight:(CGFloat)height
{
    if (self = [super initWithFrame:frame]) {
        [self createViewWithTableHeight:height];
    }
    return self;
}


- (void)createViewWithTableHeight:(CGFloat)height{
    self.bgScrollView = [[UIScrollView alloc] init];
    _bgScrollView.scrollEnabled = YES;
    //    _bgScrollView.backgroundColor = [UIColor redColor];
    _bgScrollView.contentSize = CGSizeMake(0, height+120+60);
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_bgScrollView];
    [_bgScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfHeight);
    }];
    
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height) style:UITableViewStylePlain];
    _userTableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    _userTableView.scrollEnabled = YES;
    _userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bgScrollView addSubview:_userTableView];
    
    UILabel *scanLab = [[UILabel alloc] init];
    scanLab.text = @"我是有底线的~";
    scanLab.font = [UIFont systemFontOfSize:12];
    scanLab.textColor = [UIColor grayColor];
    scanLab.textAlignment = NSTextAlignmentCenter;
    [_bgScrollView addSubview:scanLab];
    [scanLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userTableView.bottom).offset(10);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(20);
    }];

}

@end
