//
//  MSUMapAnnotationView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/1.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUMapAnnotationView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth self.frame.size.width


@implementation MSUMapAnnotationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}

// 10 + 50 + 10
- (void)createView{
    self.annoImaView = [[UIImageView alloc] init];
    _annoImaView.backgroundColor = [UIColor brownColor];
    [self addSubview:_annoImaView];
    [_annoImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    
    
    self.annoNickLab = [[UILabel alloc] init];
    _annoNickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self addSubview:_annoNickLab];
    [_annoNickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(_annoImaView.right).offset(5);
        make.width.equalTo(SelfWidth- 50 - 10);
        make.height.equalTo(20);
    }];
    
    self.annoAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_annoAddBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _annoAddBtn.userInteractionEnabled = NO;
    _annoAddBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _annoAddBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _annoAddBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    _annoAddBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_annoAddBtn];
    [_annoAddBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_annoNickLab.bottom).offset(5);
        make.left.equalTo(_annoImaView.right).offset(5);
        make.width.equalTo(SelfWidth- 50 - 10 - 10 -5);
        make.height.equalTo(20);
    }];
    
}

@end
