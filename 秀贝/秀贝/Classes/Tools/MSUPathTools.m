//
//  MSUImageTools.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPathTools.h"

@implementation MSUPathTools

#pragma mark - 图片缓存相关
/* NSBundle版加载图片 */
+ (UIImage *)showImageWithContentOfFileByName:(NSString *)imageName {
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],imageName ];
    return [UIImage imageWithContentsOfFile:path];
}

#pragma mark - 获取 Plist 文件路径和数据
/* Plist 获取路径 并获取 数据字典*/
+ (NSMutableDictionary *)getPlistPathWithName:(NSString *)name type:(NSString *)type{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return dataDict;
}

#pragma mark - 获取 Documents 文件路径
/* Documents 文件路径 */
+ (NSString *)getDocumentsPathWithFileType:(MSUDocumentsType)type fileName:(NSString *)name{
    // 获取根目录
//    NSString *home = NSHomeDirectory();
    // 查找Documents文件
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接文件路径
    NSString *path;
    switch (type) {
        case MSUString:
        {
            path = [doc stringByAppendingString:name];
        }
            break;
        case MSUComponent:
        {
            path = [doc stringByAppendingPathComponent:name];
        }
            break;
            
        default:
            break;
    }
    
    // 调用writeToFile将数据写入文件
    //NSArray *arr = @[@"lnj", @"28"];
    //[arr writeToFile:path atomically:YES];

    // NSDictionary *dict = @{@"name": @"lnj", @"age":@"28"};
    // [dict writeToFile:path atomically:YES];
    
    // 读取数据
    // NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];

    return path;
}

#pragma mark - 截屏 并保存
- (void)getScreenShotWithLayer:(UIView *)view saveToFile:(MSUFileType)type{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIGraphicsBeginImageContext(view.frame.size);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
        switch (type) {
            case MSUAlbum:
            {
                UIImageWriteToSavedPhotosAlbum(shotImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
                break;
            case MSUDocuments:
            {
                NSString *path = [MSUPathTools getDocumentsPathWithFileType:MSUComponent fileName:@"abc.png"];
                NSData *data = UIImagePNGRepresentation(shotImage);
                [data writeToFile:path atomically:YES];
            }
                break;

            default:
                break;
        }
    });
}

/// 方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败 %@",error);
    }
}

#pragma mark - App内缓存相关
/* App缓存大小 cache */
+ (CGFloat)cacheSizeInApp{
    CGFloat cacheSize = 0.0;
    
    // 获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    // 获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    NSLog(@"缓存文件数：%ld",files.count);
    // 遍历缓存文件
    for (NSString *path in files) {
        NSString *filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        cacheSize += [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    // 转换为M为单位
    CGFloat sizeM = cacheSize /1024.0 /1024.0;
    
    return sizeM;
}

/* 清除 App缓存 cache */
+ (void)cleanCacheSizeInAppWithComplement:(complementBlock)block{
    // 获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    // 获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    //删除 sd 图片缓存
    //先清除内存中的图片缓存
//    [[SDImageCache sharedImageCache] clearMemory];
    //清除磁盘的缓存
//    [[SDImageCache sharedImageCache] clearDisk];
    
    // 遍历缓存文件
    for (NSString *path in files) {
        NSError *error;
        // 缓存文件中的具体文件的路径
        NSString *filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            BOOL isRemove = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if (isRemove) {
                // 清除成功
                block(@"清除成功",200);
            }else{
                // 清除失败
                block(@"清除失败",404);
            }
        }
    }
}

#pragma mark - 获取设置 url 路径，跳转到设置相关选项中去
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

#pragma mark - 获取四大文件路径URL
+ (NSURL *)getDocumentURLWithPath:(NSString *)path{
     NSFileManager *manager = [NSFileManager defaultManager];
     NSURL *docuUrl = [[manager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
     NSURL *pathUrl = [docuUrl URLByAppendingPathComponent:path];
//     NSURL *path = [url URLByAppendingPathComponent:@"MyDocument"];
    return pathUrl;
}

#pragma mark - 画四周阴影
+ (UIBezierPath *)drawShadowAroundControls{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    return path;
}

@end
