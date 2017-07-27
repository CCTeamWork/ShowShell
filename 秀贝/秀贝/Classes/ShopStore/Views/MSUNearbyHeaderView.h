//
//  MSUNearbyHeaderView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/25.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>
//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface MSUNearbyHeaderView : UIView

/// 定位信息按钮
@property (nonatomic , strong) UIButton *positionBtn;

/// 定位label
@property (nonatomic , strong) UILabel *positionLab;

@end
