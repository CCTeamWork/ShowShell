//
//  MSULocationController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSULocationController.h"
#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"
#import "MSUCityCell.h"

@interface MSULocationController ()<UITableViewDelegate,UITableViewDataSource>

/// tableview
@property (nonatomic , strong) UITableView *tableView;
/// datasource
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , strong) NSMutableDictionary *dataDict;
/// sectionArr
@property (nonatomic , strong) NSArray *sectionArr;
@end

@implementation MSULocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = NavColor;
    /// 导航栏
    [self createNavView];
    /// 中心视图
    [self createCenterView];
    self.sectionArr = @[@"热门城市",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    self.dataDict = [[NSMutableDictionary alloc] initWithContentsOfFile:addressPath];

}

#pragma mark - 视图相关
/*
 ** 导航栏
 */
- (void)createNavView{
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:2];
    [self.view addSubview:nav];
    [nav.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

/*
 ** tableview
 */
- (void)createCenterView{
    /// 当前城市视图
    NSString *currCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"city"]) {
        currCity = @"正在定位...";
    }
    NSLog(@"城市---%@",currCity);
    UIView *curCityView = [self createHeaderViewWithIdenty:[NSString stringWithFormat:@"当前城市 %@",currCity] height:40];;
    curCityView.frame = CGRectMake(0, 64, WIDTH, 40);
    curCityView.backgroundColor = WHITECOLOR;
    [self.view addSubview:curCityView];
    
    /// tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, WIDTH, HEIGHT-64-40) style:UITableViewStylePlain];
    _tableView.backgroundColor = WHITECOLOR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.tableHeaderView = [self createHeaderViewWithIdenty:nil];
    [self.view addSubview:_tableView];
    _tableView.sectionHeaderHeight = 30;
    _tableView.sectionIndexColor = TEXTCOLOR;
}

- (UIView *)createHeaderViewWithIdenty:(NSString *)identy height:(NSInteger)height{
    /// 头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    headerView.backgroundColor = YELLOWCOLOR;

    /// 头视图文字
    UILabel *scanLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH-40, height)];
    scanLab.text = identy;
    scanLab.textColor = TEXTCOLOR;
    scanLab.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:scanLab];

    return headerView;
}

#pragma mark - 点击事件相关
- (void)cancelBtnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 代理方法相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.dataArr = [_dataDict objectForKey:_sectionArr[section]];
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [_dataDict objectForKey:_sectionArr[indexPath.section]][indexPath.row];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [self createHeaderViewWithIdenty:_sectionArr[section] height:30];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
        self.locationCityBlock([_dataDict objectForKey:_sectionArr[indexPath.section]][indexPath.row]);
    }];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *letterArr = [NSMutableArray array];
    NSString *str;
    for (NSString *letterStr in _sectionArr) {
        str = letterStr;
        if ([letterStr isEqualToString:@"热门城市"]) {
            str = [letterStr substringToIndex:2];
        }
        [letterArr addObject:str];
    }
    return letterArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSInteger count = 0;
    for (NSString *charString in _sectionArr) {
        if ([charString isEqualToString:title]) {
            return count;
        }
        count++;
    }
    return 0;
}

@end
