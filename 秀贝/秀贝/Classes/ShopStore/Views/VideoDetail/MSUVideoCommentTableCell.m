//
//  MSUVideoCommentTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUVideoCommentTableCell.h"
#import "MSUCommentTextTableCell.h"

#import "MSUStringTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define CommentTableWidth SelfWidth-28-36-5

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MSUVideoCommentTableCell()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MSUVideoCommentTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView{
    // 头像
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.layer.cornerRadius = 18;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(36);
        make.height.equalTo(36);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:13];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [self addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(_iconBtn.right).offset(5);
        make.width.equalTo(SelfWidth * 0.5);
        make.height.equalTo(10);
    }];
    
    // 评论
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentBtn setImage:[UIImage imageNamed:@"state-comment"] forState:UIControlStateNormal];
    _commentBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_commentBtn];
    [_commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.top).offset(0);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(12.5);
        make.height.equalTo(12.5);
    }];
    
    // 点赞
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    _likeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_likeBtn];
    [_likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.top).offset(0);
        make.right.equalTo(_commentBtn.left).offset(-20);
        make.width.equalTo(12.5);
        make.height.equalTo(12.5);
    }];
    
    
    // 正文
    self.commentLab = [[UILabel alloc] init];
    [_commentLab setTextColor:HEXCOLOR(0x333333)];
    //    _timeLab.backgroundColor = [UIColor redColor];
    _commentLab.font = [UIFont systemFontOfSize:11];
    _commentLab.numberOfLines = 0;
    [self addSubview:_commentLab];
    
    self.lineView = [[UIView alloc] init];
    _lineView.backgroundColor = HEXCOLOR(0xf4f4f4);
    [self addSubview:_lineView];
    
    self.commentTableView = [[UITableView alloc] init];
    _commentTableView.backgroundColor = HEXCOLOR(0xf4f4f4);
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    [self addSubview:_commentTableView];
    _commentTableView.scrollEnabled = NO;
    _commentTableView.userInteractionEnabled = NO;
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_commentTableView registerClass:[MSUCommentTextTableCell class] forCellReuseIdentifier:@"commentText1Cell"];
    [_commentTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentLab.bottom).offset(0);
        make.left.equalTo(_commentLab.left).offset(0);
        make.width.equalTo(CommentTableWidth);
        make.height.equalTo(5+30+5);
    }];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CommentTableWidth, 5)];
    view.backgroundColor = HEXCOLOR(0xf4f4f4);
    _commentTableView.tableHeaderView = view;
    _commentTableView.tableFooterView = view;
    
}

//- (void)configCellWithModel:(MessageModel *)model indexPath:(NSIndexPath *)indexPath{
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUCommentTextTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentText1Cell"];
    cell.backgroundColor = HEXCOLOR(0xf4f4f4);
    
    cell.commentLab.text = @"妞妞：对呀，想和大宝宝一起去旅游！";
    CGRect comnmentRect = [MSUStringTools danamicGetHeightFromText:cell.commentLab.text WithWidth:SelfWidth font:10];
    cell.commentLab.frame = CGRectMake(10, 0, CommentTableWidth-20, comnmentRect.size.height);

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
