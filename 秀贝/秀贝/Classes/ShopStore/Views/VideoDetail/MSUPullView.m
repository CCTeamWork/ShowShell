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

#define SelfWidth [UIScreen mainScreen].bounds.size.width

@implementation MSUPullView

- (instancetype)initWithFrame:(CGRect)frame imaArr:(NSArray *)imaArr tittleArr:(NSArray *)tittleArr
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithImaArr:imaArr tittleArr:tittleArr];
        
    }
    return self;
}


- (void)createViewWithImaArr:(NSArray *)imaArr tittleArr:(NSArray *)tittleArr{
    for (NSInteger i = 0; i < imaArr.count; i++) {
        UIImageView *wolfIma = [[UIImageView alloc] init];
        wolfIma.image = [MSUPathTools showImageWithContentOfFileByName:imaArr[i]];
        wolfIma.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:wolfIma];
        [wolfIma makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(12.5+40*i);
            make.left.equalTo(self.left).offset(30);
            make.width.equalTo(15);
            make.height.equalTo(15);
        }];

        
        UILabel *seeLab = [[UILabel alloc] init];
        seeLab.text = tittleArr[i];
        seeLab.textColor = [UIColor grayColor];
        seeLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:seeLab];
        [seeLab makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wolfIma.centerY).offset(0);
            make.left.equalTo(wolfIma.right).offset(10);
            make.width.equalTo(60);
            make.height.equalTo(20);
        }];

        UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        privateBtn.frame = CGRectMake(0, 40*i, 120, 39);
        privateBtn.adjustsImageWhenHighlighted = NO;
        [self addSubview:privateBtn];
        [self.btnArr addObject:privateBtn];
        
        UIView *navView = [[UIView alloc] init];
        navView.frame = CGRectMake(0, 39, 120, 1);
        navView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        [privateBtn addSubview:navView];
    }
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        self.btnArr  = [NSMutableArray array];
    }
    return _btnArr;
}

@end
