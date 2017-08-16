//
//  MSUMapAnnotationView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/1.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUMapAnnotationView.h"
#import "MSUPathTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

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
        make.top.equalTo(self.top).offset(6.5);
        make.left.equalTo(self.left).offset(5);
        make.width.equalTo(42);
        make.height.equalTo(42);
    }];
    
    
    self.annoNickLab = [[UILabel alloc] init];
    _annoNickLab.font = [UIFont systemFontOfSize:11];
    _annoNickLab.textColor = HEXCOLOR(0x333333);
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self addSubview:_annoNickLab];
    [_annoNickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(8);
        make.left.equalTo(_annoImaView.right).offset(5);
        make.width.equalTo(SelfWidth- 47 - 5);
        make.height.equalTo(20);
    }];
    
    self.annoAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_annoAddBtn setTitleColor:HEXCOLOR(0x757575) forState:UIControlStateNormal];
    _annoAddBtn.userInteractionEnabled = NO;
    _annoAddBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    _annoAddBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
    [_annoAddBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"map-location"] forState:UIControlStateNormal];
    _annoAddBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    _annoAddBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_annoAddBtn];
    [_annoAddBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_annoNickLab.bottom).offset(-2);
        make.left.equalTo(_annoImaView.right).offset(5);
        make.width.equalTo(SelfWidth- 47 - 5 - 10);
        make.height.equalTo(20);
    }];
    
    UIImageView *wolfIma = [[UIImageView alloc] init];
    wolfIma.image = [MSUPathTools showImageWithContentOfFileByName:@"more"];
    wolfIma.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:wolfIma];
    [wolfIma makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-5);
        make.right.equalTo(self.right).offset(-7.5);
        make.width.equalTo(10);
        make.height.equalTo(10);
    }];

    
}

@end
