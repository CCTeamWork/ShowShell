//
//  MSUOrderSureController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUOrderSureController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUOrderSureCell.h"
#import "MSUOrderContentView.h"
#import "MSUPayView.h"
#import "MSUAddAddressController.h"


#import "MSUPathTools.h"
#import "MSUStringTools.h"

@interface MSUOrderSureController ()<UITableViewDelegate,UITableViewDataSource>

/// 滚动视图
@property (nonatomic , strong) UIScrollView *scrollView;

/// 订单列表
@property (nonatomic , strong) UITableView *tableView;
/// 数据数组
@property (nonatomic , strong) NSMutableArray *dataArr;

/// 商品内容高
@property (nonatomic , assign) CGRect textHeight;

@end

@implementation MSUOrderSureController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.dataArr = [NSMutableArray array];
    
    // 导航栏
    MSUHomeNavView *home = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:9];
    [self.view addSubview:home];
    
    // 订单列表
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"icon-z",@"icon",@"叶叶叶叶叶子的个人展览馆",@"tittle",@"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!",@"text",@"icon-z",@"image",@"88.80",@"price",@"1",@"number" ,nil];
    self.textHeight = [MSUStringTools danamicGetHeightFromText:dic[@"text"] WithWidth:WIDTH font:18];
    
    [_dataArr addObject:dic];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64 - 49)];
    _scrollView.backgroundColor = BGLINECOLOR;
    _scrollView.contentSize = CGSizeMake(0, HEIGHT-64);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_scrollView];
    
    // tableview创建
    [self createOrderTableView];
    
    // 中部试图
    [self createCEnterView];
}

/* 创建头部tableview视图 */
- (void)createOrderTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 145*_dataArr.count) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 145;
    _tableView.scrollEnabled = NO;
    [_scrollView addSubview:_tableView];
}

/* 创建中部视图 */
- (void)createCEnterView{
    // 运费相关
    MSUOrderContentView *content = [[MSUOrderContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), WIDTH, 205)];
    content.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1];
    [_scrollView addSubview:content];
    content.numLab.text = @"包邮";
    content.totalLab.attributedText = [MSUStringTools changeLabelWithText:[NSString stringWithFormat:@"合计:¥%@",@"88.80"] AndFromOrigiFont:14 toChangeFont:14 AndFromOrigiLoca:3 WithBeforePart:1];
    [content.addAddressBtn addTarget:self action:@selector(addAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 付款方式
    MSUPayView *pay = [[MSUPayView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(content.frame), WIDTH, 178)];
    pay.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:pay];
    
    // 提交订单
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(0, HEIGHT-49, WIDTH, 49);
    [testBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    testBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    testBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:testBtn];
    //    [testBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断是否可以滚动，如果超出屏幕范围 可以滚动；
    if ((CGRectGetMaxY(pay.frame)+64) > (HEIGHT-49)) {
        _scrollView.scrollEnabled = YES;
    }else{
        _scrollView.scrollEnabled = NO;
    }

}

#pragma mark - 点击事件
- (void)addAddressBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUAddAddressController *add = [[MSUAddAddressController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}

#pragma mark - 代理相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"orderCell";
    MSUOrderSureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MSUOrderSureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    cell.iconIma.image = [MSUPathTools showImageWithContentOfFileByName:[_dataArr[indexPath.row] objectForKey:@"icon"]];
    cell.nickLab.text = _dataArr[indexPath.row][@"tittle"];
//    cell.shopIma.image = [MSUPathTools showImageWithContentOfFileByName:_dataArr[indexPath.row][@"image"]];
    cell.shopNameLab.text = _dataArr[indexPath.row][@"text"];
    cell.shopNameLab.frame = CGRectMake(5+80+10, 3, WIDTH-20-(5+70+10), _textHeight.size.height);
    cell.numLab.text = _dataArr[indexPath.row][@"number"];
    cell.priceLab.text = [NSString stringWithFormat:@"¥%@",_dataArr[indexPath.row][@"price"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
