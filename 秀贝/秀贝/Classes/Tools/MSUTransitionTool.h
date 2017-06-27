//
//  MSUTransitionTool.h
//  AnimationTest
//
//  Created by Zhuge_Su on 2017/6/19.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/* 转场动画样式 */
typedef NS_ENUM(NSInteger , MSUTransitionType){
    MSUFade = 0,                //翻页
    MSUMovein,                  //弹进
    MSUPush,                    //推出
    MSUReveal,                  //弹出
    
#pragma mark - 私有API，请勿在需要上架的APP上使用
    MSUPageCurl,                //向上翻一页
    MSUPageUnCurl,              //向下翻一页
    MSURippleEffect,            //波纹
    MSUSuckEffect,              //吸收
    MSUCube,                    //立方体
    MSUOglFlip,                 //翻转
    MSUCameraIrisHollowOpen,    //镜头开
    MSUCameraIrisHollowClose    //镜头关
};

/* 转场动画方向 */
typedef NS_ENUM(NSInteger , MSUTransitionDerection){
    MSULeft = 0,        //左
    MSURight,           //右
    MSUTop,             //顶
    MSUBottom,          //底
    MSUMiddle
};

@interface MSUTransitionTool : NSObject

+ (void)transitionControllerWithType:(MSUTransitionType)type durationTime:(float)dutation direction:(MSUTransitionDerection)direction;

@end
