//
//  MSUCommentTextTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUCommentTextTableCell.h"

@implementation MSUCommentTextTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.commentLab = [[UILabel alloc] init];
    _commentLab.font = [UIFont systemFontOfSize:12];
    _commentLab.textColor = [UIColor blackColor];
    [self addSubview:_commentLab];
    
}

@end
