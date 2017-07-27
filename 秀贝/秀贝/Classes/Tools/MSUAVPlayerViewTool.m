//
//  MSUAVPlayerViewTool.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUAVPlayerViewTool.h"

@interface MSUAVPlayerViewTool()<AVPlayerViewControllerDelegate>

@end

@implementation MSUAVPlayerViewTool

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self playByAVPlayerWithFrame:frame];
        
    }
    return self;
}


- (void)playByAVPlayerWithFrame:(CGRect)frame{
    // 加载本地音乐
    //    NSURL *localMusicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"蓝莲花" ofType:@"mp3"]];
    
    // 加载本地视频
    //    NSURL *localVideoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_1234" ofType:@"MOV"]];
    //    NSURL *localVideoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"经济技术" ofType:@"mp4"]];
    //    NSURL *localVideoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_1233" ofType:@"MOV"]];
    NSURL *localVideoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"haha" ofType:@"mp4"]];
    
    
    // 加载网络视频
    //    NSURL *netVideoUrl = [NSURL URLWithString:@"http://w2.dwstatic.com/1/5/1525/127352-100-1434554639.mp4"];
    
    
    // AVPlayerIterm
    self.playerItem = [AVPlayerItem playerItemWithURL:localVideoUrl];
    
    // 创建 AVPlayer 播放器
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    
    // 将 AVPlayer 添加到 AVPlayerLayer 上
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    // 设置播放页面大小
    _playerLayer.frame = frame;
    NSLog(@"视频层 %@",NSStringFromCGRect(_playerLayer.frame));
    // 设置画面缩放模式
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //        playerLayer.videoRect = CGRectMake(10, 64, WIDTH - 20, 400);
    
    // 在视图上添加播放器
    [self.layer addSublayer:_playerLayer];
    
    // 开始播放
    [_player pause];
    
    //获取总帧数与帧率
    //    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    //    AVURLAsset *myAsset = [[AVURLAsset alloc] initWithURL:localVideoUrl options:opts];
    //    CMTimeValue  value = myAsset.duration.value;//总帧数
    //    CMTimeScale  timeScale =   myAsset.duration.timescale; //timescale为帧率  fps
    //    NSLog(@"-------%lld,%d",value,timeScale);
    [self AVPlayerParameterWithAVPlayer:_player AVPlayerItem:_playerItem];
    
    //    UIImageView *wolfIma = [[UIImageView alloc] init];
    //    wolfIma.frame = CGRectMake(0, HEIGHT/2, WIDTH, 200);
    //    wolfIma.image = [TestTools thumbnailImageForVideo:localVideoUrl atTime:1000];
    //    [self.view addSubview:wolfIma];
    
    
    
}

/* 视频播放相关参数 */
- (void)AVPlayerParameterWithAVPlayer:(AVPlayer *)avPlayer AVPlayerItem:(AVPlayerItem *)avPlayerItem{
    // 设置播放速率 （默认为 1.0 (normal speed)，设为 0.0 时暂停播放。设置后立即开始播放，可放在开始播放后设置）
    avPlayer.rate = 1.0;
    
    // 开始播放
    //    [avPlayer play];
    
    // 暂停播放
    // [avPlayer pause];
    
    // 设置音量 （范围 0 - 1，默认为 1）
    // avPlayer.volume = 0;
    
    // 跳转到指定位置 （10 / 1 = 10，跳转到第 10 秒的位置处）
    // [avPlayerItem seekToTime:CMTimeMake(10, 1)];
    
    // 获取视频总长度 （转换成秒，或用 duration.value / duration.timescale; 计算）
    // CMTime duration = avPlayerItem.duration;
    // float totalSecond = CMTimeGetSeconds(duration);
    
    // 获取当前播放进度 （或用 avPlayerItem.currentTime.value/avPlayerItem.currentTime.timescale;）
    // CMTime currentTime = avPlayerItem.currentTime;
    // float currentSecond = CMTimeGetSeconds(currentTime);
    
    // 监听播放进度 （NULL 在主线程中执行，每个一秒执行一次该 Block）
    [avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        
    }];
    
    // 添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemDidPlayToEndTime:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:avPlayerItem];
    
    // 获取视频缓冲进度
    NSArray<NSValue *> *loadedTimeRanges = avPlayerItem.loadedTimeRanges;
    
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];  // 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    
    float loadedSecond = startSeconds + durationSeconds;                      // 计算缓冲总进度
    NSLog(@"%f",loadedSecond);
    
    // 监听缓冲进度属性
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听准备播放状态属性
    // AVPlayerItemStatus status = avPlayerItem.status;                         //获取播放属性
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
}

/* 释放播放器相关 */
- (void)releasePlayer{
    
    [_playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    
    [_playerItem cancelPendingSeeks];
    [_playerItem.asset cancelLoading];
    
    [self.playerLayer removeFromSuperlayer];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.player = nil;
    self.playerItem = nil;
}

#pragma mark - 系统通知
- (void)notifacation{
    
}

/* 系统自带监听方法 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    /// 监听缓冲进度
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    }
    
    /// 监听播放状态
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        switch (status) {
            case AVPlayerItemStatusUnknown: {
                NSLog(@"未知状态");
                break;
            }
            case AVPlayerItemStatusReadyToPlay: {
                //                NSLog(@"视频的总时长%f", CMTimeGetSeconds(player.currentItem.duration));
                
                break;
            }
            case AVPlayerItemStatusFailed: {
                NSLog(@"加载失败");
                break;
            }
        }
    }
    
}

- (void)itemDidPlayToEndTime:(NSNotification *)noti{
    NSLog(@"播放结束");
    //    [player seekToTime:kCMTimeZero];
    [self releasePlayer];
}



@end
