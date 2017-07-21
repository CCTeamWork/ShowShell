//
//  TestTools.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/18.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TestTools : NSObject

/* 压缩视频 */
+ (void)cutDownVideoWithURL:(NSURL *)url;

/* 取视频中的任意一帧图片  */
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

@end
