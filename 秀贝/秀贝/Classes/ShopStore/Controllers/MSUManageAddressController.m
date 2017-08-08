//
//  MSUManageAddressController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUManageAddressController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUManageAddressTableCell.h"

#import "MSUStringTools.h"

@interface MSUManageAddressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , copy) NSString *addressStr;
@property (nonatomic , assign) CGRect textRect;

@end

@implementation MSUManageAddressController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    self.addressStr = @"浙江省杭州市江干区四季青街道凯旋路迪凯银座迪凯银座迪凯银座迪凯银座1301室";
    self.textRect = [MSUStringTools danamicGetHeightFromText:self.addressStr WithWidth:WIDTH font:16];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:15];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = YELLOWCOLOR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[MSUManageAddressTableCell class] forCellReuseIdentifier:@"manageAddressCell"];

    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, HEIGHT-50, WIDTH, 50);
    [addBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.backgroundColor = [UIColor redColor];
    addBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30 + _textRect.size.height + 6 + 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUManageAddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"manageAddressCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.userLab.text = @"叶叶叶叶叶子";
    cell.addressLab.text = self.addressStr;
    cell.addressLab.frame = CGRectMake(10, 30, WIDTH-20, _textRect.size.height);
    [cell.defaultBtn addTarget:self action:@selector(defaultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)addBtnClick:(UIButton *)sender{
    
}

- (void)defaultBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

@end
