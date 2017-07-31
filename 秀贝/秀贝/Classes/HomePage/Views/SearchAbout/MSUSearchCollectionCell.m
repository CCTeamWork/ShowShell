//
//  MSUSearchCollectionCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/28.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUSearchCollectionCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUPathTools.h"

@implementation MSUSearchCollectionCell

- (UILabel *)hotLab{
    if (!_hotLab) {
        self.hotLab = [[UILabel alloc] init];
//        _hotLab.backgroundColor = [UIColor redColor];
        _hotLab.font = [UIFont systemFontOfSize:14];
        _hotLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_hotLab];
     
    }
    return _hotLab;
}

- (UIImageView *)hotIma{
    if (!_hotIma) {
        self.hotIma = [[UIImageView alloc] init];
//        _hotIma.backgroundColor = [UIColor brownColor];
        _hotIma.image = [MSUPathTools showImageWithContentOfFileByName:@"like"];
        _hotIma.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_hotIma];
        [_hotIma makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.top).offset(12.5);
            make.left.equalTo(_hotLab.right).offset(10);
            make.width.equalTo(20);
            make.height.equalTo(15);
        }];
        _hotIma.hidden = YES;
    }
    return _hotIma;
}

@end
