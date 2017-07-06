//
//  MSUPlayerController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPlayerController.h"
#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"
#import "AppDelegate.h"

/// 视频播放器
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface MSUPlayerController ()<AVPlayerViewControllerDelegate>

@property (nonatomic , strong) AVPlayerViewController *avPlayerVC;
@property (nonatomic , strong) AVPlayer *player;
@property (nonatomic , strong) AVPlayerItem *playerItem;

@end

@implementation MSUPlayerController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    /// 状态栏字体颜色
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = NavColor;
    
    /// 导航栏
    [self createNavView];
    
    /// 播放器
     [self playByAVPlayer];
//    [self playByAVPlayerController];
    
//    /// 横竖屏相关
//    AppDelegate *app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
//    app.allowRotation = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // 鉴于上一个控制器不需要旋转，所以此旋转视图即将消失时候，将导航栏恢复竖屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
}

- (void)dealloc{
    NSLog(@" dealloc");
    // AVPlayer控制器版
    [_avPlayerVC.player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    [_avPlayerVC.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    
    // AVPlayer版
    [_playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
}

#pragma mark - 视图
- (void)createNavView{
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:5];
    [self.view addSubview:nav];
}

#pragma mark - AVPlayer 播放
- (void)playByAVPlayer{
    // 加载本地音乐
//    NSURL *localMusicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"蓝莲花" ofType:@"mp3"]];
    
    // 加载本地视频
    NSURL *localVideoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"经济技术" ofType:@"mp4"]];
    
    // 加载网络视频
//    NSURL *netVideoUrl = [NSURL URLWithString:@"http://w2.dwstatic.com/1/5/1525/127352-100-1434554639.mp4"];
    
    // AVPlayerIterm
    self.playerItem = [AVPlayerItem playerItemWithURL:localVideoUrl];
    
    // 创建 AVPlayer 播放器
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    // 将 AVPlayer 添加到 AVPlayerLayer 上
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];

    // 设置播放页面大小
    playerLayer.frame = CGRectMake(10, 64 + 10, WIDTH - 20, 200);
    
    // 设置画面缩放模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    // 在视图上添加播放器
    [self.view.layer addSublayer:playerLayer];
    
    // 开始播放
    [_player play];
    
    [self AVPlayerParameterWithAVPlayer:_player AVPlayerItem:_playerItem];
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(10, 64+10, WIDTH-20, 200)];
    navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navView];
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.backgroundColor = SLIVERYCOLOR;
    testBtn.frame = CGRectMake(0, 170, 50, 30);
    [navView addSubview:testBtn];
    [testBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    if (sender.selected) {
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)deviceOrientationDidChange
{
    NSLog(@"NAV deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
        [self orientationChange:NO];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
        [self orientationChange:YES];
    }
}

- (void)orientationChange:(BOOL)landscapeRight
{
    if (landscapeRight) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.view.bounds = CGRectMake(0, 0, WIDTH, HEIGHT);
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(0);
            self.view.bounds = CGRectMake(0, 0, WIDTH, HEIGHT);
        }];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}



/* 视频播放相关参数 */
- (void)AVPlayerParameterWithAVPlayer:(AVPlayer *)avPlayer AVPlayerItem:(AVPlayerItem *)avPlayerItem{
    // 设置播放速率 （默认为 1.0 (normal speed)，设为 0.0 时暂停播放。设置后立即开始播放，可放在开始播放后设置）
    avPlayer.rate = 1.0;
    
    // 开始播放
    [avPlayer play];
    
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
    
    // 监听缓冲进度属性
    [avPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听准备播放状态属性
    // AVPlayerItemStatus status = avPlayerItem.status;                         //获取播放属性
    [avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark - AVPlayerController 播放
- (void)playByAVPlayerController{
    // 加载本地音乐
//    NSURL *localMusicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"蓝莲花" ofType:@"mp3"]];
    
    // 加载本地视频
    NSURL *localVideoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"经济技术" ofType:@"mp4"]];
    
    // 加载网络视频
//    NSURL *netVideoUrl = [NSURL URLWithString:@"http://w2.dwstatic.com/1/5/1525/127352-100-1434554639.mp4"];
    
    // 创建播放控制器
    self.avPlayerVC = [[AVPlayerViewController alloc] init];
    
    _avPlayerVC.player = [AVPlayer playerWithURL:localVideoUrl];
    
    // 设置画面缩放模式
//    _avPlayerVC.videoGravity = AVLayerVideoGravityResizeAspectFill;


    [_avPlayerVC.view setTranslatesAutoresizingMaskIntoConstraints:YES];
    // 设置媒体播放器视图大小
//    _avPlayerVC.view.bounds = CGRectMake(0, 0, WIDTH, 300);
//    _avPlayerVC.view.center = CGPointMake(CGRectGetMidX(self.view.bounds), 64 + CGRectGetMidY(_avPlayerVC.view.bounds));
    // 直接在本视图控制器播放
    [self addChildViewController:_avPlayerVC];
    [self.view addSubview:_avPlayerVC.view];
//    // 设置拉伸模式
//    _avPlayerVC.videoGravity = AVLayerVideoGravityResizeAspect;
//     _avPlayerVC.delegate = self;
    
    // 弹出播放页面，需要点击播放按钮开始播放
//    [self presentViewController:_avPlayerVC animated:YES completion:nil];
    _avPlayerVC.view.frame = CGRectMake(0, 64, WIDTH, 200);
    
    [self AVPlayerVCParameterWithAVPlayerVC:_avPlayerVC];
    
}

- (void)AVPlayerVCParameterWithAVPlayerVC:(AVPlayerViewController *)avPlayerVC{    
    // 获取视频总长度 （转换成秒，或用 duration.value / duration.timescale; 计算）
    // CMTime duration = avPlayerVC.player.currentItem.duration;
    // float totalSecond = CMTimeGetSeconds(duration);
    
    // 跳转到指定位置 （10 / 1 = 10，跳转到第 10 秒的位置处）
     [avPlayerVC.player.currentItem seekToTime:CMTimeMake(1, 1)];
    
    // 设置播放速率（默认为 1.0 (normal speed)，设为 0.0 时暂停播放。设置后立即开始播放，可放在开始播放后设置）
    avPlayerVC.player.rate = 1.0;
    
    // 开始播放
//    [avPlayerVC.player play];
    
    // 暂停播放
    // [avPlayerVC.player pause];
    
    // 设置音量 （范围 0 - 1，默认为 1）
    avPlayerVC.player.volume = 0;

    // 获取播放控件所在的视图 （播放控件与播放内容界面之间的叠加视图）
    // UIView *contentOverlayView = avPlayerVC.contentOverlayView;
    
    // 设置是否显示播放控件 （Default is YES）
    avPlayerVC.showsPlaybackControls = YES;
    
    // 设置是否允许画中画播放 （Default is YES）
    avPlayerVC.allowsPictureInPicturePlayback = YES;
    // 这两行必须设置，不然画中画不能用，如果不写模拟器中可以画中画，但是在设备中不能
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 判断是否准备好显示
    // BOOL readyForDisplay = avPlayerVC.isReadyForDisplay;
    
    // 设置画中画播放代理，需遵守协议 <AVPlayerViewControllerDelegate>
    // avPlayerVC.delegate = self;
    
    // 监听准备播放状态属性
    // AVPlayerItemStatus status = avPlayerVC.player.currentItem.status;
     [avPlayerVC.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    // 获取视频缓冲进度
    NSArray<NSValue *> *loadedTimeRanges = avPlayerVC.player.currentItem.loadedTimeRanges;
    
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];  // 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    
    float loadedSecond = startSeconds + durationSeconds;                      // 计算缓冲总进度
    
    // 监听缓冲进度属性
     [avPlayerVC.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
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
}


@end
