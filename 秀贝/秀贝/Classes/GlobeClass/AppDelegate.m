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
#import "MSUAliPayController.h"

// 推送
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

// 网络接口
#import "MSUAFNRequest.h"

// ShareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”

//#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI/BMapKit.h>


@interface AppDelegate ()<UNUserNotificationCenterDelegate>
{
    BMKMapManager* mapManager;
}
@end

@implementation AppDelegate

-(void)setupBaiduMap
{
    mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:@"EHsSKUFoGbPuNNUSebBbiOOgm4bcAFiV" generalDelegate:nil];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    MSUTabbarController *tab = [[MSUTabbarController alloc] init];
    self.window.rootViewController = tab;
    
    self.window.backgroundColor = WHITECOLOR;
    [self.window makeKeyAndVisible];
    
    /// 状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    // 推送相关
    [self pushNotifacationByRequestAuthorizatonAndregisterNotificationWithApplication:application];
   
    // 远程通知相关数据处理
    if (launchOptions) {
        NSDictionary *dict = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dict) {
            // 处理远程通知中的数据
        }
    }
    
    // ShareSDK 分享登录相关
    [self registShareSDKInAppDelegate];
    
    // 百度地图
    [self setupBaiduMap];
    
    return YES;
}

/* 请求用户权限 - 注册远程通知 */
- (void)pushNotifacationByRequestAuthorizatonAndregisterNotificationWithApplication:(UIApplication *)application{
    if (iOS10) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        
//        // 3D Touch模式时 通知回复
//        UNNotificationAction *touchAction = [UNNotificationAction actionWithIdentifier:@"reply" title:@"回复" options:UNNotificationActionOptionNone];
//        // 锁屏模式时 通知清除
//        UNNotificationAction *clearAction = [UNNotificationAction actionWithIdentifier:@"clear" title:@"清除" options:UNNotificationActionOptionNone];
//        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"message" actions:@[touchAction,clearAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone | UNNotificationCategoryOptionCustomDismissAction];
//        [center setNotificationCategories:[NSSet setWithArray:@[category]]];
//        
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
    }else if (iOS8){
        //iOS8 - iOS10
        // 申请用户权限
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        
    }
    
    //此方法不写 无法调用接收推送回调方法 didRegisterForRemoteNotificationsWithDeviceToken
    //注册远程通知
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

/* ShareSDK 相关 */
- (void)registShareSDKInAppDelegate{
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeMail),
                                        @(SSDKPlatformTypeSMS),
                                        @(SSDKPlatformSubTypeWechatSession),
                                        @(SSDKPlatformTypeCopy),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx22006fc61e72b8f5"
                                       appSecret:@"6311b622ae833268549327911687e68d"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106173201"
                                      appKey:@"0LWOygzhwqFQyuQr"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [BMKMapView willBackGround];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 进入app后，将程序通知数量设置为0
//    [application setApplicationIconBadgeNumber:0];
    [BMKMapView didForeGround];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 横竖屏
/* 横竖屏 */
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    if (self.allowRotation) {
//        return  UIInterfaceOrientationMaskAllButUpsideDown;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}

#pragma mark - 支付宝相关
/* NOTE: 9.0以后使用新API接口 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    // 支付完成回调相关
    [MSUAliPayController appDelegatePaySomethingWithurl:url];
    
    return YES;
}

#pragma mark - 推送相关
/* 获取苹果服务器返回的 Device Token */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *tokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceTokenString : %@", tokenString);

    // 返给后台 deviceToken 必须返回
    NSString *urlHttp = @"http://192.168.10.90/index.php?r=personalorder/apns";
//    NSString *urlString = [urlHttp stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSString *urlString = [urlHttp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
    NSLog(@"远程推送接收失败: %@", error);
}

/* iOS10 以下版本 接收到推送消息的代理方法 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"-----------接收到了远程通知--------------%@",userInfo);
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"Inactive 锁屏");
        completionHandler(UIBackgroundFetchResultNewData);
        
    } else if (application.applicationState == UIApplicationStateActive){
        NSLog(@"Active 前台");
        completionHandler(UIBackgroundFetchResultNewData);

    } else if (application.applicationState == UIApplicationStateBackground){
        NSLog(@"Backround 后台");
        completionHandler(UIBackgroundFetchResultNewData);

    }
}

/* iOS10 以后版本新增代理 关闭或后台模式 点击通知栏会调用这个方法 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSLog(@"iOS10 后新增代理 点击通知栏会调用这个方法");
//    NSDictionary *dict = response.notification.request.content.userInfo;
    
//    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
//    
//    if ([categoryIdentifier isEqualToString:@"message"]) {//识别需要被处理的拓展
//        
//        if ([response.actionIdentifier isEqualToString:@"回复"]) {//识别用户点击的是哪个 action
//            
//            //假设点击了输入内容的 UNTextInputNotificationAction 把 response 强转类型
//            UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse*)response;
//            //获取输入内容
//            NSString *userText = textResponse.userText;
//            //发送 userText 给需要接收的方法
//
//        } else if ([response.actionIdentifier isEqualToString:@"清除"]){
//            
//        }
//    }
}

/* iOS10 以后版本新增代理 前台模式 可显示通知提示内容 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSLog(@"iOS10 后新增代理 前台可显示通知提示内容");
    // 显示通知
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


@end
