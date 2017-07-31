//
//  MSUSearchResultView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSearchResultView : UIView

/// 选项按钮
@property (nonatomic , strong) UIButton *seleBtn;
@property (nonatomic , strong) NSMutableArray *seleArr;
@property (nonatomic , strong) UIView *underLineView;

/// 滚动视图
@property (nonatomic , strong) UIScrollView *scrollView;

@end
