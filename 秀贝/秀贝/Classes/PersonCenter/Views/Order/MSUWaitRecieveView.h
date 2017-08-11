//
//  MSUWaitRecieveView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSUWaitRecieveViewDelegate <NSObject>

- (void)cellDidSelct;
- (void)returnBtnClick;

@end

@interface MSUWaitRecieveView : UIView

@property (nonatomic , assign) id<MSUWaitRecieveViewDelegate> delegate;


@end
