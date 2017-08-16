//
//  MSUHomeCollectionCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/20.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUHomeCollectionCell.h"
#import "MSUPrefixHeader.pch"

@implementation MSUHomeCollectionCell

/* 视频页面 */
- (UIImageView *)imageView{
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] init];
       [self.contentView addSubview:_imageView];
        _imageView.backgroundColor = CyanColor;
        [_imageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(0);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(self.contentView.frame.size.width);
            make.height.equalTo(self.contentView.frame.size.height-28);
        }];
    }
    return _imageView;
}

/* 头像页面 */
- (UIImageView *)iconImage{
    if (!_iconImage) {
        self.iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = HEXCOLOR(0xf7d721);
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_iconImage];
        _iconImage.layer.cornerRadius = 25 * 0.5;
        _iconImage.layer.shouldRasterize = YES;
        _iconImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [_iconImage makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.bottom).offset(1.5);
            make.left.equalTo(_imageView.left).offset(5);
            make.width.equalTo(25);
            make.height.equalTo(25);
        }];
    }
    return _iconImage;
}

/* 昵称 */
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
//        _titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:12];
        _titleLabel.textColor = HEXCOLOR(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:12];
//        _titleLabel.backgroundColor = [UIColor yellowColor];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_iconImage.centerY).offset(0);
            make.left.equalTo(_iconImage.right).offset(5);
            make.width.equalTo(12*6+5);
            make.height.equalTo(30);
        }];
    }
    return _titleLabel;
}

/* 头像昵称点击按钮 */
- (UIButton *)publisherBtn{
    if (!_publisherBtn) {
        _publisherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _publisherBtn.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_publisherBtn];
        [_publisherBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.bottom).offset(3);
            make.left.equalTo(_imageView.left).offset(0);
            make.width.equalTo(self.contentView.frame.size.width * 0.5);
            make.height.equalTo(36);
        }];
    }
    return _publisherBtn;
}

/* 点赞数 */
- (UILabel *)likeNumLab{
    if (!_likeNumLab) {
        self.likeNumLab = [[UILabel alloc] init];
        _likeNumLab.font = [UIFont systemFontOfSize:10];
        _likeNumLab.textColor = HEXCOLOR(0x757575);
//        _likeNumLab.backgroundColor = [UIColor redColor];
        _likeNumLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_likeNumLab];
//        [_likeNumLab makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_imageView.bottom).offset(5);
//            make.right.equalTo(self.contentView.right).offset(-5);
//            make.width.equalTo(40);
//            make.height.equalTo(30);
//        }];
    }
    return _likeNumLab;
}

/* 点赞 */
- (UIButton *)likeBtn{
    if (!_likeBtn) {
        self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _likeBtn.backgroundColor = [UIColor blueColor];
        [_likeBtn setImage:[UIImage imageNamed:@"home-unlike"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"home-like"] forState:UIControlStateSelected];
        [self.contentView addSubview:_likeBtn];
        [_likeBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.bottom).offset(8);
            make.right.equalTo(_likeNumLab.left).offset(-5);
            make.width.equalTo(13);
            make.height.equalTo(12);
        }];
    }
    return _likeBtn;
}



@end
