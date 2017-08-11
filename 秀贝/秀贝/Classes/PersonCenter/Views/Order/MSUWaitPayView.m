//
//  MSUWaitPayView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUWaitPayView.h"

#import "MSUOrderTableCell.h"

#import "MSUStringTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@interface MSUWaitPayView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@end

@implementation MSUWaitPayView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, SelfHeight-104) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [self addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MSUOrderTableCell class] forCellReuseIdentifier:@"waitPayCell"];
    _tableView.rowHeight = 180;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUOrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waitPayCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    cell.nickLab.text = @"叶叶叶叶叶子";
    cell.statusLab.text = @"等待付款";
    cell.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect rect = [MSUStringTools danamicGetHeightFromText:cell.shopNameLab.text WithWidth:SelfWidth font:16];
    cell.shopNameLab.frame = CGRectMake(95, 41, SelfWidth-105-10-10, rect.size.height);
    cell.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.88"];
    cell.numLab.text = [NSString stringWithFormat:@"x%@",@"1"];
    cell.sizeLab.text = [NSString stringWithFormat:@"颜色分类：%@ 尺码：%@",@"红底",@"（80-100斤）160码"];
    cell.payBtn.hidden = NO;
    cell.cancelBtn.hidden = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(cellDidSelct)]) {
        [_delegate cellDidSelct];
    }
}

@end
