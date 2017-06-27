//
//  MSUImageTools.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 系统版本
#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

typedef NS_ENUM(NSInteger , MSUUrlType){
    MSUWIFI = 0,            //无线局域网
    MSUSIRI,                //Siri
    MSUBluetooth,           //蓝牙
    MSUCellularMobile,      //蜂窝移动网络
    MSUPersonalHotspot,     //个人热点
    MSUCarrier,             //运营商
    MSUNotification,        //通知
    MSUGeneral,             //通用
    MSUAbout,               //通用-关于本机
    MSUKeyboard,            //通用-键盘
    MSUSupport,             //通用-辅助功能
    MSULanguage,            //通用-语言与地区
    MSUReset,               //通用-还原
    MSUWallpaper,           //墙纸
    MSUPrivacy,             //隐私
    MSUSafari,              //Safari
    MSUMusic,               //音乐
    MSUEqualizer,           //音乐-均衡器
    MSUPhotos,              //照片与相机
    MSUFaceTime,            //FaceTime
    MSUAppAbout             //APP本身相关
};

@interface MSUPathTools : NSObject

/* NSBundle版 获取路径加载图片 */
+ (UIImage *)showImageWithContentOfFileByName:(NSString *)imageName;

/* Plist 获取路径 并获取 数据字典*/
+ (NSMutableDictionary *)getPlistPathWithName:(NSString *)name type:(NSString *)type;

/* Documents 文件路径 */
+ (NSString *)getDocumentsPathWithFileName:(NSString *)name;

/* 获取跳转设置相关路径权限 */
+ (void)skipToSettingPathWithUrl:(MSUUrlType)type;


@end
