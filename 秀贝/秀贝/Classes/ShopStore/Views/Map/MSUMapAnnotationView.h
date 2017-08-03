//
//  MSUMapAnnotationView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/1.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUMapAnnotationView : UIView

/// 图片
@property (nonatomic , strong) UIImageView *annoImaView;

/// 昵称
@property (nonatomic , strong) UILabel *annoNickLab;

/// 地址名称
@property (nonatomic , strong) UIButton *annoAddBtn;



@end
