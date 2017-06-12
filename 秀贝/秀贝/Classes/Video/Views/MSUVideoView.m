//
//  MSUVideoView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUVideoView.h"
#import "MSUPrefixHeader.pch"
#import "MSUImageTools.h"

@implementation MSUVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    /// imageview
    UIImageView *videoIma = [[UIImageView alloc] init];
    videoIma.image = [MSUImageTools showImageWithContentOfFileByName:@"FoSe.jpeg"];
    [self addSubview:videoIma];
    [videoIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(WIDTH-40);
        make.height.equalTo((HEIGHT-64-44)/3);
    }];
    
    /// 按钮
    self.pageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pageBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_pageBtn];
    [_pageBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(WIDTH-40);
        make.height.equalTo((HEIGHT-64-44)/3);
    }];

    
    

}

@end
