//
//  MSUMineShopTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUMineShopTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width

@implementation MSUMineShopTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

// 改变滑动删除按钮样式
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in self.subviews){
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            CGRect cRect = subView.frame;
            cRect.origin.y = self.contentView.frame.origin.y+5;
            cRect.size.height = self.contentView.frame.size.height - 5;
            subView.frame = cRect;
            
            UIView *confirmView=(UIView *)[subView.subviews firstObject];
            // 改背景颜色
            confirmView.backgroundColor=[UIColor colorWithRed:254/255.0 green:85/255.0 blue:46/255.0 alpha:1];
            for(UIView *sub in confirmView.subviews){
                if([sub isKindOfClass:NSClassFromString(@"UIButtonLabel")]){
                    UILabel *deleteLabel=(UILabel *)sub;
                    // 改删除按钮的字体
                    deleteLabel.font=[UIFont boldSystemFontOfSize:15];
                    // 改删除按钮的文字
                    deleteLabel.text=@"删除";
                }
            }
            break;
        }
    }
}

- (void)createContentView{
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor whiteColor];
    [self addSubview:navView];
    [navView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(90);
    }];

    
    // 商品图片
    self.shopIma = [[UIImageView alloc] init];
    _shopIma.contentMode = UIViewContentModeScaleAspectFit;
    _shopIma.backgroundColor = [UIColor redColor];
    [navView addSubview:_shopIma];
    [_shopIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.top).offset(5);
        make.left.equalTo(navView.left).offset(5);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    // 商品名字
    self.shopNameLab = [[UILabel alloc] init];
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    _shopNameLab.numberOfLines = 0;
    [navView addSubview:_shopNameLab];
    
    CGFloat labWid = SelfWidth -20 - 5-80-10;
    // 价格
    self.priceLab = [[UILabel alloc] init];
    _priceLab.font = [UIFont systemFontOfSize:16];
    //    _priceLab.textColor = [UIColor redColor];
    //    _priceLab.backgroundColor = [UIColor blackColor];
    [navView addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIma.bottom).offset(3);
        make.left.equalTo(_shopIma.right).offset(10);
        make.width.equalTo(labWid*0.5);
        make.height.equalTo(20);
    }];
    
    // 设置推广
    self.pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pushBtn setTitle:@"设置推广" forState:UIControlStateNormal];
    [_pushBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _pushBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _pushBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _pushBtn.layer.borderWidth = 1;
    _pushBtn.layer.cornerRadius = 2;
    _pushBtn.layer.shouldRasterize = YES;
    _pushBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _pushBtn.backgroundColor = [UIColor whiteColor];
    _pushBtn.adjustsImageWhenHighlighted = NO;
    [navView addSubview:_pushBtn];
    [_pushBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(navView.bottom).offset(-5);
        make.right.equalTo(navView.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(20);
    }];
    _pushBtn.hidden = YES;
    
    // 再次推广
    self.againPushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_againPushBtn setTitle:@"再次推广" forState:UIControlStateNormal];
    [_againPushBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _againPushBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _againPushBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _againPushBtn.layer.borderWidth = 1;
    _againPushBtn.layer.cornerRadius = 2;
    _againPushBtn.layer.shouldRasterize = YES;
    _againPushBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _againPushBtn.backgroundColor = [UIColor whiteColor];
    _againPushBtn.adjustsImageWhenHighlighted = NO;
    [navView addSubview:_againPushBtn];
    [_againPushBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(navView.bottom).offset(-5);
        make.right.equalTo(navView.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(20);
    }];
    _againPushBtn.hidden = YES;
    
    // 再次推广
    self.againPushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_againPushBtn setTitle:@"再次推广" forState:UIControlStateNormal];
    [_againPushBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _againPushBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _againPushBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _againPushBtn.layer.borderWidth = 1;
    _againPushBtn.layer.cornerRadius = 2;
    _againPushBtn.layer.shouldRasterize = YES;
    _againPushBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _againPushBtn.backgroundColor = [UIColor whiteColor];
    _againPushBtn.adjustsImageWhenHighlighted = NO;
    [navView addSubview:_againPushBtn];
    [_againPushBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(navView.bottom).offset(-5);
        make.right.equalTo(navView.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(20);
    }];
    _againPushBtn.hidden = YES;
    
    // 总佣金
    self.yongjinLab = [[UILabel alloc] init];
    _yongjinLab.font = [UIFont systemFontOfSize:16];
    _yongjinLab.textAlignment = NSTextAlignmentRight;
    _yongjinLab.textColor = [UIColor orangeColor];
    [navView addSubview:_yongjinLab];
    [_yongjinLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(navView.bottom).offset(-5);
        make.right.equalTo(navView.right).offset(-10);
        make.width.equalTo(120);
        make.height.equalTo(20);
    }];
    _yongjinLab.hidden = YES;
    
    self.yongjinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _yongjinBtn.backgroundColor = [UIColor clearColor];
    _yongjinBtn.adjustsImageWhenHighlighted = NO;
    [_yongjinLab addSubview:_yongjinBtn];
    [_yongjinBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(navView.bottom).offset(-5);
        make.right.equalTo(navView.right).offset(-10);
        make.width.equalTo(120);
        make.height.equalTo(20);
    }];
    _yongjinBtn.hidden = YES;
    
    self.mineImaView = [[UIImageView alloc] init];
    _mineImaView.image = nil;
    _mineImaView.alpha = 0.5;
    _mineImaView.backgroundColor = [UIColor orangeColor];
    _mineImaView.layer.cornerRadius = 25;
    _mineImaView.layer.shouldRasterize = YES;
    _mineImaView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [navView addSubview:_mineImaView];
    [_mineImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.top).offset(10);
        make.right.equalTo(navView.right).offset(-10);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    _mineImaView.hidden = YES;



}

@end
