//
//  MSUShopSelectView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUShopSelectView : UIView

/// 购买按钮
@property (nonatomic , strong) UIButton *buyBtn;

/// 取消按钮
@property (nonatomic , strong) UIButton *cancelBtn;

/// 商品列表
@property (nonatomic , strong) UITableView *seleTableView;

@end
