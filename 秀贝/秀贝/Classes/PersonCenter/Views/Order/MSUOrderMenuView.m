//
//  MSUOrderMenuView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/9.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUOrderMenuView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width

@implementation MSUOrderMenuView

- (instancetype)initWithFrame:(CGRect)frame titArr:(NSArray *)arr
{
    if (self = [super initWithFrame:frame]) {
        self.btnArr = [NSMutableArray array];
        [self createViewWithArr:arr];
        
    }
    return self;
}


- (void)createViewWithArr:(NSArray *)arr{
    CGFloat btnWid = (SelfWidth-60-20*3)/4;
    for (NSInteger i = 0; i < arr.count; i++) {
        self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuBtn.adjustsImageWhenHighlighted = NO;
//        _menuBtn.backgroundColor = [UIColor orangeColor];
        [_menuBtn setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        [_menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_menuBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        _menuBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        //        _seleBtn.tag = 2017 + i;
        [self addSubview:_menuBtn];
        [_menuBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(0);
            make.left.equalTo(self.left).offset(30+(btnWid+20)*i);
            make.width.equalTo(btnWid);
            make.height.equalTo(38);
        }];
        [self.btnArr addObject:_menuBtn];
    }
    
    self.lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_lineView];

}

@end
