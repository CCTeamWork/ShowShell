//
//  MSUAliPayController.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/6/30.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUAliPayController : UIViewController

/* AppDelegate 中需要实现的代码 */
+ (void)appDelegatePaySomethingWithurl:(NSURL *)url;

/* 支付功能 */
+ (void)payForSomethingWithAliPay;

@end
