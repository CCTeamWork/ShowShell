//
//  AppDelegate.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  alipyDelegate <NSObject>

-(void)alipydidSuccess;
-(void)alipydidFaile;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/// 判断是否横竖屏
@property (nonatomic,assign)BOOL allowRotation;

@property (weak  , nonatomic) id<alipyDelegate> aliDelegate;  

@end

