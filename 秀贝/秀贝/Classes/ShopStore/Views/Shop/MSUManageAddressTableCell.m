//
//  MSUManageAddressTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUManageAddressTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUPathTools.h"

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUManageAddressTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.userLab = [[UILabel alloc] init];
    _userLab.textColor = [UIColor blackColor];
    _userLab.font = [UIFont systemFontOfSize:18];
    [self addSubview:_userLab];
    [_userLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(100);
        make.height.equalTo(10);
    }];
    
    self.numLab = [[UILabel alloc] init];
    _numLab.textAlignment = NSTextAlignmentRight;
    _numLab.textColor = HEXCOLOR(0x333333);
    _numLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_userLab.bottom).offset(0);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(100);
        make.height.equalTo(10);
    }];
    
    self.addressLab = [[UILabel alloc] init];
    _addressLab.textColor = HEXCOLOR(0x333333);
    _addressLab.font = [UIFont systemFontOfSize:14];
    _addressLab.numberOfLines = 0;
    [self addSubview:_addressLab];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLab.bottom).offset(15);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.equalTo(1);
    }];
    
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = HEXCOLOR(0xffffff);
    [self addSubview:navView];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo([UIScreen mainScreen].bounds.size);
        make.height.equalTo(34);
    }];

    
    self.defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_defaultBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
    [_defaultBtn setTitle:@"默认地址" forState:UIControlStateSelected];
    [_defaultBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [_defaultBtn setTitleColor:HEXCOLOR(0xff4e1e) forState:UIControlStateSelected];
    _defaultBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _defaultBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_defaultBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"video-product-choose"] forState:UIControlStateNormal];
    [_defaultBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"WechatIMG169"] forState:UIControlStateSelected];
    _defaultBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _defaultBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    _defaultBtn.backgroundColor = [UIColor whiteColor];
    _defaultBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_defaultBtn];
    [_defaultBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.top).offset(0);
        make.left.equalTo(navView.left).offset(14);
        make.width.equalTo(110);
        make.height.equalTo(34);
    }];

    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_deleteBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"address-delete"] forState:UIControlStateNormal];
    _deleteBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    _deleteBtn.backgroundColor = [UIColor whiteColor];
    _deleteBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_deleteBtn];
    [_deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.top).offset(0);
        make.right.equalTo(navView.right).offset(-14);
        make.width.equalTo(50);
        make.height.equalTo(34);
    }];
    
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self addSubview:line1View];
    [line1View makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_deleteBtn.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.equalTo(10);
    }];
}

@end
