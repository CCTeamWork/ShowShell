//
//  MSUAddAddressTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUAddAddressTableCell.h"


@implementation MSUAddAddressTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.cellLab = [[UILabel alloc] init];
    _cellLab.frame = CGRectMake(10, 0, 100, 49);
    _cellLab.textColor = [UIColor blackColor];
    _cellLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_cellLab];

    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(10, 49, [UIScreen mainScreen].bounds.size.width-20, 1);
    navView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [self addSubview:navView];

}

@end
