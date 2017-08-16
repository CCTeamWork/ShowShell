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

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "MSUPathTools.h"

@implementation MSUSearchCollectionCell

- (UILabel *)hotLab{
    if (!_hotLab) {
        self.hotLab = [[UILabel alloc] init];
//        _hotLab.backgroundColor = [UIColor redColor];
        _hotLab.font = [UIFont systemFontOfSize:14];
        _hotLab.textColor = HEXCOLOR(0x333333);
        [self.contentView addSubview:_hotLab];
     
    }
    return _hotLab;
}

- (UIImageView *)hotIma{
    if (!_hotIma) {
        self.hotIma = [[UIImageView alloc] init];
//        _hotIma.backgroundColor = [UIColor brownColor];
        _hotIma.image = [MSUPathTools showImageWithContentOfFileByName:@"search-hot"];
        _hotIma.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_hotIma];
        [_hotIma makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.top).offset(12.5);
            make.left.equalTo(_hotLab.right).offset(13);
            make.width.equalTo(22);
            make.height.equalTo(13);
        }];
        _hotIma.hidden = YES;
    }
    return _hotIma;
}

@end
