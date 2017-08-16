//
//  MSUNearbyController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/25.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUNearbyController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUNearbyCell.h"
#import "MSUNearbyHeaderView.h"
#import "MSUMapShowController.h"
#import "MSUPullView.h"
#import "MSUNearbyPopView.h"

/// 工具类
#import "MSUStringTools.h"

/// 视频播放器
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "TestTools.h"

@interface MSUNearbyController ()<UITableViewDelegate,UITableViewDataSource,AVPlayerViewControllerDelegate,UIScrollViewDelegate,UIScrollViewDelegate>

/// 列表
@property (nonatomic , strong) UITableView *tableView;

/// 弹出框
@property (nonatomic , strong) MSUNearbyPopView *popView;

// cell高
@property (nonatomic , assign) NSInteger cellHeight;

// 弹出视图
@property (nonatomic , strong) MSUNearbyCell *current1Cell;
@property (nonatomic , strong) MSUPullView *pullView;

// 播放视频相关
@property (nonatomic , strong) UIView *playerView;
@property (nonatomic,strong) NSIndexPath *currentIndexPath;
@property (nonatomic , strong) MSUNearbyCell *currentCell;
@property (nonatomic , strong) AVPlayerViewController *avPlayerVC;
@property (nonatomic , strong) AVPlayer *player;
@property (nonatomic , strong) AVPlayerItem *playerItem;
@property (nonatomic , strong) AVPlayerLayer *playerLayer;
@property (nonatomic , strong) NSURL *localUrl;

@end

@implementation MSUNearbyController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BlackColor;
    
    // 导航视图
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:7];
    [self.view addSubview:nav];
    [nav.backArrowBtn addTarget:self action:@selector(backArrowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [nav.positionBtn addTarget:self action:@selector(positionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 列表视图
    [self createTableView];
}

- (void)dealloc{
    NSLog(@" dealloc");
    // AVPlayer版
    [self releasePlayer];
}

#pragma mark - 点击事件相关
/* 返回按钮点击事件 */
- (void)backArrowBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pullBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    _pullView.hidden = !sender.selected;
    self.current1Cell = (MSUNearbyCell *)sender.superview.superview;
    [self.current1Cell addSubview:self.pullView];
    
}

/* 筛选按钮 */
- (void)positionBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.popView.hidden = !sender.selected;
}

/* nearbyPositionBtnClick  地图按钮  点击事件 */
- (void)nearbyPositionBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUMapShowController *map = [[MSUMapShowController alloc] init];
    [self.navigationController pushViewController:map animated:YES];

}


/* 视频按钮播放按钮 点击事件 */
- (void)playBtnClick:(UIButton *)sender{
    NSLog(@"点击了第%ld个按钮",sender.tag);
    self.currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];

    self.currentCell = (MSUNearbyCell *)sender.superview.superview;
    // 当有上一个在播放的时候 点击 就先release
    if (self.playerView) {
        [self releasePlayer];
        
        self.playerView = [[UIView alloc] initWithFrame:self.currentCell.videoImaView.bounds];
        //        NSLog(@"cell frame ： %@ ，videoBGView frame %@,frame ：%@",NSStringFromCGRect(self.currentCell.frame),NSStringFromCGRect(self.currentCell.videoImaView.frame),NSStringFromCGRect(self.playerView.frame));
    }else{
        self.playerView = [[UIView alloc] initWithFrame:self.currentCell.videoImaView.bounds];
        //        NSLog(@"cell frame ： %@ ，videoBGView frame %@,frame ：%@",NSStringFromCGRect(self.currentCell.frame),NSStringFromCGRect(self.currentCell.videoImaView.frame),NSStringFromCGRect(self.playerView.frame));
    }
    
    self.currentCell.playBtn.hidden = YES;
    [self.currentCell.videoImaView addSubview:_playerView];
    [self.currentCell.videoImaView bringSubviewToFront:_playerView];
    [self playByAVPlayer];
    NSLog(@"view2 : %@",self.playerView.superview.superview.superview);
    
}

/* 释放播放器相关 */
- (void)releasePlayer{
    NSLog(@"view1 : %@",self.playerView.superview.superview.superview);
    
    MSUNearbyCell *cell = (MSUNearbyCell *)self.playerView.superview.superview.superview;
    cell.playBtn.hidden = NO;
    
    [_playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    
    [_playerItem cancelPendingSeeks];
    [_playerItem.asset cancelLoading];
    
    [self.playerView removeFromSuperview];
    [self.playerLayer removeFromSuperlayer];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.player = nil;
    self.playerItem = nil;
}


#pragma mark - 中部视图
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60) style:UITableViewStylePlain];
    _tableView.backgroundColor = HEXCOLOR(0xf4f4f4);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MSUNearbyHeaderView *header = [[MSUNearbyHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 55)];
    header.backgroundColor = HEXCOLOR(0xf4f4f4);
    _tableView.tableHeaderView = header;
    header.positionLab.text = @"杭州市 西湖文化广场";
    [header.positionBtn addTarget:self action:@selector(nearbyPositionBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 代理相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"danamicTable";
    MSUNearbyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MSUNearbyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 头像
    [cell.iconBtn setImage:[UIImage imageNamed:@"icon-z"] forState:UIControlStateNormal];
    // 昵称
    cell.nickLab.text = @"叶叶叶叶叶子";
    // 时间
    cell.timeLab.text = @"2017-07-11 19:30";
    // 是否转发
    cell.isTranspod = NO;
    
    if (cell.isTranspod) {
        // 转发评论
        cell.transpodLab.text = @"转发视频";
        CGRect transRect = [MSUStringTools danamicGetHeightFromText:cell.transpodLab.text WithWidth:WIDTH-10 font:12];
        cell.transpodLab.frame = CGRectMake(14, 59, WIDTH-28, transRect.size.height);
        // 内容正题
        cell.tittleLab.text = @"有一美人兮，见之不忘。一日不见兮，思之如狂。凤飞翱翔兮，四海求凰。无奈佳人兮，不在东墙。将琴代语兮，聊写衷肠。何日见许兮，慰我彷徨。愿言配德兮，携手相将。不得于飞兮，使我沦亡。";
        CGRect textRect = [MSUStringTools danamicGetHeightFromText:cell.tittleLab.text WithWidth:WIDTH-10 font:12];
        cell.tittleBGView.frame = CGRectMake(0, 59 + transRect.size.height + 5, WIDTH, textRect.size.height+10);
        cell.tittleLab.frame = CGRectMake(14, 10, WIDTH-28, textRect.size.height);
        cell.videoBGView.frame = CGRectMake(0, CGRectGetMaxY(cell.tittleBGView.frame), WIDTH, 191.5);
        
        cell.tittleBGView.backgroundColor = HEXCOLOR(0xf2f2f2);
        cell.videoBGView.backgroundColor = HEXCOLOR(0xf2f2f2);;
        
    }else{
        // 内容正题
        cell.tittleLab.text = @"有一美人兮，见之不忘。一日不见兮，思之如狂。凤飞翱翔兮，四海求凰。无奈佳人兮，不在东墙。将琴代语兮，聊写衷肠。何日见许兮，慰我彷徨。愿言配德兮，携手相将。不得于飞兮，使我沦亡。";
        CGRect textRect = [MSUStringTools danamicGetHeightFromText:cell.tittleLab.text WithWidth:WIDTH-10 font:12];
        cell.tittleBGView.frame = CGRectMake(0, 59 , WIDTH, textRect.size.height);
        cell.tittleLab.frame = CGRectMake(14, 0, WIDTH-28, textRect.size.height);
        cell.videoBGView.frame = CGRectMake(0, CGRectGetMaxY(cell.tittleBGView.frame), WIDTH, 181.5);
    }
    
    // 视频页面
    cell.videoImaView.image = [UIImage imageNamed:@"FoSe.jpeg"];
    // 播放按钮
    [cell.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.playBtn.tag = indexPath.row;
    
    // 是否定位
    cell.isLocation = YES;
    if (cell.isLocation) {
        cell.lineView.frame = CGRectMake(0, CGRectGetMaxY(cell.videoBGView.frame) + 5+ 20+ 5 , WIDTH, 1);
    }else{
        cell.locationBtn.hidden = YES;
        cell.dictanceBtn.hidden = YES;
        cell.lineView.frame = CGRectMake(0, CGRectGetMaxY(cell.videoBGView.frame) + 5 , WIDTH, 1);
    }
    
    self.cellHeight = CGRectGetMaxY(cell.lineView.frame) + 40 + 20;
    [cell.pullBtn addTarget:self action:@selector(pullBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

/* scrollview delegate */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        if (!self.playerView) {
            return;
        }
        
        if (self.playerView.superview) {
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:self.currentIndexPath];
            CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
            if (rectInSuperview.origin.y < -self.currentCell.videoImaView.frame.size.height || rectInSuperview.origin.y > HEIGHT - 64 -49) {
                NSLog(@"滚动距离 %f",rectInSuperview.origin.y);
                [self releasePlayer];
            }
        }
    }
}

#pragma mark - 视频相关
- (void)playByAVPlayer{
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
    _playerLayer.frame = self.playerView.bounds;
    NSLog(@"视频层 %@",NSStringFromCGRect(_playerLayer.frame));
    // 设置画面缩放模式
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //        playerLayer.videoRect = CGRectMake(10, 64, WIDTH - 20, 400);
    
    // 在视图上添加播放器
    [self.playerView.layer addSublayer:_playerLayer];
    
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
    [avPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听准备播放状态属性
    // AVPlayerItemStatus status = avPlayerItem.status;                         //获取播放属性
    [avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 系统通知
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


#pragma mark - 初始化
- (MSUNearbyPopView *)popView{
    if (!_popView) {
        NSArray *arr = @[@"全部",@"只看男♂",@"只看♀"];
        self.popView = [[MSUNearbyPopView alloc] initWithFrame:CGRectMake(WIDTH-19-135, 70, 135, 111) titArr:arr rowSize:CGSizeMake(135, 37)];
        [self.view addSubview:_popView];
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.layer.shadowColor = [UIColor grayColor].CGColor;
        _popView.layer.shadowOffset = CGSizeMake(10, 3);
        _popView.layer.shadowOpacity = 0.5;
        _popView.layer.shadowRadius = 3;
        _popView.hidden = YES;
    }
    return _popView;
}

- (MSUPullView *)pullView{
    if (!_pullView) {
        NSArray *imaArr = @[@"state-detail-more-save",@"state-detail-more-unfollow",@"state-detail-more-share",@"state-detail-more-inform"];
        NSArray *titArr = @[@"收藏",@"关注",@"分享",@"举报"];
        self.pullView = [[MSUPullView alloc] initWithFrame:CGRectMake(WIDTH-14-135, 42, 135, 37*4) imaArr:imaArr tittleArr:titArr rowHeight:37];
        _pullView.backgroundColor = HEXCOLOR(0xffffff);
        _pullView.layer.shadowColor = HEXCOLOR(0xc3c3c3).CGColor;
        _pullView.layer.shadowOffset = CGSizeMake(15, 3);
        _pullView.layer.shadowOpacity = 0.5;
        _pullView.layer.shadowRadius = 3;
        _pullView.hidden = YES;
    }
    return _pullView;
}


@end
