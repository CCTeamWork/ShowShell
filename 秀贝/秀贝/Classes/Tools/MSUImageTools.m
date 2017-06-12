//
//  MSUImageTools.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/31.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUImageTools.h"

@implementation MSUImageTools


/// NSBundle版加载图片
+ (UIImage *)showImageWithContentOfFileByName:(NSString *)imageName {
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],imageName ];
    return [UIImage imageWithContentsOfFile:path];
}

@end
