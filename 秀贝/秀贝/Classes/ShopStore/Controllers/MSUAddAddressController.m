//
//  MSUAddAddressController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUAddAddressController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUAddAddressTableCell.h"
#import "MSUPickPopView.h"
#import "MSUSeleAddressController.h"


#import "MSUPathTools.h"

@interface MSUAddAddressController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *shadowView;
@property (nonatomic , strong) MSUPickPopView *pickView;

@property (nonatomic , strong) NSMutableDictionary *dataDic;
@property (nonatomic , strong) NSArray *provinceArr;
@property (nonatomic , strong) NSArray *cityArr;


@property (nonatomic , copy) NSString *provinceStr;
@property (nonatomic , copy) NSString *cityStr;

@end

@implementation MSUAddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataDic = [MSUPathTools getPlistPathWithName:@"area" type:@"plist"];
    NSArray *components = [_dataDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[_dataDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    self.provinceArr = [[NSArray alloc] initWithArray: provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [_provinceArr objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[_dataDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    self.cityArr = [[NSArray alloc] initWithArray: [cityDic allKeys]];

    
    self.view.backgroundColor = [UIColor blackColor];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:13];
    [self.view addSubview:nav];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, HEIGHT-50, WIDTH, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    saveBtn.backgroundColor = [UIColor redColor];
    saveBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-50) style:UITableViewStylePlain];
    _tableView.backgroundColor = BGLINECOLOR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 50;
    [_tableView registerClass:[MSUAddAddressTableCell class] forCellReuseIdentifier:@"addAddressCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUAddAddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addAddressCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = @[@"收货人",@"联系方式",@"地区",@"详细地址",@"设为默认地址"];
    cell.cellLab.text = arr[indexPath.row];
    
    if (indexPath.row == 4) {
        cell.cellLab.text = @"";
        UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        privateBtn.backgroundColor = [UIColor redColor];
        privateBtn.frame = CGRectMake(10, 0, 110, 49);
        [privateBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
        [privateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        privateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        privateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [privateBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"like"] forState:UIControlStateNormal];
        privateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        privateBtn.backgroundColor = [UIColor whiteColor];
        privateBtn.adjustsImageWhenHighlighted = NO;
        [cell addSubview:privateBtn];
    } else if (indexPath.row == 2){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        self.shadowView.hidden = NO;
        self.pickView.hidden = NO;
    }
}

/* pickerView的代理 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArr.count;
    }else{
        return self.cityArr.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArr[row];
    }else{
        return self.cityArr[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [_pickView.picker reloadComponent: 0];
    } else {
        
    }
}

#pragma mark - 初始化
- (UIView *)shadowView{
    if (!_shadowView) {
        self.shadowView = [[UIView alloc] initWithFrame:self.view.bounds];
        _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:_shadowView];
        _shadowView.hidden = YES;
    }
    return _shadowView;
}

- (MSUPickPopView *)pickView{
    if (!_pickView) {
        self.pickView = [[MSUPickPopView alloc] initWithFrame:CGRectMake(30, 128, WIDTH-60, HEIGHT-128-128) text:@"请选择省市"];
        _pickView.backgroundColor = [UIColor whiteColor];
        [self.shadowView addSubview:_pickView];
        _pickView.picker.delegate = self;
        _pickView.picker.dataSource = self;
        [_pickView.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_pickView.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pickView;
}

#pragma mark - 点击事件
- (void)cancelBtnClick:(UIButton *)sender{
    self.shadowView.hidden = YES;
}

- (void)sureBtnClick:(UIButton *)sender{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.pickView];
    if (![_pickView.layer containsPoint:point]) {
        self.shadowView.hidden = YES;
    }
}

- (void)saveBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUSeleAddressController *sele = [[MSUSeleAddressController alloc] init];
    [self.navigationController pushViewController:sele animated:YES];
}

@end
