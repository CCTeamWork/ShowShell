//
//  MSUShareController.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/6/30.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUShareController : UIViewController

/* ShareSDK 分享内容相关 */
+ (void)makeShareSomeContentWithText:(NSString *)text title:(NSString *)title url:(NSString *)url;

@end
