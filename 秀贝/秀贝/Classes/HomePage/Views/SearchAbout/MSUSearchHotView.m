//
//  MSUSearchHotView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchHotView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@implementation MSUSearchHotView

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
    
    UIView *hotView = [[UIView alloc] init];
    hotView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:hotView];
    [hotView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgScrollView.top).offset(0);
        make.left.equalTo(_bgScrollView.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(40);
    }];
    
    
    UILabel *hotLab = [[UILabel alloc] init];
    hotLab.text = @"热卖";
    hotLab.font = [UIFont systemFontOfSize:18];
    hotLab.textColor = [UIColor blackColor];
    [hotView addSubview:hotLab];
    [hotLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgScrollView.top).offset(10);
        make.left.equalTo(_bgScrollView.left).offset(15);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
    
    
    UIImageView *hotIma = [[UIImageView alloc] init];
    hotIma.backgroundColor = [UIColor yellowColor];
    //    hotIma.image = [MSUPathTools showImageWithContentOfFileByName:@"icon-z"];
    [hotView addSubview:hotIma];
    [hotIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgScrollView.top).offset(10);
        make.left.equalTo(hotLab.right).offset(0);
        make.width.equalTo(30);
        make.height.equalTo(20);
    }];

    
    self.hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, height) style:UITableViewStylePlain];
    _hotTableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    _hotTableView.scrollEnabled = YES;
    _hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bgScrollView addSubview:_hotTableView];

}

@end
