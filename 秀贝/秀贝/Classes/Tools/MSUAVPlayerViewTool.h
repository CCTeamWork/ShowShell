//
//  MSUAVPlayerViewTool.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 视频播放器
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "TestTools.h"

@interface MSUAVPlayerViewTool : UIView

@property (nonatomic , strong) AVPlayerViewController *avPlayerVC;
@property (nonatomic , strong) AVPlayer *player;
@property (nonatomic , strong) AVPlayerItem *playerItem;
@property (nonatomic , strong) AVPlayerLayer *playerLayer;
@property (nonatomic , strong) NSURL *localUrl;

@end
