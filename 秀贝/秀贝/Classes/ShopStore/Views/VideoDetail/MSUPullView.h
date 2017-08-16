//
//  MSUPullView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/4.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUPullView : UIView

/// 图片数组
@property (nonatomic , strong) NSMutableArray *imaArr;

/// label数组
@property (nonatomic , strong) NSMutableArray *labelArr;

/// 按钮数组
@property (nonatomic , strong) NSMutableArray *btnArr;

- (instancetype)initWithFrame:(CGRect)frame imaArr:(NSArray *)imaArr tittleArr:(NSArray *)tittleArr rowHeight:(CGFloat)height;

@end
