//
//  MSUWaitPayView.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSUWaitPayViewDelegate <NSObject>

- (void)cellDidSelct;

@end

@interface MSUWaitPayView : UIView

@property (nonatomic , assign) id<MSUWaitPayViewDelegate> delegate;


@end
