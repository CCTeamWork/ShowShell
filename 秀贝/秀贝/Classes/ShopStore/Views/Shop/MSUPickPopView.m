//
//  MSUPickPopView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPickPopView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth self.frame.size.width
#define SelfHeight self.frame.size.height

@implementation MSUPickPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UILabel *seeLab = [[UILabel alloc] init];
    seeLab.textAlignment = NSTextAlignmentLeft;
    seeLab.text = @"请选择省市";
    seeLab.textColor = [UIColor blackColor];
    seeLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:seeLab];
    [seeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(20);
        make.width.equalTo(150);
        make.height.equalTo(20);
    }];
    
    self.picker = [[UIPickerView alloc] init];
    _picker.showsSelectionIndicator = NO;
    _picker.backgroundColor = [UIColor whiteColor];
    _picker.alpha = 0.7;
    [self addSubview:_picker];
    [_picker makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seeLab.bottom).offset(10);
        make.left.equalTo(self.left).offset(20);
        make.width.equalTo(SelfWidth-40);
        make.height.equalTo(SelfHeight-40-40-10);
    }];

    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _sureBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_sureBtn];
    [_sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(50);
        make.height.equalTo(40);
    }];

    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _cancelBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_cancelBtn];
    [_cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.right.equalTo(_sureBtn.left).offset(-10);
        make.width.equalTo(50);
        make.height.equalTo(40);
    }];
}

@end
