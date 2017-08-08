//
//  MSUPushSetCenterView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/8.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUPushSetCenterView : UIView

@property (nonatomic , strong) UIButton *regularBtn;

@property (nonatomic , strong) UIButton *scaleBtn;

/// 视频佣金输入框
@property (nonatomic , strong) UITextField *videoTF;

/// 分享佣金输入框
@property (nonatomic , strong) UITextField *shareTF;

@property (nonatomic , strong) UIButton *askBtn;

@property (nonatomic , strong) UILabel *totalMoneyLab;

@property (nonatomic , strong) UIButton *longBtn;

@property (nonatomic , strong) UIButton *diyBtn;

@property (nonatomic , strong) UIView *timeBgView;
@property (nonatomic , strong) UIButton *leftTimeBtn;
@property (nonatomic , strong) UIButton *rightTimeBtn;

@property (nonatomic , strong) UIView *legalBgView;

@end
