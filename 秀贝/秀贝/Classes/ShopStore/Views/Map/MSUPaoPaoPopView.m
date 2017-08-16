//
//  MSUPaoPaoPopView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPaoPaoPopView.h"
#import "MSUPathTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

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
    _locaLab.font = [UIFont systemFontOfSize:14];
    _locaLab.textColor = HEXCOLOR(0xffffff);
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
    [_closeBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"map-close"] forState:UIControlStateNormal];
    _closeBtn.layer.cornerRadius = 12;
    _closeBtn.layer.shouldRasterize = YES;
    _closeBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:_closeBtn];
    [_closeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_popTablView.bottom).offset(10);
        make.left.equalTo(self.left).offset(SelfWidth * 0.5-12);
        make.width.equalTo(24);
        make.height.equalTo(24);
    }];

    
}

@end
