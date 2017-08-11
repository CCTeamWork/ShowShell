//
//  MSURefuncPopView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/11.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSURefuncPopView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUPathTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@implementation MSURefuncPopView

- (instancetype)initWithFrame:(CGRect)frame popHeight:(CGFloat)popHeight arr:(NSArray *)arr
{
    if (self = [super initWithFrame:frame]) {
        
        self.btnArr = [NSMutableArray array];
        [self createViewWithPopHeight:popHeight arr:arr];
        
    }
    return self;
}


- (void)createViewWithPopHeight:(CGFloat)height arr:(NSArray *)arr{
    for (NSInteger i = 0; i < arr.count; i++) {
        UILabel *reasonLab = [[UILabel alloc] init];
        reasonLab.frame = CGRectMake(10, 30*i, 100, 30);
        reasonLab.text = arr[i];
        reasonLab.textColor = [UIColor blackColor];
        reasonLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:reasonLab];
        
        UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        popBtn.frame = CGRectMake(0, 30*i, 140, 30);
        popBtn.backgroundColor = [UIColor clearColor];
        popBtn.tag = 2013 + i;
        [self addSubview:popBtn];
        [self.btnArr addObject:popBtn];
    }
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, 1, height);
    bgView.backgroundColor = BGLINECOLOR;
    [self addSubview:bgView];
    
    UIView *bg1View = [[UIView alloc] init];
    bg1View.frame = CGRectMake(0, height, 140, 1);
    bg1View.backgroundColor = BGLINECOLOR;
    [self addSubview:bg1View];
    
    UIView *bg2View = [[UIView alloc] init];
    bg2View.frame = CGRectMake(139, 0, 1, height);
    bg2View.backgroundColor = BGLINECOLOR;
    [self addSubview:bg2View];

    
    
}

@end
