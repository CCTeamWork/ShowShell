//
//  MSURefuncPopView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/11.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSURefuncPopView : UIView

@property (nonatomic , strong) NSMutableArray *btnArr;


- (instancetype)initWithFrame:(CGRect)frame popHeight:(CGFloat)popHeight arr:(NSArray *)arr;

@end
