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
#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

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
    CGFloat topHeight = 135 + imaWidth + 10+10 ;
    
    self.bgScrollView = [[UIScrollView alloc] init];
    _bgScrollView.scrollEnabled = YES;
    _bgScrollView.backgroundColor = HEXCOLOR(0xf4f4f4);
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
        make.height.equalTo(135 + imaWidth + 10);
    }];
    
    self.userLab = [[UILabel alloc] init];
    _userLab.font = [UIFont systemFontOfSize:12];
    _userLab.textColor = HEXCOLOR(0x333333);
    [topView addSubview:_userLab];
    [_userLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.top).offset(10);
        make.left.equalTo(topView.left).offset(14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(20);
    }];
    
    self.moreUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _moreBtn.backgroundColor = [UIColor clearColor];
    [_moreUserBtn setTitle:@"更多>>" forState:UIControlStateNormal];
    _moreUserBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_moreUserBtn setTitleColor:HEXCOLOR(0xf49418) forState:UIControlStateNormal];
    [topView addSubview:_moreUserBtn];
    [_moreUserBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.top).offset(10);
        make.right.equalTo(topView.right).offset(-14);
        make.width.equalTo(41);
        make.height.equalTo(20);
    }];
    
    self.userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userBtn.backgroundColor = [UIColor clearColor];
    [topView addSubview:_userBtn];
    [_userBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.top).offset(0);
        make.left.equalTo(topView.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(40);
    }];

    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf4f4f4);
    [topView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userLab.bottom).offset(10);
        make.left.equalTo(_userLab.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(1);
    }];
    
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.backgroundColor = [UIColor orangeColor];
    _iconBtn.layer.cornerRadius = 22.5;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [topView addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(15);
        make.left.equalTo(topView.left).offset(14);
        make.width.equalTo(45);
        make.height.equalTo(45);
    }];
    
    self.userNickLab = [[UILabel alloc] init];
    _userNickLab.font = [UIFont systemFontOfSize:14];
    _userNickLab.textColor = HEXCOLOR(0x333333);
    [topView addSubview:_userNickLab];
    [_userNickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(20);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(20);
    }];
    
    self.introLab = [[UILabel alloc] init];
    _introLab.font = [UIFont systemFontOfSize:12];
    _introLab.textColor = HEXCOLOR(0x757575);
    [topView addSubview:_introLab];
    [_introLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNickLab.bottom).offset(5);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(20);
    }];
    
    self.attenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _moreBtn.backgroundColor = [UIColor clearColor];
    [_attenBtn setTitle:@"╋ 关注" forState:UIControlStateNormal];
    _attenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_attenBtn setTitleColor:HEXCOLOR(0xf7bf26) forState:UIControlStateNormal];
    _attenBtn.layer.borderWidth = 1;
    _attenBtn.layer.borderColor = HEXCOLOR(0xf4f4f4).CGColor;
    [topView addSubview:_attenBtn];
    [_attenBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(26);
        make.right.equalTo(topView.right).offset(-14);
        make.width.equalTo(60);
        make.height.equalTo(25);
    }];
    
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = HEXCOLOR(0xf4f4f4);
    [topView addSubview:line1View];
    [line1View makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introLab.bottom).offset(15);
        make.left.equalTo(_introLab.left).offset(0);
        make.width.equalTo(SelfWidth-69-14);
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
            make.top.equalTo(line1View.bottom).offset(10);
            make.left.equalTo(_userLab.left).offset((imaWidth+5)*i);
            make.width.equalTo(imaWidth);
            make.height.equalTo(imaWidth);
        }];
        [self.infoArr addObject:_infoBtn];
    }
    
    self.arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _arrowBtn.backgroundColor = [UIColor redColor];
    _arrowBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_arrowBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"more"] forState:UIControlStateNormal];
    [topView addSubview:_arrowBtn];
    [_arrowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1View.bottom).offset(10);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(20);
        make.height.equalTo(imaWidth);
    }];

    // 动态朋友圈
    self.danamicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topHeight, SelfWidth, height) style:UITableViewStylePlain];
    _danamicTableView.backgroundColor = [UIColor whiteColor];
    _danamicTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_bgScrollView addSubview:_danamicTableView];
    _danamicTableView.scrollEnabled = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, 32)];
    
    UILabel *seeLab = [[UILabel alloc] init];
    seeLab.text = @"相关视频";
    seeLab.textColor = HEXCOLOR(0x333333);
    seeLab.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:seeLab];
    [seeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.top).offset(0);
        make.left.equalTo(headerView.left).offset(14);
        make.width.equalTo(60);
        make.height.equalTo(31);
    }];
    
    self.moreVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _moreBtn.backgroundColor = [UIColor clearColor];
    [_moreVideoBtn setTitle:@"更多>>" forState:UIControlStateNormal];
    _moreVideoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_moreVideoBtn setTitleColor:HEXCOLOR(0xf49418) forState:UIControlStateNormal];
    [headerView addSubview:_moreVideoBtn];
    [_moreVideoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.top).offset(0);
        make.right.equalTo(headerView.right).offset(-14);
        make.width.equalTo(41);
        make.height.equalTo(32);
    }];
    _danamicTableView.tableHeaderView = headerView;
    
    UIView *line2View = [[UIView alloc] init];
    line2View.backgroundColor = HEXCOLOR(0xf4f4f4);
    [headerView addSubview:line2View];
    [line2View makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seeLab.bottom).offset(0);
        make.left.equalTo(headerView.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(1);
    }];
    
    UIView *hotView = [[UIView alloc] init];
    hotView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:hotView];
    [hotView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_danamicTableView.bottom).offset(0);
        make.left.equalTo(_bgScrollView.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(32);
    }];

    
    UILabel *hotLab = [[UILabel alloc] init];
    hotLab.text = @"热卖";
    hotLab.font = [UIFont systemFontOfSize:12];
    hotLab.textColor = HEXCOLOR(0x333333);
    [hotView addSubview:hotLab];
    [hotLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hotView.top).offset(0);
        make.left.equalTo(_bgScrollView.left).offset(14);
        make.width.equalTo(30);
        make.height.equalTo(32);
    }];
    
    UIImageView *hotIma = [[UIImageView alloc] init];
    hotIma.backgroundColor = [UIColor yellowColor];
    hotIma.image = [MSUPathTools showImageWithContentOfFileByName:@"search-hot"];
    [hotView addSubview:hotIma];
    [hotIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hotView.top).offset(6);
        make.left.equalTo(hotLab.right).offset(0);
        make.width.equalTo(30);
        make.height.equalTo(20);
    }];
    
    self.moreShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _moreBtn.backgroundColor = [UIColor clearColor];
    [_moreShopBtn setTitle:@"更多>>" forState:UIControlStateNormal];
    _moreShopBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_moreShopBtn setTitleColor:HEXCOLOR(0xf49418) forState:UIControlStateNormal];
    [hotView addSubview:_moreShopBtn];
    [_moreShopBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hotView.top).offset(12);
        make.right.equalTo(hotView.right).offset(-14);
        make.width.equalTo(41);
        make.height.equalTo(20);
    }];

    self.hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topHeight + height + 32, SelfWidth, 97*3) style:UITableViewStylePlain];
    _hotTableView.backgroundColor = [UIColor brownColor];
    _hotTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_bgScrollView addSubview:_hotTableView];

}

@end
