//
//  MSUTransitionTool.m
//  AnimationTest
//
//  Created by Zhuge_Su on 2017/6/19.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUTransitionTool.h"
#import <QuartzCore/QuartzCore.h>

@implementation MSUTransitionTool

+ (void)transitionControllerWithType:(MSUTransitionType)type durationTime:(float)dutation direction:(MSUTransitionDerection)direction
{
    // 初始化
    CATransition *trans = [CATransition animation];
    // 动画时间
    trans.duration = dutation;
    // 转场动画效果
    switch (type) {
        case MSUMovein:
            //弹出
            trans.type = kCATransitionMoveIn;
            break;
        case MSUPush:
            //推出
            trans.type = kCATransitionPush;
            break;
        case MSUFade:
            //翻页
            trans.type = kCATransitionFade;
            break;
        case MSUReveal:
            //平移
            trans.type = kCATransitionReveal;
            break;

#pragma mark - 私有API，请勿在需要上架的APP上使用
        case MSUPageCurl:
        {
            //向上翻一页
            trans.type = @"pageCurl";
        }
            break;
        case MSUPageUnCurl:
        {
            //向下翻一页
            trans.type = @"pageUnCurl";
        }
            break;
        case MSURippleEffect:
        {
            //波纹
            trans.type = @"rippleEffect";
        }
            break;
        case MSUSuckEffect:
        {
            //吸收
            trans.type = @"suckEffect";
        }
            break;
        case MSUCube:
        {
            //立方体
            trans.type = @"cube";
        }
            break;
        case MSUCameraIrisHollowOpen:
        {
            //镜头开
            trans.type = @"cameraIrisHollowOpen";
        }
            break;
        case MSUOglFlip:
        {
            //翻转
            trans.type = @"oglFlip";
        }
            break;
        case MSUCameraIrisHollowClose:
        {
            //镜头关
            trans.type = @"cameraIrisHollowClose";
        }
            break;
        default:
        break;
    }
    //转场动画方向:
    switch (direction) {
        case MSULeft:
            trans.subtype = kCATransitionFromLeft;
            break;
        case MSURight:
            trans.subtype = kCATransitionFromRight;
            break;
        case MSUTop:
            trans.subtype = kCATransitionFromTop;
            break;
        case MSUBottom:
            trans.subtype = kCATransitionFromBottom;
            break;
        case MSUMiddle:
            trans.subtype = kCATruncationMiddle;
            break;
        default:
            break;
    }
    // 添加到keyWindows上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:trans forKey:nil];
    
}

@end
