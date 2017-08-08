//
//  MSUPickShopVideoView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/4.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPickShopVideoView.h"
#import "MSUShopHouseTableCell.h"

#import "MSUPathTools.h"
#import "MSUStringTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight self.frame.size.height

@interface MSUPickShopVideoView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MSUPickShopVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UILabel *topLab = [[UILabel alloc] init];
    topLab.text = @"选择本页商品提取至”我的商品库“中:";
    topLab.textColor = [UIColor grayColor];
    topLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:topLab];
    [topLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(20);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 30, SelfWidth-30, SelfHeight-30-50) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MSUShopHouseTableCell class] forCellReuseIdentifier:@"shopHouseCell"];
    [self addSubview:_tableView];

    UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateBtn setTitle:@"提取至商品库" forState:UIControlStateNormal];
    [privateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    privateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    privateBtn.backgroundColor = [UIColor orangeColor];
    privateBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:privateBtn];
    [privateBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(50);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUShopHouseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopHouseCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect hotRect = [MSUStringTools danamicGetHeightFromText:cell.shopNameLab.text WithWidth:(SelfWidth-30) font:16];
    cell.shopNameLab.frame = CGRectMake(5+80+10, 3, SelfWidth-30-30-(5+80+10), hotRect.size.height);
    cell.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.80"];
    cell.tuiGuangLab.text = [NSString stringWithFormat:@"推广佣金：%@元",@"10"];
//    cell.tuiGuangLab.frame = CGRectMake(SelfWidth-15-10-sizel.width,65 , sizel.width, 20);
    [cell.infoBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"like"] forState:UIControlStateNormal];
    [cell.infoBtn setTitle:@"叶叶叶叶叶子" forState:UIControlStateNormal];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
