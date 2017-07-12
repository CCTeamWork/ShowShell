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

/* 视图类 */
#import "MSUHomeNavView.h"
#import "MSUVideoController.h"
#import "MSUTransitionTool.h"

@interface MSUSearchController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

//tableView
@property (strong, nonatomic)  UITableView *tableView;

//数据源
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (nonatomic , copy) NSString *inputString;

@end

@implementation MSUSearchController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = NavColor;
    
    /// 假数据
    self.dataList = [NSMutableArray array];
    self.searchList = [NSMutableArray array];
    
    self.dataList=[NSMutableArray arrayWithCapacity:100];
    
    //产生100个“数字+三个随机字母”
    for (NSInteger i=0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
    }

    // 导航栏视图
    [self createNavView];
    // tableview 视图
    [self createTableView];
}

#pragma mark - 视图相关
- (void)createNavView{
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:4];
    [self.view addSubview:nav];
    nav.search.delegate = self;
    [nav.searchCancleBtn addTarget:self action:@selector(searchCancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [nav.search becomeFirstResponder];
}

- (void)createTableView{
    /// tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,WIDTH ,HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
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

- (NSMutableAttributedString *)makeKeyWordAttributedWithText:(NSString *)text{
    // 获取关键字的位置
    NSRange range = [text rangeOfString:self.inputString];
    
    // 转换成可以操作的字符串类型.
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 添加属性(粗体)
    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:range];
    
    // 关键字高亮
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    return attribute;
}

#pragma mark - 点击事件相关
- (void)searchCancleBtnClick:(UIButton *)sender{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 代理方法相关
/* searchBar 代理方法 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [[MSUAFNRequest sharedInstance] postRequestWithURL:nil parameters:searchText withBlock:^(id obj, NSError *error) {
        if (!error) {
            
        }
    }];
    
    self.inputString = searchText;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList = [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    
    //刷新表格
    [self.tableView reloadData];
    
}

/* 设置区域的行数 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.inputString && self.inputString.length > 0) {
        return [self.searchList count];
    }else{
        return [self.dataList count];
    }
}


/* 返回单元格内容 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.inputString && self.inputString.length > 0) {
        // 将带属性的字符串添加到cell.textLabel上.
        [cell.textLabel setAttributedText:[self makeKeyWordAttributedWithText:self.searchList[indexPath.row]]];
        cell.textLabel.text = self.searchList[indexPath.row];    }
    else{
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
