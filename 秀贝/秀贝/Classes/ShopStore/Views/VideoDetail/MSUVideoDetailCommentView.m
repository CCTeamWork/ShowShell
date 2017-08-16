//
//  MSUVideoDetailCommentView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUVideoDetailCommentView.h"

#define SelfWidth self.frame.size.width
//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "MSUVideoCommentTableCell.h"

@implementation MSUVideoDetailCommentView

- (instancetype)initWithFrame:(CGRect)frame tableViewHeight:(CGFloat)height
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithHeight:height];
        
    }
    return self;
}


- (void)createViewWithHeight:(CGFloat)height{
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor whiteColor];
    [self addSubview:navView];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(50);
    }];
    
    // 标题 评论
    self.titLab = [[UILabel alloc] init];
//    _titLab.backgroundColor = [UIColor redColor];
    _titLab.font = [UIFont systemFontOfSize:14];
    _titLab.textColor = HEXCOLOR(0x333333);
    [navView addSubview:_titLab];
    [_titLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(20);
    }];
    
    
    // tableview
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, SelfWidth, height) style:UITableViewStylePlain];
    self.tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.rowHeight = height*0.5 ;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.userInteractionEnabled = NO;
    [_tableView registerClass:[MSUVideoCommentTableCell class] forCellReuseIdentifier:@"commentVideoShopCell"];
    [self addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(35);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(height);
    }];
    
    self.comeLab = [[UILabel alloc] init];
    _comeLab.backgroundColor = [UIColor clearColor];
    _comeLab.text = @"快来发表你的评论吧~";
    _comeLab.textAlignment = NSTextAlignmentCenter;
    _comeLab.font = [UIFont systemFontOfSize:11];
    _comeLab.textColor = HEXCOLOR(0xf49418);
    [self addSubview:_comeLab];
    [_comeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.bottom).offset(10);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(20);
    }];
    _comeLab.hidden = YES;
    

    
    
}

@end
