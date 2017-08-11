//
//  MSUSellerWaitPayView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/11.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSellerWaitPayView.h"
#import "MSUSellerWaitPayTableCell.h"

#import "MSUStringTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height


@interface MSUSellerWaitPayView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , copy) NSString *addressStr;
@property (nonatomic , assign) CGRect aa;
@property (nonatomic , copy) NSString *wordsStr;
@property (nonatomic , assign) CGRect bb;

@property (nonatomic , assign) CGFloat rowHeight;


@end

@implementation MSUSellerWaitPayView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.addressStr = @"浙江省杭州市江干区迪凯银座1301市";
    self.aa = [MSUStringTools danamicGetHeightFromText:_addressStr WithWidth:SelfWidth-20-10-70-10 font:14];
    
    self.wordsStr = @"我还是喜欢你，像风吹三千里，不问归期";
    self.bb = [MSUStringTools danamicGetHeightFromText:_wordsStr WithWidth:SelfWidth font:14];
    
    self.rowHeight = 130+10+20+5+_aa.size.height+5+_bb.size.height+10+40;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, SelfHeight-104) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [self addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    [_tableView registerClass:[MSUSellerWaitPayTableCell class] forCellReuseIdentifier:@"orderTotalCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _rowHeight+10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUSellerWaitPayTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderTotalCell"];
    if (!cell) {
        cell = [[MSUSellerWaitPayTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderTotalCell" rowHeight:_rowHeight];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    cell.nickLab.text = @"叶叶叶叶叶子";
    cell.statusLab.text = @"仅退款,申请中";
    cell.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect rect = [MSUStringTools danamicGetHeightFromText:cell.shopNameLab.text WithWidth:SelfWidth font:16];
    cell.shopNameLab.frame = CGRectMake(95, 41, SelfWidth-105-10-10, rect.size.height);
    cell.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.88"];
    cell.numLab.text = [NSString stringWithFormat:@"x%@",@"1"];
    cell.sizeLab.text = [NSString stringWithFormat:@"颜色分类：%@ 尺码：%@",@"红底",@"（80-100斤）160码"];
    cell.cancelBtn.hidden = NO;
    cell.priceBtn.hidden = NO;
    
    cell.reciUserLab.text = [NSString stringWithFormat:@"收货人 : %@",@"张三 13925000003"];
    // 收货地址
    cell.addressLab.text = @"收货地址 : ";
    CGRect a = [MSUStringTools danamicGetHeightFromText:cell.addressLab.text WithWidth:SelfWidth font:14];
    cell.addressLab.frame = CGRectMake(10, 161+5, a.size.width, a.size.height);
    cell.addressContentLab.text = _addressStr;
    cell.addressContentLab.frame = CGRectMake(CGRectGetMaxX(cell.addressLab.frame), CGRectGetMinY(cell.addressLab.frame), SelfWidth-20-10-a.size.width-10, _aa.size.height);
    // 留言
    cell.wordsLab.text = _wordsStr;
    cell.wordsLab.frame = CGRectMake(10+10+35, CGRectGetMaxY(cell.addressLab.frame)+5, SelfWidth-20-40-10-10, _bb.size.height);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if ([_delegate respondsToSelector:@selector(cellDidSelct)]) {
    //        [_delegate cellDidSelct];
    //    }
}


@end
