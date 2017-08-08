//
//  MSUShopDetailController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUShopDetailController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUShopDetailView.h"
#import "MSUStoreInfoView.h"
#import "MSUGeussLikeView.h"
#import "MSUGeussCollectionViewCell.h"
#import "MSUCommentView.h"
#import "MSUCommentTableViewCell.h"
#import "MSUShopDetailBoottomView.h"
#import "MSUOrderSureController.h"
#import "MSUShopDetailSKUView.h"

#import "MSUAVPlayerViewTool.h"

/* 工具类 */
#import "MSUPathTools.h"
#import "MSUStringTools.h"

@interface MSUShopDetailController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) MSUShopDetailView *detail;

@property (nonatomic , strong) UIView *shadowView;
@property (nonatomic , strong) MSUShopDetailSKUView *skuView;

// 评论内容高
@property (nonatomic , assign) CGFloat commentHeight;
@property (nonatomic , copy) NSString *comText;

@end

@implementation MSUShopDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    // 导航栏
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:8];
    [self.view addSubview:nav];
    
    self.comText = @"因为我刚好遇见你，留下足迹才美丽，风吹花落泪如雨，因为不想分离；因为刚好遇见你，留下十年的期许，如果再相遇，我想我会记得你";
    CGRect rect = [MSUStringTools danamicGetHeightFromText:_comText WithWidth:WIDTH font:14];
    self.commentHeight = rect.size.height;
    
    [self createContentView];

    // 底部试图
    MSUShopDetailBoottomView *bottom = [[MSUShopDetailBoottomView alloc] initWithFrame:CGRectMake(0, HEIGHT-50, WIDTH, 50)];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom];
    [bottom.buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - 内容视图
- (void)createContentView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    scrollView.backgroundColor = BGLINECOLOR;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(0, HEIGHT*5);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:scrollView];
    
    NSArray *imageArr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"1.jpg"];
    NSString *titStr = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里；如传世的青花瓷，自顾自美丽，你眼带笑意！";
    NSString *priceStr = [NSString stringWithFormat:@"¥%@",@"88.80"];
    NSString *freiStr = [NSString stringWithFormat:@"快递 ：%@",@"免运费"];
    
    self.detail = [[MSUShopDetailView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 400) imageArr:imageArr];
    _detail.scrollView.delegate = self;
    [scrollView addSubview:_detail];

    CGRect titRect = [MSUStringTools danamicGetHeightFromText:titStr WithWidth:WIDTH font:16];
    CGSize priSize = [MSUStringTools danamicGetWidthFromText:priceStr WithFont:18];
    
    // 上半部分
    _detail.bgView.frame = CGRectMake(0, 400, WIDTH, 10 + titRect.size.height + 30 + 10);
    _detail.tittleLab.frame = CGRectMake(15, 10, WIDTH-30, titRect.size.height);
    _detail.tittleLab.text = titStr;
    _detail.priceLab.frame = CGRectMake(15, 10 + titRect.size.height, priSize.width, 30);
    _detail.priceLab.text = priceStr;
    _detail.freightLab.frame = CGRectMake(10 + priSize.width + 20, CGRectGetMaxY(_detail.priceLab.frame)-15-6, WIDTH*0.5, 15);
    _detail.freightLab.text = freiStr;
    
    // 中间部分
    CGFloat headerHeight =  CGRectGetMaxY(_detail.bgView.frame);
    CGFloat centerHeight = 15+40+imageArr.count *400 + (imageArr.count-1)*10 + 15;
    CGFloat tableHeight = (50+10+self.commentHeight)*2;
    MSUCommentView *comment = [[MSUCommentView alloc] initWithFrame:CGRectMake(0, headerHeight + centerHeight, WIDTH, 35 + 5 + tableHeight + 35) tableViewHeight: tableHeight];
    comment.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:comment];
    BOOL isComment = YES;
    if (isComment) {
        comment.titLab.text = [NSString stringWithFormat:@"评论（%@）",@"62"];
    }else{
        comment.titLab.text = @"评论";
    }
    comment.tableView.delegate = self;
    comment.tableView.dataSource = self;
    
    
    // 底部部分
    MSUStoreInfoView *info = [[MSUStoreInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(comment.frame)+15, WIDTH, 115)];
    [scrollView addSubview:info];
    [info.imaBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"icon-z"] forState:UIControlStateNormal];
    info.nickLab.text = @"叶叶叶叶叶子个人展览图";
    info.attNumLab.text = @"2.3万";
    info.shopNumLab.text = @"333";
    
    
    // 猜你喜欢页面
    MSUGeussLikeView *geuss = [[MSUGeussLikeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(info.frame)+15, WIDTH, (WIDTH - 30 - 30)/4+95+10) imageCount:8];
    NSLog(@"111111111%@",NSStringFromCGRect(geuss.frame));
    geuss.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:geuss];
    geuss.collectionView.delegate = self;
    geuss.collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_detail.pageControl setCurrentPage:(_detail.scrollView.contentOffset.x + WIDTH*0.5)/(WIDTH-20)];
}

/* tableView 代理 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"tableViewCell";
    MSUCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MSUCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.iconIma.image = [UIImage imageNamed:@"icon-z"];
    cell.nickLab.text = @"叶叶叶叶叶大美女";
    cell.timeLab.text = @"2017-07-11 19:30";
    cell.tittleLab.text = _comText;
    cell.tittleLab.frame = CGRectMake(15, 50 + 5, WIDTH-30, _commentHeight);
    
    if (indexPath.row == 0) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50+10+self.commentHeight - 1, WIDTH, 1)];
        lineView.backgroundColor = BGLINECOLOR;
        [cell addSubview:lineView];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/* collectionView 代理相关 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MSUGeussCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"geussCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.iconIma.image = [MSUPathTools showImageWithContentOfFileByName:@"icon-z"];
    cell.shopLab.text = @"叶叶叶叶叶子的个人展览小铺";
    cell.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.80"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
}

#pragma mark - 点击事件
- (void)buyBtnClick:(UIButton *)sender{
    self.shadowView.hidden = NO;
    self.skuView.hidden = NO;
}

- (void)sureBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUOrderSureController *order = [[MSUOrderSureController alloc] init];
    [self.navigationController pushViewController:order animated:YES];
}


- (UIView *)shadowView{
    if (!_shadowView) {
        self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self.view addSubview:_shadowView];
        _shadowView.hidden = YES;
    }
    return _shadowView;
}

- (MSUShopDetailSKUView *)skuView{
    if (!_skuView) {
        self.skuView = [[MSUShopDetailSKUView alloc] initWithFrame:CGRectMake(0, HEIGHT-230, WIDTH, 230)];
        _skuView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_skuView];
        [_skuView.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _skuView.shopNameLab.text =  @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
        CGRect hotRect = [MSUStringTools danamicGetHeightFromText:_skuView.shopNameLab.text WithWidth:(WIDTH-30) font:16];
        _skuView.shopNameLab.frame = CGRectMake(10+80+10, 10, WIDTH-10-(10+80+10), hotRect.size.height);
        _skuView.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.80"];
    }
    return _skuView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.skuView];
    if (![_skuView.layer containsPoint:point]) {
        self.shadowView.hidden = YES;
        self.skuView.hidden = YES;
    }
}

@end
