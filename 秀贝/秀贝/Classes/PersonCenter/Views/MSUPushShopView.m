//
//  MSUPushShopView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/8.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPushShopView.h"
#import "MSUPushShopTableCell.h"

#import "MSUStringTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@interface MSUPushShopView()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation MSUPushShopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, SelfHeight-64-40) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MSUPushShopTableCell class] forCellReuseIdentifier:@"pushShopCell"];
    _tableView.rowHeight = 140;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, self.frame.size.height-50, SelfWidth, 50);
    //    [addBtn setTitle:@"+ 新增商品" forState:UIControlStateNormal];
    [addBtn setAttributedTitle:[MSUStringTools makeKeyWordAttributedWithSubText:@"+" inOrigiText:@"+ 新增推广" font:14 color:[UIColor redColor]] forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.backgroundColor = [UIColor whiteColor];
    addBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:addBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUPushShopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pushShopCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    
    cell.userIma.image = [UIImage imageNamed:@""];
    cell.nickLab.text = @"叶叶叶叶叶子";
    cell.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect hotRect = [MSUStringTools danamicGetHeightFromText:cell.shopNameLab.text WithWidth:(SelfWidth-30) font:16];
    cell.shopNameLab.frame = CGRectMake(10+80+10, 35, SelfWidth-20-(10+80+10), hotRect.size.height);
    cell.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.80"];
    cell.yongjinLab.text = [NSString stringWithFormat:@"总佣金:%@元",@"10"];
    NSString *timeStr = [NSString stringWithFormat:@"有效期:%@",@"2017-07-08至2017-07-18"];
    cell.timeLab.attributedText = [MSUStringTools makeKeyWordAttributedWithSubText:@"有效期" inOrigiText:timeStr font:14 color:[UIColor grayColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        // 1. 更新数据
        
        //        [_allDataArray removeObjectAtIndex:indexPath.row];
        
        // 2. 更新UI
        
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    //    [tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    
    return @[deleteAction];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //    editingStyle = UITableViewCellEditingStyleDelete;
}

@end
