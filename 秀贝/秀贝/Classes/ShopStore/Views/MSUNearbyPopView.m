//
//  MSUNearbyPopView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/14.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUNearbyPopView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUNearbyPopView

- (instancetype)initWithFrame:(CGRect)frame titArr:(NSArray *)titArr rowSize:(CGSize)size
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithTitArr:titArr size:size];
        
    }
    return self;
}


- (void)createViewWithTitArr:(NSArray *)tittleArr size:(CGSize)size{
    for (NSInteger i = 0; i < tittleArr.count; i++) {
        UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        privateBtn.frame = CGRectMake(0, size.height*i, size.width, size.height);
        [privateBtn setTitle:tittleArr[i] forState:UIControlStateNormal];
        privateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [privateBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        privateBtn.adjustsImageWhenHighlighted = NO;
        [self addSubview:privateBtn];
        [self.btnArr addObject:privateBtn];
        [privateBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(size.height*i);
            make.left.equalTo(self.left).offset(0);
            make.right.equalTo(self.right).offset(0);
            make.height.equalTo(size.height);
        }];
        
        UIView *navView = [[UIView alloc] init];
        navView.frame = CGRectMake(0, size.height-1, size.width, 1);
        navView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        [privateBtn addSubview:navView];
        [navView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(privateBtn.bottom).offset(-1);
            make.left.equalTo(privateBtn.left).offset(0);
            make.right.equalTo(privateBtn.right).offset(0);
            make.height.equalTo(1);
        }];

    }
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        self.btnArr  = [NSMutableArray array];
    }
    return _btnArr;
}



@end
