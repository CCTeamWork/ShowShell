//
//  MSUSellerWaitPayTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/11.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSellerWaitPayTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGLINECOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@implementation MSUSellerWaitPayTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rowHeight:(CGFloat)rowHeight{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentViewWithHeight:rowHeight];
    }
    return self;
}

- (void)createContentViewWithHeight:(CGFloat)height{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(height);
    }];
    
    // 头像
    self.iconIma = [[UIImageView alloc] init];
    _iconIma.backgroundColor = [UIColor redColor];
    _iconIma.layer.cornerRadius = 15;
    _iconIma.layer.shouldRasterize = YES;
    _iconIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _iconIma.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:_iconIma];
    [_iconIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(5);
        make.left.equalTo(bgView.left).offset(5);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
    
    // 昵称
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    //    _nickLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconIma.centerY).offset(0);
        make.left.equalTo(_iconIma.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(30);
    }];
    
    // 状态
    self.statusLab = [[UILabel alloc] init];
    //    _statusLab.backgroundColor = [UIColor yellowColor];
    _statusLab.font = [UIFont systemFontOfSize:14];
    _statusLab.textColor = [UIColor orangeColor];
    _statusLab.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:_statusLab];
    [_statusLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconIma.centerY).offset(0);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(30);
    }];
    
    // 商品图片
    self.shopIma = [[UIImageView alloc] init];
    //    _shopIma.layer.cornerRadius = 15;
    //    _shopIma.layer.shouldRasterize = YES;
    //    _shopIma.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _shopIma.contentMode = UIViewContentModeScaleAspectFit;
    _shopIma.backgroundColor = [UIColor redColor];
    [bgView addSubview:_shopIma];
    [_shopIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconIma.bottom).offset(10);
        make.left.equalTo(bgView.left).offset(5);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.numberOfLines = 0;
    [bgView addSubview:_shopNameLab];
    
    // 规格 颜色等
    self.sizeLab = [[UILabel alloc] init];
    _sizeLab.font = [UIFont systemFontOfSize:10];
    _sizeLab.textColor = [UIColor grayColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [bgView addSubview:_sizeLab];
    [_sizeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopNameLab.bottom).offset(3);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(SelfWidth-105-20);
        make.height.equalTo(20);
    }];
    
    
    CGFloat labWid = SelfWidth -20 - 5-80-10;
    // 价格
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:16];
    _priceLab.textColor = [UIColor blackColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [bgView addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(0);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(labWid*2/3);
        make.height.equalTo(20);
    }];
    
    // 数量
    self.numLab = [[UILabel alloc] init];
    _numLab.font = [UIFont systemFontOfSize:14];
    _numLab.textAlignment = NSTextAlignmentRight;
    //    _numLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(0);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BGLINECOLOR;
    [bgView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopIma.bottom).offset(5);
        make.left.equalTo(bgView.left).offset(5);
        make.width.equalTo(SelfWidth-30);
        make.height.equalTo(1);
    }];
    
    // 收货人
    self.reciUserLab = [[UILabel alloc] init];
    _reciUserLab.font = [UIFont systemFontOfSize:14];
    //    _numLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_reciUserLab];
    [_reciUserLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(10);
        make.left.equalTo(bgView.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(20);
    }];
    
    // 收货地址
    self.addressLab = [[UILabel alloc] init];
    _addressLab.font = [UIFont systemFontOfSize:14];
    //    _numLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_addressLab];

    self.addressContentLab = [[UILabel alloc] init];
    _addressContentLab.font = [UIFont systemFontOfSize:14];
    _addressContentLab.numberOfLines = 0;
    //    _numLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_addressContentLab];
    
    // 留言
    UILabel *seeLab = [[UILabel alloc] init];
    seeLab.text = @"留言 : ";
    seeLab.textColor = [UIColor blackColor];
    seeLab.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:seeLab];
    [seeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressContentLab.bottom).offset(5);
        make.left.equalTo(_addressLab.left).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(16);
    }];
    
    self.wordsLab = [[UILabel alloc] init];
    _wordsLab.font = [UIFont systemFontOfSize:14];
    _wordsLab.numberOfLines = 0;
    //    _numLab.backgroundColor = [UIColor brownColor];
    [bgView addSubview:_wordsLab];
    
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = BGLINECOLOR;
    [bgView addSubview:line1View];
    [line1View makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wordsLab.bottom).offset(10);
        make.left.equalTo(bgView.left).offset(5);
        make.width.equalTo(SelfWidth-30);
        make.height.equalTo(1);
    }];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _cancelBtn.backgroundColor = [UIColor redColor];
    _cancelBtn.adjustsImageWhenHighlighted = NO;
    _cancelBtn.layer.cornerRadius = 3;
    _cancelBtn.layer.shouldRasterize = YES;
    _cancelBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [bgView addSubview:_cancelBtn];
    [_cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1View.bottom).offset(7.5);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(25);
    }];
    _cancelBtn.hidden = YES;
    
    
    self.priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_priceBtn setTitle:@"修改价格" forState:UIControlStateNormal];
    [_priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _priceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _priceBtn.backgroundColor = BGLINECOLOR;
    _priceBtn.adjustsImageWhenHighlighted = NO;
    _priceBtn.layer.cornerRadius = 3;
    _priceBtn.layer.shouldRasterize = YES;
    _priceBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:_priceBtn];
    [_priceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cancelBtn.top).offset(0);
        make.right.equalTo(_cancelBtn.left).offset(-30);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];
    _priceBtn.hidden = YES;
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendBtn setTitle:@"发货" forState:UIControlStateNormal];
    [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _sendBtn.backgroundColor = [UIColor redColor];
    _sendBtn.adjustsImageWhenHighlighted = NO;
    _sendBtn.layer.cornerRadius = 3;
    _sendBtn.layer.shouldRasterize = YES;
    _sendBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [bgView addSubview:_sendBtn];
    [_sendBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1View.bottom).offset(7.5);
        make.right.equalTo(bgView.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(25);
    }];
    _sendBtn.hidden = YES;
    
    
    self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_orderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _orderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _orderBtn.backgroundColor = BGLINECOLOR;
    _orderBtn.adjustsImageWhenHighlighted = NO;
    _orderBtn.layer.cornerRadius = 3;
    _orderBtn.layer.shouldRasterize = YES;
    _orderBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:_orderBtn];
    [_orderBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendBtn.top).offset(0);
        make.right.equalTo(_sendBtn.left).offset(-30);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];
    _priceBtn.hidden = YES;
    
}

@end
