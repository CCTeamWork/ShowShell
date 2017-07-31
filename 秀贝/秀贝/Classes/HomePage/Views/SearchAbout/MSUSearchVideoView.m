//
//  MSUSearchVideoView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchVideoView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@implementation MSUSearchVideoView

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
    _bgScrollView.contentSize = CGSizeMake(0, height+120);
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_bgScrollView];
    [_bgScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfHeight);
    }];
    
    self.videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height) style:UITableViewStylePlain];
    _videoTableView.backgroundColor = [UIColor whiteColor];
    _videoTableView.scrollEnabled = YES;
    [_bgScrollView addSubview:_videoTableView];
}

@end
