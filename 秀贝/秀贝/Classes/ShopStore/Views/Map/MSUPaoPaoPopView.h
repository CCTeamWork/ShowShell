//
//  MSUPaoPaoPopView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/2.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUPaoPaoPopView : UIView

/* 地名名称 */
@property (nonatomic , strong) UILabel *locaLab;

/* 列表 */
@property (nonatomic , strong) UITableView *popTablView;

/* 关闭按钮 */
@property (nonatomic , strong) UIButton *closeBtn;

@end
