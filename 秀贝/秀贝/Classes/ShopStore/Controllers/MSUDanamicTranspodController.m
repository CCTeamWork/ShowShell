//
//  MSUDanamicTranspodController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUDanamicTranspodController.h"
#import "MSUHomeNavView.h"
#import "MSUTranspodTableCell.h"

#import "MSUPrefixHeader.pch"
#import "MSUPathTools.h"

@interface MSUDanamicTranspodController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>

/// 输入框
@property (nonatomic , strong) UITextView *textView;
/// 占位符
@property (nonatomic , strong) UILabel *placeLab;

/// 列表
@property (nonatomic , strong) UITableView *tableView;

@end

@implementation MSUDanamicTranspodController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:12];
    [self.view addSubview:nav];
    
    [self createCenterView];
}

- (void)createCenterView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    navView.backgroundColor = BGLINECOLOR;
    [self.view addSubview:navView];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 69, WIDTH, 150)];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.delegate = self;
    _textView.textColor = [UIColor grayColor];
    [self.view addSubview:_textView];
    
    self.placeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WIDTH, 30)];
//    _placeLab.backgroundColor = [UIColor redColor];
    _placeLab.text = @"说说你的想法......";
    _placeLab.textColor = [UIColor grayColor];
    _placeLab.font = [UIFont systemFontOfSize:16];
    [_textView addSubview:_placeLab];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 69+150+10, WIDTH-20, 100) style:UITableViewStylePlain];
    _tableView.backgroundColor = YELLOWCOLOR;
    [_tableView registerClass:[MSUTranspodTableCell class] forCellReuseIdentifier:@"transpodCell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *privateView = [[UIView alloc] initWithFrame:CGRectMake(0, 69+150+10+100+20, WIDTH, 40)];
    privateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:privateView];
    
    UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    privateBtn.frame = CGRectMake(0, 0, 100, 40);
    [privateBtn setTitle:@"设置隐私" forState:UIControlStateNormal];
    [privateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    privateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    privateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [privateBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"like"] forState:UIControlStateNormal];
    privateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    privateBtn.backgroundColor = [UIColor whiteColor];
    privateBtn.adjustsImageWhenHighlighted = NO;
    [privateView addSubview:privateBtn];
    
    UILabel *seeLab = [[UILabel alloc] init];
    seeLab.frame = CGRectMake(WIDTH-70, 0, 60, 40);
    seeLab.textAlignment = NSTextAlignmentCenter;
    seeLab.text = @"好友可见";
    seeLab.textColor = [UIColor grayColor];
    seeLab.font = [UIFont systemFontOfSize:14];
    [privateView addSubview:seeLab];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeLab.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    if (_textView.text.length > 0) {
        self.placeLab.hidden = YES;
    }else{
        self.placeLab.hidden =  NO;
    }
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUTranspodTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transpodCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.iconImaView.image = [MSUPathTools showImageWithContentOfFileByName:@"icon-z"];
    cell.nickLab.text = @"叶叶叶叶叶子";
    cell.contentLab.text = @"有一美人兮，见之不忘。一日不见兮，思之如狂。凤飞翱翔兮，四海求凰。无奈佳人兮，不在东墙。将琴代语兮，聊写衷肠。何日见许兮，慰我彷徨。愿言配德兮，携手相将。不得于飞兮，使我沦亡。";
    
    return cell;
}

@end
