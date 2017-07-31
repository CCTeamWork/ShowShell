//
//  MSUSearchTotalView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchTotalView.h"
#import "MSUPathTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@implementation MSUSearchTotalView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)arr tableHeight:(CGFloat)height
{
    if (self = [super initWithFrame:frame]) {
        self.infoArr = [NSMutableArray array];
        [self createViewWithArr:arr tableHeight:height];
    }
    return self;
}


- (void)createViewWithArr:(NSArray *)arr tableHeight:(CGFloat)height{
    CGFloat imaWidth = (SelfWidth-15*2-30 - 7*5)/arr.count;
    CGFloat topHeight = 30 + 10 + 10 + imaWidth + 10+10 ;
    
    self.bgScrollView = [[UIScrollView alloc] init];
    _bgScrollView.scrollEnabled = YES;
//    _bgScrollView.backgroundColor = [UIColor redColor];
    _bgScrollView.contentSize = CGSizeMake(0, topHeight + height+150+30 + 97*3);
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_bgScrollView];
    [_bgScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfHeight);
    }];

    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:topView];
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgScrollView.top).offset(0);
        make.left.equalTo(_bgScrollView.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(30 + 10 + 10 + imaWidth + 10);
    }];
    
    self.userLab = [[UILabel alloc] init];
    _userLab.font = [UIFont systemFontOfSize:18];
    _userLab.textColor = [UIColor blackColor];
    [topView addSubview:_userLab];
    [_userLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.top).offset(10);
        make.left.equalTo(topView.left).offset(15);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(20);
    }];
    
    self.userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userBtn.backgroundColor = [UIColor clearColor];
    [topView addSubview:_userBtn];
    [_userBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.top).offset(0);
        make.left.equalTo(topView.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(30);
    }];

    
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [topView addSubview:navView];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userLab.bottom).offset(10);
        make.left.equalTo(_userLab.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(1);
    }];

    for (NSInteger i = 0; i < arr.count; i++) {
        self.infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _infoBtn.backgroundColor = [UIColor redColor];
        _infoBtn.layer.cornerRadius = imaWidth/2;
        _infoBtn.layer.shouldRasterize = YES;
        _infoBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _infoBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_infoBtn setImage:[MSUPathTools showImageWithContentOfFileByName:arr[i]] forState:UIControlStateNormal] ;
        [topView addSubview:_infoBtn];
        [_infoBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.bottom).offset(10);
            make.left.equalTo(_userLab.left).offset((imaWidth+5)*i);
            make.width.equalTo(imaWidth);
            make.height.equalTo(imaWidth);
        }];
        [self.infoArr addObject:_infoBtn];
    }
    
    self.arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _arrowBtn.backgroundColor = [UIColor redColor];
    [topView addSubview:_arrowBtn];
    [_arrowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.bottom).offset(10);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(20);
        make.height.equalTo(imaWidth);
    }];

    // 动态朋友圈
    self.danamicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topHeight, SelfWidth, height) style:UITableViewStylePlain];
    _danamicTableView.backgroundColor = [UIColor whiteColor];
    _danamicTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_bgScrollView addSubview:_danamicTableView];
    
    UIView *hotView = [[UIView alloc] init];
    hotView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:hotView];
    [hotView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_danamicTableView.bottom).offset(0);
        make.left.equalTo(_bgScrollView.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(50);
    }];

    
    UILabel *hotLab = [[UILabel alloc] init];
    hotLab.text = @"热卖";
    hotLab.font = [UIFont systemFontOfSize:18];
    hotLab.textColor = [UIColor blackColor];
    [hotView addSubview:hotLab];
    [hotLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_danamicTableView.bottom).offset(10);
        make.left.equalTo(_bgScrollView.left).offset(15);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];

    
    UIImageView *hotIma = [[UIImageView alloc] init];
    hotIma.backgroundColor = [UIColor yellowColor];
//    hotIma.image = [MSUPathTools showImageWithContentOfFileByName:@"icon-z"];
    [hotView addSubview:hotIma];
    [hotIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_danamicTableView.bottom).offset(10);
        make.left.equalTo(hotLab.right).offset(0);
        make.width.equalTo(30);
        make.height.equalTo(20);
    }];

    self.hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topHeight + height + 40, SelfWidth, 97*3) style:UITableViewStylePlain];
    _hotTableView.backgroundColor = [UIColor brownColor];
    _hotTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_bgScrollView addSubview:_hotTableView];

}

@end
