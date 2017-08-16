//
//  MSUShopSelectView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopSelectView.h"
#import "MSUShopSelectTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height


#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation MSUShopSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.backgroundColor = HEXCOLOR(0xf49418);
    [_buyBtn setTitle:@"我要买" forState:UIControlStateNormal];
    [_buyBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _buyBtn .titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_buyBtn];
    [_buyBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(45);
    }];
    
    self.seleTableView = [[UITableView alloc] init];
    _seleTableView.backgroundColor = HEXCOLOR(0xffffff);
    _seleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_seleTableView registerClass:[MSUShopSelectTableCell class] forCellReuseIdentifier:@"selectShopCell"];
    [self addSubview:_seleTableView];
    [_seleTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfHeight-270-45);
    }];


}

@end
