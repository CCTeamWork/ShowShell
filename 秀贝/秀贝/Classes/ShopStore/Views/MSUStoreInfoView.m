//
//  MSUStoreInfoView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUStoreInfoView.h"
#import "MSUStringTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUStoreInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}

- (void)createView{
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor whiteColor];
    [self addSubview:navView];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(115);
    }];
    
    self.imaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentionBtn.layer.cornerRadius = 25;
    _attentionBtn.layer.shouldRasterize = YES;
    _attentionBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _imaBtn.backgroundColor = [UIColor whiteColor];
    [navView addSubview:_imaBtn];
    [_imaBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.top).offset(10);
        make.left.equalTo(navView.left).offset(20);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];

    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    _nickLab.textColor = [UIColor darkTextColor];
    [navView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imaBtn.top).offset(15);
        make.left.equalTo(_imaBtn.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(20);
    }];

    self.attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentionBtn.backgroundColor = [UIColor redColor];
    [_attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [_attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
    _attentionBtn.layer.cornerRadius = 3;
    _attentionBtn.layer.shouldRasterize = YES;
    _attentionBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [navView addSubview:_attentionBtn];
    [_attentionBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imaBtn.top).offset(8);
        make.right.equalTo(navView.right).offset(-20);
        make.width.equalTo(70);
        make.height.equalTo(30);
    }];
    
    
    UILabel *characLab = [[UILabel alloc] init];
//    characLab.backgroundColor = [UIColor yellowColor];
    characLab.font = [UIFont systemFontOfSize:10];
    characLab.textAlignment = NSTextAlignmentCenter;
    characLab.text = @"关注人数";
    characLab.textColor = [UIColor grayColor];
    [navView addSubview:characLab];
    [characLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imaBtn.bottom).offset(25);
        make.left.equalTo(_nickLab.left).offset(0);
        make.width.equalTo([MSUStringTools danamicGetWidthFromText:characLab.text WithFont:characLab.font].width);
        make.height.equalTo(20);
    }];
    
    self.attNumLab = [[UILabel alloc] init];
//    _attNumLab.backgroundColor = [UIColor yellowColor];
    _attNumLab.font = [UIFont systemFontOfSize:12];
    _attNumLab.textColor = [UIColor darkTextColor];
    _attNumLab.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:_attNumLab];
    [_attNumLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imaBtn.bottom).offset(10);
        make.centerX.equalTo(characLab.centerX).offset(2);
        make.width.equalTo([MSUStringTools danamicGetWidthFromText:@"2000.3万" WithFont:_attNumLab.font].width);
        make.height.equalTo(15);
    }];
    
    self.attNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attNumBtn.backgroundColor = [UIColor clearColor];
    [navView addSubview:_attNumBtn];
    [_attNumBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_attNumLab.top).offset(0);
        make.left.equalTo(characLab.left).offset(0);
        make.right.equalTo(characLab.right).offset(0);
        make.height.equalTo(30);
    }];

    
    // 分割线
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_attNumLab.top).offset(0);
        make.left.equalTo(characLab.right).offset(20);
        make.width.equalTo(1);
        make.height.equalTo(35);
    }];

    
    UILabel *shopLab = [[UILabel alloc] init];
    //    characLab.backgroundColor = [UIColor yellowColor];
    shopLab.font = [UIFont systemFontOfSize:10];
    shopLab.textAlignment = NSTextAlignmentCenter;
    shopLab.text = @"商品数量";
    shopLab.textColor = [UIColor grayColor];
    [navView addSubview:shopLab];
    [shopLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imaBtn.bottom).offset(25);
        make.left.equalTo(lineView.right).offset(20);
        make.width.equalTo([MSUStringTools danamicGetWidthFromText:shopLab.text WithFont:shopLab.font].width);
        make.height.equalTo(20);
    }];
    
    self.shopNumLab = [[UILabel alloc] init];
    //    _attNumLab.backgroundColor = [UIColor yellowColor];
    _shopNumLab.font = [UIFont systemFontOfSize:12];
    _shopNumLab.textColor = [UIColor darkTextColor];
    _shopNumLab.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:_shopNumLab];
    [_shopNumLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imaBtn.bottom).offset(10);
        make.centerX.equalTo(shopLab.centerX).offset(2);
        make.width.equalTo([MSUStringTools danamicGetWidthFromText:@"2000.3万" WithFont:_shopNumLab.font].width);
        make.height.equalTo(15);
    }];
    
    self.shopNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shopNumBtn.backgroundColor = [UIColor clearColor];
    [navView addSubview:_shopNumBtn];
    [_shopNumBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopNumLab.top).offset(0);
        make.left.equalTo(shopLab.left).offset(0);
        make.right.equalTo(shopLab.right).offset(0);
        make.height.equalTo(30);
    }];


}

@end
