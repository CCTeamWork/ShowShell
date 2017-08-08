//
//  MSUMineShopView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSUMineShopViewDelegate <NSObject>

- (void)pushBtnClick;

@end

@interface MSUMineShopView : UIView

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) id<MSUMineShopViewDelegate>delegate;

@end
