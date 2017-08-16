//
//  MSUPullView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/4.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPullView.h"
#import "MSUPathTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SelfWidth [UIScreen mainScreen].bounds.size.width

@implementation MSUPullView

- (instancetype)initWithFrame:(CGRect)frame imaArr:(NSArray *)imaArr tittleArr:(NSArray *)tittleArr rowHeight:(CGFloat)height
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithImaArr:imaArr tittleArr:tittleArr rowHeight:height];
        
    }
    return self;
}


- (void)createViewWithImaArr:(NSArray *)imaArr tittleArr:(NSArray *)tittleArr rowHeight:(CGFloat)height{
    for (NSInteger i = 0; i < tittleArr.count; i++) {
        UIImageView *wolfIma = [[UIImageView alloc] init];
        wolfIma.image = [MSUPathTools showImageWithContentOfFileByName:imaArr[i]];
        wolfIma.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:wolfIma];
        [wolfIma makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset((height-14)*0.5+height*i);
            make.left.equalTo(self.left).offset(35);
            make.width.equalTo(15);
            make.height.equalTo(14);
        }];
        [self.imaArr addObject:wolfIma];

        
        UILabel *seeLab = [[UILabel alloc] init];
        seeLab.text = tittleArr[i];
        seeLab.textColor = HEXCOLOR(0x333333);
        seeLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:seeLab];
        [seeLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(height*i);
            make.left.equalTo(wolfIma.right).offset(10);
            make.width.equalTo(60);
            make.height.equalTo(height);
        }];
        [self.labelArr addObject:seeLab];

        UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        privateBtn.backgroundColor = [UIColor clearColor];
        privateBtn.frame = CGRectMake(0, height*i, 135, height);
        privateBtn.adjustsImageWhenHighlighted = NO;
        [self addSubview:privateBtn];
        [self.btnArr addObject:privateBtn];
        
        UIView *navView = [[UIView alloc] init];
        navView.frame = CGRectMake(0, height-1, 135, 1);
        navView.backgroundColor = HEXCOLOR(0xf2f2f2);
        [privateBtn addSubview:navView];
    }
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        self.btnArr  = [NSMutableArray array];
    }
    return _btnArr;
}

- (NSMutableArray *)imaArr{
    if (!_imaArr) {
        self.imaArr  = [NSMutableArray array];
    }
    return _imaArr;
}

- (NSMutableArray *)labelArr{
    if (!_labelArr) {
        self.labelArr  = [NSMutableArray array];
    }
    return _labelArr;
}

@end
