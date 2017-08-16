//
//  MSUCollectBGView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUCollectBGView.h"
#import "MSUSearchCollectionCell.h"
#import "MSUPathTools.h"

#define SelfWidth self.frame.size.width
#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface MSUCollectBGView()<UICollectionViewDelegateFlowLayout>

@end

@implementation MSUCollectBGView

- (instancetype)initWithFrame:(CGRect)frame tableHeight:(CGFloat)height
{
    if (self = [super initWithFrame:frame]) {
        
        [self createViewWithHeight:height];
        
    }
    return self;
}


- (void)createViewWithHeight:(CGFloat)height{
    // 表格初始化
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    [layOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    layOut.itemSize = CGSizeMake(SelfWidth * 0.5-0.5, 35);
    // 列间距
    layOut.minimumInteritemSpacing = 1;
    // 行间距
    layOut.minimumLineSpacing = 1;
    // 四边距
    //    layOut.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, SelfWidth, 107) collectionViewLayout:layOut];
    _collectionView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:241/255.0 alpha:1.0];
    _collectionView.scrollsToTop = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    [_collectionView registerClass:[MSUSearchCollectionCell class] forCellWithReuseIdentifier:@"searchCollectionCell"];
    [self addSubview:_collectionView];
    
    // 换一换 按钮
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _changeBtn.backgroundColor = HEXCOLOR(0x80f7d721);
    _changeBtn.layer.cornerRadius = 5;
    _changeBtn.layer.shouldRasterize = YES;
    _changeBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _changeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_changeBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"like"] forState:UIControlStateNormal];
    _changeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [_changeBtn setTitle:@"换一换" forState:UIControlStateNormal];
    [_changeBtn setTitleColor:HEXCOLOR(0x757575) forState:UIControlStateNormal];
    _changeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _changeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [self addSubview:_changeBtn];
    [_changeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.bottom).offset(20);
        make.left.equalTo(self.left).offset(SelfWidth * 0.5-41);
        make.width.equalTo(82);
        make.height.equalTo(30);
    }];
    
    // 历史搜索列表 167
    self.historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 167+30, SelfWidth, height) style:UITableViewStylePlain];
    _historyTableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _historyTableView.scrollEnabled = NO;
    _historyTableView.rowHeight = 36;
    [self addSubview:_historyTableView];
    
    // 清空记录
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearBtn setTitle:@"清空记录" forState:UIControlStateNormal];
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_clearBtn setTitleColor:HEXCOLOR(0x1c8cee) forState:UIControlStateNormal];
    [self addSubview:_clearBtn];
    [_clearBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_historyTableView.bottom).offset(25);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(30);
    }];

    
}

@end
