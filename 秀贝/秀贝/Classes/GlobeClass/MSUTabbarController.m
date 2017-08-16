//
//  MSUTabbarController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUTabbarController.h"
#import "MSUHomePageController.h"
#import "MSUVideoController.h"
#import "MSUShopStoreController.h"
#import "MSUPersonCenterController.h"
#import "MSUNaviBaseController.h"
#import "MSUCameraPhotoVc.h"


/* 工具类 */
#import "MSUPermissionTool.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MSUTabbarController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITabBarControllerDelegate>

@end

@implementation MSUTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // tabbar创建方法
    [self createSystemTabbar];
}

#pragma mark - 旋转相关 （tabbar控制器下的子控制器需要旋转需要重写此方法，且需要旋转哪个控制器就传入哪个）
- (BOOL)shouldAutorotate
{
    //在viewControllers中返回需要改变的NavigationController
    return [self.viewControllers[3] shouldAutorotate];
}


+ (void)load
{
    // 获取当前类的tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 更改tabbar 选中字体颜色
    UITabBar *tabbar = [UITabBar appearanceWhenContainedIn:self, nil];
    tabbar.tintColor = HEXCOLOR(0xf7d721);
    tabbar.backgroundColor = [UIColor whiteColor];
    
    // 设置所有item的选中时颜色
    // 设置选中文字颜色
    // 创建字典去描述文本
    NSMutableDictionary *attSelect = [NSMutableDictionary dictionary];
    // 文本颜色 -> 描述富文本属性的key -> NSAttributedString.h
    attSelect[NSForegroundColorAttributeName] = HEXCOLOR(0xf7d721);
    [item setTitleTextAttributes:attSelect forState:UIControlStateSelected];
    
    // 通过normal状态设置字体大小
    // 字体大小 跟 normal
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    // 设置字体
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
    
    // 文字偏移量
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    // icon偏移量
//    [item setImageInsets:UIEdgeInsetsMake(-2.5, 0, 2.5, 0)];
}

#pragma mark - tabbar 子控制器们
//自封装方法
-(UINavigationController*)createNavWithViewController:(UIViewController *)viewController WithTitle:(NSString*) title image:(UIImage*)image selectedImage:(UIImage *)selectedImage badgeValue:(NSString *)value
{
    MSUNaviBaseController *nav = [[MSUNaviBaseController alloc] initWithRootViewController:viewController];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    nav.navigationBar.hidden = YES;
    nav.tabBarItem.badgeValue = value;
    return nav;
}

//创建系统tabbar
- (void)createSystemTabbar{
    MSUHomePageController *home = [[MSUHomePageController alloc] init];
    MSUVideoController *video = [[MSUVideoController alloc] init];
    UIViewController *vc = [[UIViewController alloc] init];
    MSUShopStoreController *shop = [[MSUShopStoreController alloc] init];
    MSUPersonCenterController *center = [[MSUPersonCenterController alloc] init];
    
    // 图片数组
    NSArray *imageArr = @[@"home-tab-showbuy",@"home-tab-dynamic",@"home-tab-message",@"home-tab-account"];
    NSArray *selectImaArr = @[@"home-tab-showbuychoose",@"home-tab-dynamicchoose",@"home-tab-messagechoose",@"home-tab-accountchoose"];
    
    //数组设置
    self.viewControllers = [NSArray arrayWithObjects:
                            [self createNavWithViewController:home WithTitle:@"秀贝" image:[UIImage imageNamed:imageArr[0]] selectedImage:[UIImage imageNamed:selectImaArr[0]] badgeValue:@"18"],
                            [self createNavWithViewController:shop WithTitle:@"动态" image:[UIImage imageNamed:imageArr[1]] selectedImage:[UIImage imageNamed:selectImaArr[1]] badgeValue:nil],
                            [self createNavWithViewController:vc WithTitle:nil image:nil selectedImage:nil badgeValue:nil],
                            [self createNavWithViewController:video WithTitle:@"消息" image:[UIImage imageNamed:imageArr[2]] selectedImage:[UIImage imageNamed:selectImaArr[2]] badgeValue:nil],
                           [self createNavWithViewController:center WithTitle:@"我的" image:[UIImage imageNamed:imageArr[3]] selectedImage:[UIImage imageNamed:selectImaArr[3]] badgeValue:nil],
                            nil];
    
    
    //中间突出按钮设置
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0.0,0.0,49,49)];
    button.center = CGPointMake(WIDTH/2,15);
    button.layer.shadowColor = HEXCOLOR(0xf7d721).CGColor;
    button.layer.shadowOffset = CGSizeMake(1, 1);
    button.layer.shadowOpacity = 0.4;
    button.layer.shadowRadius = 3;
    [button setBackgroundImage:[UIImage imageNamed:@"xiang"] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:self action:@selector(pickClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:button];
}

#pragma mark - 中间突出按钮点击事件
//点击事件
- (void)pickClick{
//    [MSUCameraPhotoVc takePictureAndCameraWithObject:self];
    [self takePictureAndCamera];
}

#pragma mark - 摄像和照相功能
/* 拍照和录视频 */
- (void)takePictureAndCamera{
    [MSUPermissionTool getCamerasPermission:^(NSInteger authStatus) {
        if (authStatus == 1) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.delegate = self;
//                picker.allowsEditing = YES;/** 设置拍照后的图片可被编辑 */
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //录制视频时长，默认10s
                    picker.videoMaximumDuration = 10;
                    //相机类型（拍照、录像...）字符串需要做相应的类型转换
                    picker.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
                    picker.videoQuality = UIImagePickerControllerQualityTypeIFrame960x540;
                    //设置摄像头模式（拍照，录制视频）为录像模式
                    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
                    //                    picker.showsCameraControls = NO;
                    //                    UIView *overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
                    //                    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    testBtn.frame = CGRectMake(50, 50, 50, 50);
                    //                    testBtn.backgroundColor = [UIColor blueColor];
                    //                    [overView addSubview:testBtn];
                    //                    [testBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                    //                   picker.camer/aOverlayView = overView; // 自定义控件view
                });
                
                // 判断与设备方向
                UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
                if (UIDeviceOrientationIsLandscape(deviceOrientation))
                    NSLog(@"横屏横屏横屏横屏横屏横屏");
                else if(UIDeviceOrientationIsPortrait(deviceOrientation))
                    NSLog(@"竖屏竖屏竖屏竖屏竖屏竖屏");
                
                [self presentViewController:picker animated:YES completion:^{
                    [UIApplication sharedApplication].statusBarHidden = YES;;
                }];
            }else{
                NSLog(@"模拟机无法打开照相机,请在真机使用");
            }
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 秀贝] 打开访问开关" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //确定按钮点击事件处理
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

#pragma mark UIImagePickerControllerDelegate
//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        UIImage *pickedImage = nil;
        if ([picker allowsEditing]) {
            pickedImage = info[UIImagePickerControllerEditedImage];
        }else{
            pickedImage = info[UIImagePickerControllerOriginalImage];
        }
        
        NSLog(@"图片是%@",pickedImage);
        //        self.imageView.image = info[UIImagePickerControllerEditedImage];
        //        //压缩图片
        //        NSData *fileData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
        //        //保存图片至相册
        UIImageWriteToSavedPhotosAlbum(pickedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //        //上传图片
        //        [self uploadImageWithData:fileData];
        
    }else{
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        CGSize videoSize = [MSUCameraPhotoVc getVideoSizeWithURL:url];
        NSLog(@"视频链接是%@",url);
        NSLog(@"宽 ：%f , 高 ： %f",videoSize.width,videoSize.height);
        //        //播放视频
        //        _moviePlayer.contentURL = url;
        //        [_moviePlayer play];
        //        //保存视频至相册（异步线程）
        //        NSString *urlStr = [url path];
        //
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
        //
        //                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        //            }
        //        });
        //        NSData *videoData = [NSData dataWithContentsOfURL:url];
        //        //视频上传
        //        [self uploadVideoWithData:videoData];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 取消按钮回调 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/* 图片保存完毕的回调 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存照片过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"照片保存成功.");
    }
}

/* 视频保存完毕的回调 */
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}

@end
