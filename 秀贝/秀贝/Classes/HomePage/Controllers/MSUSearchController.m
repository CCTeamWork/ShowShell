//
//  MSUSearchController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchController.h"

/* 工具类 */
#import "MSUPrefixHeader.pch"
#import "MSUAFNRequest.h"
#import "MSUPathTools.h"
#import "MSUStringTools.h"

/* 视图类 */
#import "MSUHomeNavView.h"
#import "MSUVideoController.h"
#import "MSUTransitionTool.h"
#import "MSUSearchCollectionCell.h"
#import "MSUCollectBGView.h"
#import "MSUSearchTableCell.h"
#import "MSUSearchResultView.h"
#import "MSUSearchTotalView.h"
#import "MSUNearbyCell.h"
#import "MSUHotTableCell.h"
#import "MSUSearchVideoView.h"
#import "MSUSearchUserView.h"
#import "MSUSearchUserTableCell.h"
#import "MSUSearchHotView.h"
#import "MSUAVPlayerViewTool.h"

@interface MSUSearchController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) MSUCollectBGView *collecBGView;
@property (nonatomic , strong) MSUSearchResultView *resultView;
@property (nonatomic , strong) MSUHomeNavView *navView;

/// 综合视图
@property (nonatomic , strong) MSUSearchTotalView *totalView;
@property (nonatomic , assign) CGFloat totalCellHeight;
@property (nonatomic , copy) NSString *totalText;
@property (nonatomic , assign) CGRect totalRect;
@property (nonatomic , copy) NSString *totalTranText;
@property (nonatomic , assign) CGRect totalTranRect;

/// 搜索结果之视频视图
@property (nonatomic , strong) MSUSearchVideoView *videoView;
@property (nonatomic , strong) MSUNearbyCell *currentCell;
@property (nonatomic , strong) MSUAVPlayerViewTool *playView;

/// 搜索结果之用户视图
@property (nonatomic , strong) MSUSearchUserView *userView;

/// 搜索结果之商品视图
@property (nonatomic , strong) MSUSearchHotView *hotView;

/// tableView
@property (nonatomic , strong) UIView *tableBGView;
@property (nonatomic , strong) UITableView *tableView;

//数据源
@property (nonatomic , strong) NSMutableArray *dataList;
@property (nonatomic , strong) NSMutableArray *searchList;
@property (nonatomic , strong) NSMutableArray *historyList;
@property (nonatomic , copy) NSString *inputString;

@end

@implementation MSUSearchController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 假数据无奈之举
    self.totalText = @"有一美人兮，见之不忘。一日不见兮，思之如狂。凤飞翱翔兮，四海求凰。无奈佳人兮，不在东墙。将琴代语兮，聊写衷肠。何日见许兮，慰我彷徨。愿言配德兮，携手相将。不得于飞兮，使我沦亡。";
    self.totalRect = [MSUStringTools danamicGetHeightFromText:self.totalText WithWidth:WIDTH-10 font:12];
    self.totalTranText =  @"转发视频";
    self.totalTranRect = [MSUStringTools danamicGetHeightFromText:_totalTranText WithWidth:WIDTH-10 font:12];
    self.totalCellHeight = 50 + 10 + _totalTranRect.size.height + 5 + 5 + self.totalRect.size.height+ 220 + 5 + 25 + 5 + 40 + 20;

    
    /// 假数据
    self.dataList = [NSMutableArray array];
    self.searchList = [NSMutableArray array];
    self.historyList = [NSMutableArray array];
    [self.historyList addObject:@"月光宝盒"];
    self.dataList=[NSMutableArray arrayWithCapacity:100];
    //产生100个“数字+三个随机字母”
    for (NSInteger i=0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
    }

    // 导航栏视图
    [self createNavView];

    // collectView
    [self createColletView];
    
    // tableview 视图
    [self createTableView];
    
}

#pragma mark - 视图相关
/* 导航视图 */
- (void)createNavView{
    self.navView = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:4];
    [self.view addSubview:_navView];
    _navView.search.delegate = self;
    [_navView.searchCancleBtn addTarget:self action:@selector(searchCancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.search becomeFirstResponder];
}

/* 列表视图 */
- (void)createTableView{
    self.tableBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    _tableBGView.backgroundColor = BGLINECOLOR;
    _tableBGView.hidden = YES;
    [self.view addSubview:_tableBGView];
    
    // 列表初始化
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10,WIDTH ,HEIGHT-64-10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.rowHeight = 41;
    [_tableBGView addSubview:_tableView];
}

/* 表格视图 */
- (void)createColletView{
    // 表格
    self.collecBGView = [[MSUCollectBGView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) tableHeight:41 * self.historyList.count];
    _collecBGView.backgroundColor = BGLINECOLOR;
    [self.view addSubview:_collecBGView];
    _collecBGView.collectionView.delegate = self;
    _collecBGView.collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 换一换
    
    // 历史搜索
    _collecBGView.historyTableView.delegate = self;
    _collecBGView.historyTableView.dataSource = self;
}

#pragma mark - 自定义方法
/* 假数据方法 - 产生3个随机字母 */
- (NSString *)shuffledAlphabet {
    
    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"爱",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    
    NSString *strTest = [[NSString alloc]init];
    for (int i=0; i<3; i++) {
        int x = arc4random() % 25;
        strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
    }
    
    return strTest;
}

#pragma mark - 代理方法相关
/* searchBar 代理方法 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    [[MSUAFNRequest sharedInstance] postRequestWithURL:nil parameters:searchText withBlock:^(id obj, NSError *error) {
//        if (!error) {
//            
//        }
//    }];
//
    _tableBGView.hidden = NO;
    _resultView.hidden = YES;
    self.inputString = searchText;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    if (self.searchList) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList = [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    
    //刷新表格
    [self.tableView reloadData];

//    if (!searchText || searchText.length <= 0) {
//        _tableBGView.hidden = YES;
//        _resultView.hidden = YES;
//        _collecBGView.hidden = NO;
//    }
}

/* 搜索按钮点击 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchDidSure];
}

/* tableview相关代理 */
/* 设置区域的行数 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        if (self.inputString && self.inputString.length > 0) {
            return [self.searchList count];
        }else{
            return [self.dataList count];
        }
    } else if (tableView == _collecBGView.historyTableView){
        return self.historyList.count;
    } else if (tableView == _totalView.danamicTableView){
        return 2;
    } else if (tableView == _totalView.hotTableView){
        return 3;
    } else if (tableView == _videoView.videoTableView){
        return 4;
    } else if (tableView == _userView.userTableView){
        return 8;
    } else if (tableView == _hotView.hotTableView){
        return 8;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _totalView.danamicTableView) {
        return self.totalCellHeight;
    } else if (tableView == _tableView){
        return 41;
    }
    else if (tableView == _collecBGView.historyTableView){
        return 41;
    }
    else if (tableView == _totalView.hotTableView ){
        return 97;
    }
    else if (tableView == _hotView.hotTableView){
        return 97;
    }
    else if (tableView == _videoView.videoTableView){
        return self.totalCellHeight;
    }
    else if (tableView == _userView.userTableView){
        return 70;
    }
    
    return 0;
}


/* 返回单元格内容 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        static NSString *flag = @"cell";
        MSUSearchTableCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
        if (cell == nil) {
            cell = [[MSUSearchTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag historyNum:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.inputString && self.inputString.length > 0) {
            [UIView animateWithDuration:0.25 animations:^{
                _collecBGView.hidden = YES;
                _resultView.hidden = YES;
            } completion:^(BOOL finished) {
                _tableBGView.hidden = NO;
                // 将带属性的字符串添加到cell.textLabel上.
                if (self.searchList && self.searchList.count>0) {
                    [cell.searLab setAttributedText:[MSUStringTools makeKeyWordAttributedWithSubText:self.inputString inOrigiText:self.searchList[indexPath.row]]];
                }
            }];
        }
        else{
            _tableBGView.hidden = YES;
            _collecBGView.hidden = NO;
        }
        return cell;
        
    } else if (tableView == _collecBGView.historyTableView){
        static NSString *flag = @"historyCell";
        MSUSearchTableCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
        if (cell == nil) {
            cell = [[MSUSearchTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag historyNum:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BGLINECOLOR;
        }
        cell.searLab.text = self.historyList[indexPath.row];
        
        return cell;
    } else if (tableView == _totalView.danamicTableView){
        static NSString *cellID = @"totalTable";
      
        return [self showContenInVideoCell:tableView cellID:cellID index:indexPath.row];
    }
    
    else if (tableView == _videoView.videoTableView){
        static NSString *cellID = @"vedioTable";
        
        return [self showContenInVideoCell:tableView cellID:cellID index:indexPath.row];
    }
    
    
    else if (tableView == _totalView.hotTableView){
        static NSString *cellID = @"hotTotalCell";
        
        return [self showContenInShopCell:tableView cellID:cellID index:indexPath.row];
    }
    
    else if (tableView == _hotView.hotTableView){
        static NSString *cellID = @"hotVideoCell";
        
        return [self showContenInShopCell:tableView cellID:cellID index:indexPath.row];
    }
    
    else if (tableView == _userView.userTableView){
        NSString *cellID = @"searchUserCell";
        MSUSearchUserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[MSUSearchUserTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            cell.selectionStyle = ;
        }
        [cell.iconBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"icon-z"] forState:UIControlStateNormal];
        cell.nickLab.text = @"一只小黄鸡";
        cell.introLab.text = @"喜欢自拍，喜欢交朋友";
        
        return cell;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _collecBGView.historyTableView) {
        
    } else if (tableView == _tableView){
        [self searchDidSure];
    } else if (tableView == _totalView.danamicTableView){
        
    } else if (tableView == _videoView.videoTableView){
    
    }
}

/* collectionView相关代理 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MSUSearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString *textStr = @"愿我来时，春暖花开";
    CGSize strSize = [MSUStringTools danamicGetWidthFromText:@"愿我来时，春暖花开" WithFont:14];
    cell.hotLab.text = textStr;
    cell.hotLab.frame = CGRectMake(15, 0, strSize.width, 40);
    if (indexPath.row == 0) {
        cell.hotIma.hidden = NO;
    }
    
    return cell;
}

/* 滚动视图代理 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"哈哈哈哈 滚动滚动%f",scrollView.contentOffset.x);
    if (scrollView == _resultView.scrollView) {
        [UIView animateWithDuration:0.25 animations:^{
            _resultView.underLineView.frame = CGRectMake(WIDTH/8-15+WIDTH/4*((scrollView.contentOffset.x-WIDTH)/(WIDTH)+1), 38, 30, 5);
        }];
    }
    
}



#pragma mark - 点击事件相关
- (void)searchCancleBtnClick:(UIButton *)sender{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

/* 确定搜索事件 */
- (void)searchDidSure{
    [UIView animateWithDuration:0.25 animations:^{
        
        _tableBGView.hidden = YES;
        _collecBGView.hidden = YES;
        [_navView.search resignFirstResponder];
        _navView.search.text = @"";
    } completion:^(BOOL finished) {
        self.resultView.hidden = NO;
        self.totalView.hidden = NO;
    }];
}

- (void)seleBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _resultView.underLineView.frame = CGRectMake(CGRectGetMidX(sender.frame)-15, 38, 30, 5);
        //        _resultView.underLineView.frame = CGRectMake(WIDTH/8-15+WIDTH/4*(sender.tag-2017), 38, 30, 5);
    }];
    
    NSLog(@"==== 线%f, 按钮 %f ",CGRectGetMidX(_resultView.underLineView.frame),CGRectGetMidX(sender.frame));
    
    for (UIButton *btn in _resultView.seleArr) {
        btn.selected = NO;
    }
    sender.selected = YES;
    
    
    if (sender == _resultView.seleArr[0]) {
        _resultView.scrollView.contentOffset = CGPointMake(0, 0);
        self.totalView.hidden = NO;
    }
    else if (sender == _resultView.seleArr[1]){
        _resultView.scrollView.contentOffset = CGPointMake(WIDTH, 0);
        self.videoView.hidden = NO;
    }
    else if (sender == _resultView.seleArr[2]){
        _resultView.scrollView.contentOffset = CGPointMake(WIDTH*2, 0);
        self.userView.hidden = NO;
    }
    else if (sender == _resultView.seleArr[3]){
        _resultView.scrollView.contentOffset = CGPointMake(WIDTH*3, 0);
        self.hotView.hidden = NO;
    }
}

- (void)playBtnClick:(UIButton *)sender{
    
    self.currentCell = (MSUNearbyCell *)sender.superview.superview;
    if (self.playView) {
        [self releasePlayer];
        self.playView = [[MSUAVPlayerViewTool alloc] initWithFrame:self.currentCell.videoImaView.bounds];
    }else{
        self.playView = [[MSUAVPlayerViewTool alloc] initWithFrame:self.currentCell.videoImaView.bounds];
    }
    
    self.currentCell.playBtn.hidden = YES;
    [self.currentCell.videoImaView addSubview:_playView];
    [self.currentCell.videoImaView bringSubviewToFront:_playView];
}

/* 释放播放器相关 */
- (void)releasePlayer{
    //    NSLog(@"view1 : %@",self.playerView.superview.superview.superview);
    
    MSUNearbyCell *cell = (MSUNearbyCell *)self.playView.superview.superview.superview;
    cell.playBtn.hidden = NO;
    
    [self.playView.playerItem removeObserver:self.playView  forKeyPath:@"status" context:nil];
    [self.playView.playerItem removeObserver:self.playView  forKeyPath:@"loadedTimeRanges" context:nil];
    
    [self.playView.playerItem  cancelPendingSeeks];
    [self.playView.playerItem .asset cancelLoading];
    
    [self.playView removeFromSuperview];
    [self.playView .playerLayer removeFromSuperlayer];
    [self.playView .player replaceCurrentItemWithPlayerItem:nil];
    self.playView .player = nil;
    self.playView .playerItem = nil;
}



#pragma mark - 初始化
- (MSUSearchResultView *)resultView{
    if (!_resultView) {
        self.resultView = [[MSUSearchResultView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
        //    _resultView.hidden = YES;
        [self.view addSubview:_resultView];
        _resultView.scrollView.delegate = self;
        _resultView.underLineView.frame = CGRectMake(WIDTH/8-15, 38, 30, 5);
        for (UIButton *btn in _resultView.seleArr) {
            [btn addTarget:self action:@selector(seleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _resultView;
}

- (MSUSearchTotalView *)totalView{
    if (!_totalView) {
        NSArray *arr = @[@"icon-z",@"icon-z",@"icon-z",@"icon-z",@"icon-z",@"icon-z",@"icon-z",@"icon-z"];
        self.totalView = [[MSUSearchTotalView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-120) imageArr:arr tableHeight:self.totalCellHeight*2];
        _totalView.backgroundColor = BGLINECOLOR;
        [_resultView.scrollView addSubview:_totalView];
        _totalView.userLab.text = [NSString stringWithFormat:@"相关用户(%@个)",@"88"];
        
        // 中部动态视图
        _totalView.danamicTableView.delegate = self;
        _totalView.danamicTableView.dataSource = self;
        
        // 底部试图
        _totalView.hotTableView.delegate = self;
        _totalView.hotTableView.dataSource = self;
    }
    return _totalView;
}

- (MSUSearchVideoView *)videoView{
    if (!_videoView) {
        self.videoView = [[MSUSearchVideoView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT) tableHeight:self.totalCellHeight*4];
        [_resultView.scrollView addSubview:_videoView];
        _videoView.videoTableView.delegate = self;
        _videoView.videoTableView.dataSource = self;
        _videoView.videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _videoView.videoTableView.panGestureRecognizer.delaysTouchesBegan = _videoView.videoTableView.delaysContentTouches;
    }
    return _videoView;
}

- (MSUSearchUserView *)userView{
    if (!_userView) {
        self.userView = [[MSUSearchUserView alloc] initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT) tableHeight:70*8];
        [_resultView.scrollView addSubview:_userView];
        _userView.userTableView.delegate = self;
        _userView.userTableView.dataSource = self;
        _userView.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _userView.userTableView.panGestureRecognizer.delaysTouchesBegan = _userView.userTableView.delaysContentTouches;
    }
    return _userView;
}

- (MSUSearchHotView *)hotView{
    if (!_hotView) {
        self.hotView = [[MSUSearchHotView alloc] initWithFrame:CGRectMake(WIDTH*3, 0, WIDTH, HEIGHT) tableHeight:97*8];
        [_resultView.scrollView addSubview:_hotView];
        _hotView.hotTableView.delegate = self;
        _hotView.hotTableView.dataSource = self;
        _hotView.hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hotView.hotTableView.panGestureRecognizer.delaysTouchesBegan = _hotView.hotTableView.delaysContentTouches;
    }
    return _hotView;

}

- (UITableViewCell *)showContenInVideoCell:(UITableView *)tableView cellID:(NSString *)cellID index:(NSInteger)index{
    MSUNearbyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MSUNearbyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    // 头像
    [cell.iconBtn setImage:[UIImage imageNamed:@"icon-z"] forState:UIControlStateNormal];
    // 昵称
    cell.nickLab.text = @"何何何何太太";
    // 时间
    cell.timeLab.text = @"2017-07-11 19:30";
    // 是否转发
    cell.isTranspod = YES;
    
    if (cell.isTranspod) {
        // 转发评论
        cell.transpodLab.text = _totalTranText;
        cell.transpodLab.frame = CGRectMake(10, 50 + 10, WIDTH-20, _totalTranRect.size.height);
        // 内容正题
        cell.tittleLab.text = self.totalText;
        cell.tittleBGView.frame = CGRectMake(0, 50 + 10 + _totalTranRect.size.height + 5, WIDTH, self.totalRect.size.height+5);
        cell.tittleLab.frame = CGRectMake(10, 5, WIDTH-20, self.totalRect.size.height);
        cell.videoBGView.frame = CGRectMake(0, CGRectGetMaxY(cell.tittleBGView.frame), WIDTH, 220);
        
        cell.tittleBGView.backgroundColor = SLIVERYCOLOR;
        cell.videoBGView.backgroundColor = SLIVERYCOLOR;
        
    }else{
        // 内容正题
        cell.tittleLab.text = self.totalText;
        //            CGRect textRect = [MSUStringTools danamicGetHeightFromText:cell.tittleLab.text WithWidth:WIDTH-10 font:12];
        cell.tittleBGView.frame = CGRectMake(0, 50 + 10 , WIDTH, self.totalRect.size.height);
        cell.tittleLab.frame = CGRectMake(10, 0, WIDTH-20, self.totalRect.size.height);
        cell.videoBGView.frame = CGRectMake(0, CGRectGetMaxY(cell.tittleBGView.frame), WIDTH, 210);
    }
    
    // 视频页面
    cell.videoImaView.image = [UIImage imageNamed:@"FoSe.jpeg"];
    // 播放按钮
    [cell.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.playBtn.tag = index;
    
    // 是否定位
    cell.isLocation = YES;
    if (cell.isLocation) {
        cell.lineView.frame = CGRectMake(0, CGRectGetMaxY(cell.videoBGView.frame) + 5+ 25+ 5 , WIDTH, 1);
    }else{
        cell.locationBtn.hidden = YES;
        cell.dictanceBtn.hidden = YES;
        cell.lineView.frame = CGRectMake(0, CGRectGetMaxY(cell.videoBGView.frame) + 5 , WIDTH, 1);
    }
    
    //        self.totalCellHeight = CGRectGetMaxY(cell.lineView.frame) + 40 + 20;
    return cell;
    
}

- (UITableViewCell *)showContenInShopCell:(UITableView *)tableView cellID:(NSString *)cellID index:(NSInteger)index{
    MSUHotTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MSUHotTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //            cell.backgroundColor = BGLINECOLOR;
    }
    cell.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect hotRect = [MSUStringTools danamicGetHeightFromText:cell.shopNameLab.text WithWidth:(WIDTH-30) font:16];
    cell.shopNameLab.frame = CGRectMake(5+80+10, 3, WIDTH-30-(5+80+10), hotRect.size.height);
    cell.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.80"];
    return cell;
}

@end
