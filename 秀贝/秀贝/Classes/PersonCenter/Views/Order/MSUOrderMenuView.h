//
//  MSUOrderMenuView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/9.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUOrderMenuView : UIView

@property (nonatomic , strong) NSMutableArray *btnArr;
@property (nonatomic , strong) UIButton *menuBtn;
@property (nonatomic , strong) UIView *lineView;

- (instancetype)initWithFrame:(CGRect)frame titArr:(NSArray *)arr;

@end
