//
//  MSUSeleAddressController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSeleAddressController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUSeleAddressTableCell.h"
#import "MSUSeleHeaderView.h"
#import "MSUManageAddressController.h"


#import "MSUStringTools.h"

@interface MSUSeleAddressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , copy) NSString *addressStr;
@property (nonatomic , assign) CGRect textRect;
@property (nonatomic , copy) NSString *headerStr;
@property (nonatomic , assign) CGRect headerRect;
@end

@implementation MSUSeleAddressController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    self.addressStr = @"浙江省杭州市江干区四季青街道凯旋路迪凯银座迪凯银座迪凯银座迪凯银座1301室";
    self.textRect = [MSUStringTools danamicGetHeightFromText:self.addressStr WithWidth:WIDTH font:16];
    
    self.headerStr = [NSString stringWithFormat:@"%@[默认地址]",self.addressStr];
    self.headerRect = [MSUStringTools danamicGetHeightFromText:self.headerStr WithWidth:WIDTH font:16];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:14];
    [self.view addSubview:nav];
    [nav.positionBtn addTarget:self action:@selector(positionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self createContentView];
    
}


- (void)createContentView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = YELLOWCOLOR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MSUSeleAddressTableCell class] forCellReuseIdentifier:@"seleAddressCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30 + _textRect.size.height + 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUSeleAddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seleAddressCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.userLab.text = @"叶叶叶叶叶子";
    cell.numLab.text = @"15088663580";
    cell.addressLab.text = self.addressStr;
    cell.addressLab.frame = CGRectMake(10, 30, WIDTH-20, _textRect.size.height);
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MSUSeleHeaderView *header = [[MSUSeleHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30+self.headerRect.size.height+10)];
    header.backgroundColor = [UIColor whiteColor];
    
    header.userLab.text = @"叶叶叶叶叶子";
    header.numLab.text = @"15088663580";
    header.addressLab.attributedText = [MSUStringTools makeKeyWordAttributedWithSubText:@"[默认地址]" inOrigiText:self.headerStr font:12 color:[UIColor orangeColor]];
    header.addressLab.frame = CGRectMake(10, 30, WIDTH-20, _textRect.size.height);
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30+self.headerRect.size.height+10;
}

- (void)positionBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUManageAddressController *namage = [[MSUManageAddressController alloc] init];
    [self.navigationController pushViewController:namage animated:YES];
}

@end
