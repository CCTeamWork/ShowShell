//
//  MSUShopDetailBoottomView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopDetailBoottomView.h"
#import "MSUPathTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]


//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUShopDetailBoottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, 1)];
    bgView.backgroundColor = BGLINECOLOR;
    [self addSubview:bgView];
    
    self.letterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _letterBtn.backgroundColor = [UIColor whiteColor];
    [_letterBtn setTitle:@"私信" forState:UIControlStateNormal];
    [_letterBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _letterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _letterBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _letterBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_letterBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"like"] forState:UIControlStateNormal];
    _letterBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:_letterBtn];
    [_letterBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth*0.25);
        make.height.equalTo(49);
    }];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectBtn.backgroundColor = [UIColor whiteColor];
    [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [_collectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _collectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _collectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _collectBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_collectBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"like"] forState:UIControlStateNormal];
    _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:_collectBtn];
    [_collectBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.left.equalTo(_letterBtn.right).offset(0);
        make.width.equalTo(SelfWidth*0.25);
        make.height.equalTo(49);
    }];
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.backgroundColor = [UIColor redColor];
    [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    _buyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_buyBtn];
    [_buyBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.left.equalTo(_collectBtn.right).offset(0);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(49);
    }];

}

@end
