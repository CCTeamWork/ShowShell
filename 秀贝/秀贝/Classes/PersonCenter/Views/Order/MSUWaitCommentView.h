//
//  MSUWaitCommentView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSUWaitCommentViewDelegate <NSObject>

- (void)commentBtnClick;

- (void)cellDidSelct;

@end

@interface MSUWaitCommentView : UIView

@property (nonatomic , assign) id<MSUWaitCommentViewDelegate> delegate;

@end
