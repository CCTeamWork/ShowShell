//
//  MSUHousePopView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/8.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUHousePopView.h"

@implementation MSUHousePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.shareLab = [[UILabel alloc] init];
    _shareLab.frame = CGRectMake(0, 0, 100, 20);
    _shareLab.textAlignment = NSTextAlignmentCenter;
    _shareLab.textColor = [UIColor blackColor];
    _shareLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:_shareLab];
    
    self.videoLab = [[UILabel alloc] init];
    _videoLab.frame = CGRectMake(0, 20, 100, 20);
    _videoLab.textAlignment = NSTextAlignmentCenter;
    _videoLab.textColor = [UIColor blackColor];
    _videoLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:_videoLab];
    
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 45, 100, 1);
    navView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [self addSubview:navView];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(15, 57.5, 70, 25);
    [_editBtn setTitle:@"编辑推广" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _editBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _editBtn.layer.borderWidth = 1;
    _editBtn.layer.cornerRadius = 2;
    _editBtn.layer.shouldRasterize = YES;
    _editBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _editBtn.backgroundColor = [UIColor whiteColor];
    _editBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_editBtn];

}

@end
