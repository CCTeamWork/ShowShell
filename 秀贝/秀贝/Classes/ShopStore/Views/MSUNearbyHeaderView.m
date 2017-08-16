//
//  MSUNearbyHeaderView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/25.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUNearbyHeaderView.h"

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUNearbyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(self.frame.size.width);
        make.height.equalTo(45);
    }];
    
    UIImageView *mapIma = [[UIImageView alloc] init];
//    mapIma.backgroundColor = [UIColor yellowColor];
    mapIma.contentMode = UIViewContentModeScaleAspectFit;
    mapIma.image = [UIImage imageNamed:@"state-location"];
    [bgView addSubview:mapIma];
    [mapIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(15);
        make.left.equalTo(bgView.left).offset(24);
        make.width.equalTo(20);
        make.height.equalTo(15);
    }];
    
    UILabel *scanLab = [[UILabel alloc] init];
//    scanLab.backgroundColor = [UIColor brownColor];
    scanLab.text = @"我在 ：";
    scanLab.font = [UIFont systemFontOfSize:14];
    scanLab.textColor = HEXCOLOR(0x333333);
    [bgView addSubview:scanLab];
    [scanLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.left.equalTo(mapIma.right).offset(10);
        make.width.equalTo(47);
        make.height.equalTo(45);
    }];

    self.positionLab = [[UILabel alloc] init];
//    _positionLab.backgroundColor = [UIColor redColor];
    _positionLab.font = [UIFont systemFontOfSize:14];
    _positionLab.textColor = HEXCOLOR(0x333333);
    [bgView addSubview:_positionLab];
    [_positionLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.left.equalTo(scanLab.right).offset(0);
        make.width.equalTo(self.frame.size.width);
        make.height.equalTo(45);
    }];
    
    
    self.positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _positionBtn.backgroundColor = [UIColor clearColor];
    _positionBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:_positionBtn];
    [_positionBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(self.frame.size.width);
        make.height.equalTo(45);
    }];

    
}

@end
