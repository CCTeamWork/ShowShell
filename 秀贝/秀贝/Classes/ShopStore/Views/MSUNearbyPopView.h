//
//  MSUNearbyPopView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/14.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUNearbyPopView : UIView

/// 按钮数组
@property (nonatomic , strong) NSMutableArray *btnArr;

- (instancetype)initWithFrame:(CGRect)frame titArr:(NSArray *)titArr rowSize:(CGSize)size;

@end
