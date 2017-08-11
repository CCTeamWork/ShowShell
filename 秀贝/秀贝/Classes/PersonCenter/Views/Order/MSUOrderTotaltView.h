//
//  MSUOrderContentView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/9.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSUOrderTotaltViewDelegate <NSObject>

- (void)cellDidSelct;

@end

@interface MSUOrderTotaltView : UIView

@property (nonatomic , assign) id<MSUOrderTotaltViewDelegate> delegate;


@end
