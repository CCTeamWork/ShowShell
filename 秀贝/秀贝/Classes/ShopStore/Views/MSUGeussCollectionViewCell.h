//
//  MSUGeussCollectionViewCell.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/27.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUGeussCollectionViewCell : UICollectionViewCell

/// 商品图片
@property (nonatomic,strong)UIImageView *iconIma;

/// 商品名称
@property (nonatomic,strong)UILabel *shopLab;

/// 价格
@property (nonatomic , strong) UILabel *priceLab;

@end
