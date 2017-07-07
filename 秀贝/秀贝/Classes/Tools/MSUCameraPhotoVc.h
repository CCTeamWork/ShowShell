//
//  MSUCameraPhotoVc.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUCameraPhotoVc : UIViewController

/* 拍照和录视频 */
+ (void)takePictureAndCameraWithObject:(id)obj;

/* 相册选择图片 */
+ (void)pickedPhontoWithObject:(id)obj;

@end
