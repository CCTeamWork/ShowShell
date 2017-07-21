//
//  MSUCameraPhotoVc.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUCameraPhotoVc.h"

/* 工具类 */
#import "MSUPermissionTool.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface MSUCameraPhotoVc ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MSUCameraPhotoVc

#pragma mark - 拍照和录视频 
/* 拍照和录视频 */
+ (void)takePictureAndCameraWithObject:(id)obj{
    [MSUPermissionTool getCamerasPermission:^(NSInteger authStatus) {
        if (authStatus == 1) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.delegate = obj;
                //                picker.allowsEditing = YES;/** 设置拍照后的图片可被编辑 */
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //录制视频时长，默认10s
                    picker.videoMaximumDuration = 10;
                    //相机类型（拍照、录像...）字符串需要做相应的类型转换
                    picker.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
                    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
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
                
                [obj presentViewController:picker animated:YES completion:^{
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
            [obj presentViewController:alert animated:YES completion:nil];
        }
    }];
}

#pragma mark - 相册选择图片
/* 相册选择图片 */
+ (void)pickedPhontoWithObject:(id)obj{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        [MSUPermissionTool getPhotosPermission:^(NSInteger authStatus) {
            if (authStatus == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                    // 相册中视频也可显示和选择
//                    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
                    imagePicker.delegate = obj;
//                    imagePicker.allowsEditing = YES;
                    [obj presentViewController:imagePicker animated:YES completion:^{
                        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                    }];
                });
                
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 照片 - 秀贝] 打开访问开关" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //确定按钮点击事件处理
                }]];
                [obj presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    
    //内存相关
    /*
     dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
     // 栅栏函数
     dispatch_barrier_async(queue, ^{
     [self removeScanningView];
     });
     */
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
//        CGSize videoSize = [MSUCameraPhotoVc getVideoSizeWithURL:url];
        NSLog(@"视频链接是%@",url);
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

#pragma mark - 获取视频宽和高
/* 获取视频宽和高 */
+ (CGSize)getVideoSizeWithURL:(NSURL *)url{
    AVAsset *asset = [AVAsset assetWithURL:url];
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    AVAssetTrack *videoTrack;
    if([tracks count] > 0) {
        videoTrack = [tracks objectAtIndex:0];
//        CGAffineTransform t = videoTrack.preferredTransform;//这里的矩阵有旋转角度，转换一下即可
//        NSLog(@"=====hello  width:%f===height:%f",videoTrack.naturalSize.width,videoTrack.naturalSize.height);//宽高
    }
        return videoTrack.naturalSize;
}



@end
