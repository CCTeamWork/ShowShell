//
//  MSUCommentView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUCommentView.h"

#define SelfWidth self.frame.size.width
//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUCommentView

- (instancetype)initWithFrame:(CGRect)frame tableViewHeight:(CGFloat)height
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithHeight:height];
        
    }
    return self;
}


- (void)createViewWithHeight:(CGFloat)height{
    // 标题 评论
    self.titLab = [[UILabel alloc] init];
    _titLab.font = [UIFont systemFontOfSize:16];
    _titLab.textColor = [UIColor blackColor];
    [self addSubview:_titLab];
    [_titLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(SelfWidth-15);
        make.height.equalTo(20);
    }];

    
    // tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, SelfWidth, height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.rowHeight = height*0.5 ;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    // 查看全部评价
    self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allBtn.backgroundColor = [UIColor blueColor];
    [_allBtn setTitle:@"查看全部评价" forState:UIControlStateNormal];
    [_allBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_allBtn];
    [_allBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.bottom).offset(10);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(30);
    }];

}

@end
