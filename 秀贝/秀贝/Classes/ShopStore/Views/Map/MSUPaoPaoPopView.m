//
//  MSUPaoPaoPopView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPaoPaoPopView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth self.frame.size.width
#define SelfHeight self.frame.size.height

@implementation MSUPaoPaoPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.locaLab = [[UILabel alloc] init];
    _locaLab.font = [UIFont systemFontOfSize:16];
    _locaLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_locaLab];
    [_locaLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(20);
    }];
    
    self.popTablView = [[UITableView alloc] initWithFrame:CGRectMake(10, 45, SelfWidth-20, SelfHeight-45-50) style:UITableViewStylePlain];
    _popTablView.backgroundColor = [UIColor clearColor];
    [self addSubview:_popTablView];

    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn.backgroundColor = [UIColor blueColor];
    _closeBtn.layer.cornerRadius = 15;
    _closeBtn.layer.shouldRasterize = YES;
    _closeBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:_closeBtn];
    [_closeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_popTablView.bottom).offset(8);
        make.left.equalTo(self.left).offset(SelfWidth * 0.5-25);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];

    
}

@end
