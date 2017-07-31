//
//  MSUCollectBGView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUCollectBGView : UIView

/// collectionView
@property (nonatomic , strong) UICollectionView *collectionView;

/// 换一批
@property (nonatomic , strong) UIButton *changeBtn;

/// 历史搜索列表
@property (nonatomic , strong) UITableView *historyTableView;

/// 清空记录
@property (nonatomic , strong) UIButton *clearBtn;

/* 初始化 */
- (instancetype)initWithFrame:(CGRect)frame tableHeight:(CGFloat)height;

@end
