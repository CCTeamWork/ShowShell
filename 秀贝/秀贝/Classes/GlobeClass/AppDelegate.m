//
//  AppDelegate.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "AppDelegate.h"
#import "MSUPrefixHeader.pch"
#import "MSUTabbarController.h"

// 支付宝
#import <AlipaySDK/AlipaySDK.h>

// 推送
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

// 网络接口
#import "MSUAFNRequest.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    MSUTabbarController *tab = [[MSUTabbarController alloc] init];
    self.window.rootViewController = tab;
    
    self.window.backgroundColor = WHITECOLOR;
    [self.window makeKeyAndVisible];
    
    /// 状态栏字体颜色
    // [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 推送相关
    [self pushNotifacationByRequestAuthorizatonAndregisterNotificationWithApplication:application];
   

    return YES;
}

/* 请求用户权限 - 注册远程通知 */
- (void)pushNotifacationByRequestAuthorizatonAndregisterNotificationWithApplication:(UIApplication *)application{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        // 请求用户权限
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            // 点击允许
            if (granted) {
                NSLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"注册失败");
            }
        }];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        //iOS8 - iOS10
        // 申请用户权限
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        
    }
    
    //此方法不写 无法调用接收推送回调方法 didRegisterForRemoteNotificationsWithDeviceToken
    //注册远程通知
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 横竖屏
/* 横竖屏 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation) {
        return  UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 支付宝相关
/* NOTE: 9.0以后使用新API接口 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

#pragma mark - 推送相关
/* 获取苹果服务器返回的 Device Token */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *tokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceTokenString : %@", tokenString);

    // 返给后台 deviceToken 必须返回
    NSString *urlHttp = @"v.showbuy100.com/index.php?r=order/apns";
    NSString *urlString = [urlHttp stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    [[MSUAFNRequest sharedInstance] postRequestWithURL:urlString parameters:tokenString withBlock:^(id obj, NSError *error) {
        if (!error) {
            NSLog(@"------------obj--------------%@",obj);
        }else{
            NSLog(@"-----------error---------------%@",error);

        }
    }];
    
}

/* 获得Device Token失败 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

/* 接收到推送消息的代理方法 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"-----------接收到了远程通知--------------%@",userInfo);
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"Inactive");
        completionHandler(UIBackgroundFetchResultNewData);
        
    } else if (application.applicationState == UIApplicationStateActive){
        NSLog(@"Active");
        completionHandler(UIBackgroundFetchResultNewData);

    } else if (application.applicationState == UIApplicationStateBackground){
        NSLog(@"Backround");
        completionHandler(UIBackgroundFetchResultNewData);

    }
}

@end
