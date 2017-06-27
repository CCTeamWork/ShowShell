//
//  MSUImageTools.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPathTools.h"

@implementation MSUPathTools


/* NSBundle版加载图片 */
+ (UIImage *)showImageWithContentOfFileByName:(NSString *)imageName {
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],imageName ];
    return [UIImage imageWithContentsOfFile:path];
}

/* Plist 获取路径 并获取 数据字典*/
+ (NSMutableDictionary *)getPlistPathWithName:(NSString *)name type:(NSString *)type{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return dataDict;
}

/* Documents 文件路径 */
+ (NSString *)getDocumentsPathWithFileName:(NSString *)name{
    // 获取根目录
//    NSString *home = NSHomeDirectory();
    // 查找Documents文件
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接文件路径
    NSString *path = [doc stringByAppendingString:name];
    
    // 调用writeToFile将数据写入文件
    //NSArray *arr = @[@"lnj", @"28"];
    //[arr writeToFile:path atomically:YES];

    // NSDictionary *dict = @{@"name": @"lnj", @"age":@"28"};
    // [dict writeToFile:path atomically:YES];
    
    // 读取数据
    // NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];

    return path;
}

/* 跳转设置相关路径 */
+ (void)skipToSettingPathWithUrl:(MSUUrlType)type{
    NSString *str ;
    switch (type) {
        case MSUWIFI:
        {   //无线局域网
            str = @"App-Prefs:root=WIFI";
        }
            break;
        case MSUSIRI:
        {   //Siri
            str = @"App-Prefs:root=SIRI";
        }
            break;
        case MSUBluetooth:
        {   //蓝牙
            str = @" App-Prefs:root=Bluetooth";
        }
            break;
        case MSUCellularMobile:
        {   //蜂窝移动网络
            str = @"App-Prefs:root=MOBILE_DATA_SETTINGS_ID";
        }
            break;
        case MSUPersonalHotspot:
        {   //个人热点
            str = @"App-Prefs:root=INTERNET_TETHERING";
        }
            break;
        case MSUCarrier:
        {   //运营商
            str = @"App-Prefs:root=Carrier";
        }
            break;
        case MSUNotification:
        {   //通知
            str = @"App-Prefs:root=NOTIFICATIONS_ID";
        }
            break;
        case MSUGeneral:
        {   //通用
            str = @"App-Prefs:root=General";
        }
            break;
        case MSUAbout:
        {   //通用-关于本机
            str = @"App-Prefs:root=General&path=About";
        }
            break;
        case MSUKeyboard:
        {   //通用-键盘
            str = @"App-Prefs:root=General&path=Keyboard";
        }
            break;
        case MSUSupport:
        {   //通用-辅助功能
            str = @"App-Prefs:root=General&path=ACCESSIBILITY";
        }
            break;
        case MSULanguage:
        {   //通用-语言与地区
            str = @"App-Prefs:root=General&path=INTERNATIONAL";
        }
            break;
        case MSUReset:
        {   //通用-还原
            str = @"App-Prefs:root=Reset";
        }
            break;
        case MSUWallpaper:
        {   //墙纸
            str = @"App-Prefs:root=Wallpaper";
        }
            break;
        case MSUPrivacy:
        {   //隐私
            str = @"App-Prefs:root=Privacy";
        }
            break;
        case MSUSafari:
        {   //Safari
            str = @"App-Prefs:root=SAFARI";
        }
            break;
        case MSUMusic:
        {   //音乐
            str = @"App-Prefs:root=MUSIC";
        }
            break;
        case MSUEqualizer:
        {   //音乐-均衡器
            str = @"App-Prefs:root=MUSIC&path=com.apple.Music:EQ";
        }
            break;
        case MSUPhotos:
        {   //照片与相机
            str = @"App-Prefs:root=Photos";
        }
            break;
        case MSUFaceTime:
        {   //FaceTime
            str = @"App-Prefs:root=FACETIME";
        }
            break;
        case MSUAppAbout:
        {   //FaceTime
            str = UIApplicationOpenSettingsURLString;
        }
            break;
        default:
            break;
    }
    
    NSURL *url = [NSURL URLWithString:str];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (iOS10) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
