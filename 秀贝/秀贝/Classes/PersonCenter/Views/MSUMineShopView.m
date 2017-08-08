//
//  MSUMineShopView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUMineShopView.h"
#import "MSUMineShopTableCell.h"
#import "MSUHousePopView.h"

#import "MSUStringTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@interface MSUMineShopView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) MSUHousePopView *popView;

@property (nonatomic , strong) MSUMineShopTableCell *currentCell;

@end

@implementation MSUMineShopView

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
    [_tableView registerClass:[MSUMineShopTableCell class] forCellReuseIdentifier:@"mineShopCell"];
    _tableView.rowHeight = 100;

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, self.frame.size.height-50, SelfWidth, 50);
//    [addBtn setTitle:@"+ 新增商品" forState:UIControlStateNormal];
    [addBtn setAttributedTitle:[MSUStringTools makeKeyWordAttributedWithSubText:@"+" inOrigiText:@"+ 新增商品" font:14 color:[UIColor redColor]] forState:UIControlStateNormal];
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
    MSUMineShopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineShopCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];

    cell.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect hotRect = [MSUStringTools danamicGetHeightFromText:cell.shopNameLab.text WithWidth:(SelfWidth-30) font:16];
    cell.shopNameLab.frame = CGRectMake(10+80+10, 10, SelfWidth-20-(10+80+10), hotRect.size.height);
    cell.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.80"];
    cell.yongjinLab.text = [NSString stringWithFormat:@"总佣金:%@元",@"10"];
    [cell.yongjinBtn addTarget:self action:@selector(yongjinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)yongjinBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.currentCell = (MSUMineShopTableCell *)sender.superview.superview;
        if (self.popView) {
            [self.popView removeFromSuperview];
        }
        
        self.popView = [[MSUHousePopView alloc] initWithFrame:CGRectMake(SelfWidth-10-100, CGRectGetMaxY(self.currentCell.frame), 100, 90)];
        _popView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_popView];
        _popView.shareLab.text = [NSString stringWithFormat:@"分享佣金:%@元",@"1"];
        _popView.videoLab.text = [NSString stringWithFormat:@"视频佣金:%@元",@"9"];
    } else {
        [self.popView removeFromSuperview];
    }

}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        // 1. 更新数据

//        [_allDataArray removeObjectAtIndex:indexPath.row];

        // 2. 更新UI

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];

    [tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];

    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

    }];

    return @[deleteAction,editAction];
}





@end
