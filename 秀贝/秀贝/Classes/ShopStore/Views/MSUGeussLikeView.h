//
//  MSUGeussLikeView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUGeussLikeView : UIView

/// collectionView
@property (nonatomic , strong) UICollectionView *collectionView;

// 初始化
- (instancetype)initWithFrame:(CGRect)frame imageCount:(NSInteger)count;

@end
