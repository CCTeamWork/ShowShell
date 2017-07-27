//
//  MSUNearbyHeaderView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/25.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUNearbyHeaderView.h"

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
        make.height.equalTo(50);
    }];
    
    UIImageView *mapIma = [[UIImageView alloc] init];
//    mapIma.backgroundColor = [UIColor yellowColor];
    mapIma.contentMode = UIViewContentModeScaleAspectFit;
    mapIma.image = [UIImage imageNamed:@"like"];
    [bgView addSubview:mapIma];
    [mapIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(10);
        make.left.equalTo(bgView.left).offset(20);
        make.width.equalTo(20);
        make.height.equalTo(30);
    }];
    
    UILabel *scanLab = [[UILabel alloc] init];
//    scanLab.backgroundColor = [UIColor brownColor];
    scanLab.text = @"我在 ：";
    scanLab.font = [UIFont systemFontOfSize:15];
    scanLab.textColor = [UIColor blackColor];
    [bgView addSubview:scanLab];
    [scanLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.left.equalTo(mapIma.right).offset(5);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];

    self.positionLab = [[UILabel alloc] init];
//    _positionLab.backgroundColor = [UIColor redColor];
    _positionLab.font = [UIFont systemFontOfSize:15];
    _positionLab.textColor = [UIColor blackColor];
    [bgView addSubview:_positionLab];
    [_positionLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.left.equalTo(scanLab.right).offset(0);
        make.width.equalTo(self.frame.size.width);
        make.height.equalTo(50);
    }];
    
    
//    self.positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _positionBtn.backgroundColor = [UIColor brownColor];
//    [bgView addSubview:_positionBtn];
//    [_positionBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(bgView.top).offset(10);
//        make.left.equalTo(bgView.left).offset(20);
//        make.width.equalTo(self.frame.size.width * 0.5);
//        make.height.equalTo(30);
//    }];

    
}

@end
