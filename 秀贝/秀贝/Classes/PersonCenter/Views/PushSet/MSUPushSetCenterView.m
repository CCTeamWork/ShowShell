//
//  MSUPushSetCenterView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/8.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPushSetCenterView.h"
#import "MSUStringTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define BGColor [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

#define CenterMargin 20

@interface MSUPushSetCenterView()
@property (nonatomic , strong) UIView *contenBGView;

@property (nonatomic , assign) CGFloat legalHeight;

@end

@implementation MSUPushSetCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    // 条款内容和宽高
    NSString *str = @"● 商家ID、购买ID和推广ID一致时不计入推广分成。";
    CGRect rect = [MSUStringTools danamicGetHeightFromText:str WithWidth:SelfWidth font:10];
    NSString *str1 = @"● 推广分成结算周期默认为15天。(结算交易成功的订单)";
    CGRect rect1 = [MSUStringTools danamicGetHeightFromText:str1 WithWidth:SelfWidth font:10];
    NSString *str2 = @"● 分配方式:按照设置的规则，佣金达成交易的分享ID和视频ID进行分配。";
    CGRect rect2 = [MSUStringTools danamicGetHeightFromText:str2 WithWidth:SelfWidth font:10];
    NSString *str3 = @"● 推广佣金将直接在商品成交金额中进行抵扣。";
    CGRect rect3 = [MSUStringTools danamicGetHeightFromText:str3 WithWidth:SelfWidth font:10];
    
    self.legalHeight = rect.size.height + rect1.size.height + rect2.size.height + rect3.size.height;
    
    self.contenBGView = [[UIView alloc] init];
    _contenBGView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contenBGView];
    [_contenBGView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(251+_legalHeight+25);
    }];

    
    // 第一条背景线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BGColor;
    [_contenBGView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(5);
    }];
    
    // 推广佣金
    UILabel *pushLab = [[UILabel alloc] init];
    pushLab.text = @"推广佣金";
    pushLab.textAlignment = NSTextAlignmentRight;
    pushLab.textColor = [UIColor blackColor];
    pushLab.font = [UIFont systemFontOfSize:16];
    [_contenBGView addSubview:pushLab];
    [pushLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(70);
        make.height.equalTo(30);
    }];
    
    // 固定分成按钮
    self.regularBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_regularBtn setTitle:@"固定分成" forState:UIControlStateNormal];
    [_regularBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _regularBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _regularBtn.backgroundColor = [UIColor redColor];
    _regularBtn.adjustsImageWhenHighlighted = NO;
    [_contenBGView addSubview:_regularBtn];
    [_regularBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pushLab.top).offset(2.5);
        make.left.equalTo(pushLab.right).offset(CenterMargin);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];

//    self.scaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_scaleBtn setTitle:@"比例分成" forState:UIControlStateNormal];
//    [_scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_scaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    _scaleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    _scaleBtn.backgroundColor = BGColor;
//    _scaleBtn.adjustsImageWhenHighlighted = NO;
//    [self addSubview:_scaleBtn];
//    [_scaleBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(pushLab.top).offset(0);
//        make.left.equalTo(_regularBtn.right).offset(10);
//        make.width.equalTo(70);
//        make.height.equalTo(20);
//    }];
    
    // 视频佣金
    UILabel *videoLab = [[UILabel alloc] init];
    videoLab.text = @"视频佣金";
    videoLab.textColor = [UIColor blackColor];
    videoLab.textAlignment = NSTextAlignmentRight;
    videoLab.font = [UIFont systemFontOfSize:14];
    [_contenBGView addSubview:videoLab];
    [videoLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pushLab.bottom).offset(10);
        make.left.equalTo(pushLab.left).offset(0);
        make.width.equalTo(70);
        make.height.equalTo(20);
    }];
    
    // 视频佣金的分成金额
    self.videoTF = [[UITextField alloc] init];
    _videoTF.placeholder = @"分成金额";
    _videoTF.font = [UIFont systemFontOfSize:14];
    _videoTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _videoTF.leftViewMode = UITextFieldViewModeAlways;
    _videoTF.layer.borderColor = BGColor.CGColor;
    _videoTF.layer.borderWidth = 1;
    [_contenBGView addSubview:_videoTF];
    [_videoTF makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(videoLab.centerY).offset(0);
        make.leftMargin.equalTo(videoLab.right).offset(CenterMargin);
        make.width.equalTo(80);
        make.height.equalTo(25);
    }];

    // 元
    UILabel *yuanLab = [[UILabel alloc] init];
    yuanLab.text = @"元";
    yuanLab.textColor = [UIColor blackColor];
    yuanLab.font = [UIFont systemFontOfSize:14];
    [_contenBGView addSubview:yuanLab];
    [yuanLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(videoLab.top).offset(0);
        make.left.equalTo(_videoTF.right).offset(10);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
    // 疑问号
    self.askBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _askBtn.backgroundColor = [UIColor blueColor];
     _askBtn.adjustsImageWhenHighlighted = NO;
    [_contenBGView addSubview:_askBtn];
    [_askBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(videoLab.top).offset(0);
        make.left.equalTo(yuanLab.right).offset(CenterMargin);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
    // 分享佣金
    UILabel *shareLab = [[UILabel alloc] init];
    shareLab.text = @"分享佣金";
    shareLab.textColor = [UIColor blackColor];
    shareLab.textAlignment = NSTextAlignmentRight;
    shareLab.font = [UIFont systemFontOfSize:14];
    [_contenBGView addSubview:shareLab];
    [shareLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(videoLab.bottom).offset(10);
        make.left.equalTo(videoLab.left).offset(0);
        make.width.equalTo(70);
        make.height.equalTo(20);
    }];
    
    // 分享佣金的分成金额
    self.shareTF = [[UITextField alloc] init];
    _shareTF.placeholder = @"分成金额";
    _shareTF.font = [UIFont systemFontOfSize:14];
    _shareTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _shareTF.leftViewMode = UITextFieldViewModeAlways;
    _shareTF.layer.borderColor = BGColor.CGColor;
    _shareTF.layer.borderWidth = 1;
    [_contenBGView addSubview:_shareTF];
    [_shareTF makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shareLab.centerY).offset(0);
        make.left.equalTo(_videoTF.left).offset(0);
        make.width.equalTo(80);
        make.height.equalTo(25);
    }];
    
    // 元
    UILabel *yuan1Lab = [[UILabel alloc] init];
    yuan1Lab.text = @"元";
    yuan1Lab.textColor = [UIColor blackColor];
    yuan1Lab.font = [UIFont systemFontOfSize:14];
    [_contenBGView addSubview:yuan1Lab];
    [yuan1Lab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareLab.top).offset(0);
        make.left.equalTo(_shareTF.right).offset(10);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];

    // 佣金总计
    UILabel *totalLab = [[UILabel alloc] init];
    totalLab.text = @"佣金总计";
    totalLab.textColor = [UIColor blackColor];
    totalLab.textAlignment = NSTextAlignmentRight;
    totalLab.font = [UIFont systemFontOfSize:14];
    [_contenBGView addSubview:totalLab];
    [totalLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareLab.bottom).offset(10);
        make.left.equalTo(shareLab.left).offset(0);
        make.width.equalTo(70);
        make.height.equalTo(20);
    }];
    
    // 佣金总计的金额
    self.totalMoneyLab = [[UILabel alloc] init];
    _totalMoneyLab.text = [NSString stringWithFormat:@"%@元",@"2000"];
    _totalMoneyLab.textColor = [UIColor blackColor];
    _totalMoneyLab.font = [UIFont systemFontOfSize:14];
    [_contenBGView addSubview:_totalMoneyLab];
    [_totalMoneyLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalLab.top).offset(0);
        make.left.equalTo(_shareTF.left).offset(0);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
    
    // 第二条背景线
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = BGColor;
    [_contenBGView addSubview:line1View];
    [line1View makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalLab.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(1);
    }];
    
    // 推广时效
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.text = @"推广时效";
    timeLab.textAlignment = NSTextAlignmentRight;
    timeLab.textColor = [UIColor blackColor];
    timeLab.font = [UIFont systemFontOfSize:16];
    [_contenBGView addSubview:timeLab];
    [timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1View.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(70);
        make.height.equalTo(30);
    }];
    
    // 长期有效按钮
    self.longBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_longBtn setTitle:@"长期有效" forState:UIControlStateNormal];
    [_longBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_longBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _longBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _longBtn.backgroundColor = BGColor;
    _longBtn.adjustsImageWhenHighlighted = NO;
    [_contenBGView addSubview:_longBtn];
    [_longBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLab.centerY).offset(0);
        make.left.equalTo(timeLab.right).offset(CenterMargin);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];
    [_longBtn addTarget:self action:@selector(longBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 自定义按钮
    self.diyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_diyBtn setTitle:@"自定义" forState:UIControlStateNormal];
    [_diyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_diyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _diyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _diyBtn.backgroundColor = [UIColor orangeColor];
    _diyBtn.adjustsImageWhenHighlighted = NO;
    [_contenBGView addSubview:_diyBtn];
    [_diyBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLab.centerY).offset(0);
        make.left.equalTo(_longBtn.right).offset(CenterMargin);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];
    _diyBtn.selected = YES;
    [_diyBtn addTarget:self action:@selector(diyBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    // 时间背景视图
    self.timeBgView = [[UIView alloc] init];
    _timeBgView.backgroundColor = [UIColor whiteColor];
    [_contenBGView addSubview:_timeBgView];
    [_timeBgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_longBtn.bottom).offset(20);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(25);
    }];

    // 左侧时间按钮
    self.leftTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftTimeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _leftTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _leftTimeBtn.layer.borderWidth = 1;
    _leftTimeBtn.layer.borderColor = BGColor.CGColor;
    _leftTimeBtn.adjustsImageWhenHighlighted = NO;
    [_timeBgView addSubview:_leftTimeBtn];
    [_leftTimeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeBgView.top).offset(0);
        make.left.equalTo(_longBtn.left).offset(0);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];
    
    // 间隔符 -
    UILabel *bridgeLab = [[UILabel alloc] init];
    bridgeLab.text = @"-";
    bridgeLab.textColor = [UIColor grayColor];
    bridgeLab.textAlignment = NSTextAlignmentCenter;
    bridgeLab.font = [UIFont systemFontOfSize:16];
    [_timeBgView addSubview:bridgeLab];
    [bridgeLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftTimeBtn.centerY).offset(0);
        make.left.equalTo(_leftTimeBtn.right).offset(5);
        make.width.equalTo(20);
        make.height.equalTo(25);
    }];
    
    // 右侧时间按钮
    self.rightTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightTimeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _rightTimeBtn.layer.borderWidth = 1;
    _rightTimeBtn.layer.borderColor = BGColor.CGColor;
    _rightTimeBtn.adjustsImageWhenHighlighted = NO;
    [_timeBgView addSubview:_rightTimeBtn];
    [_rightTimeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftTimeBtn.top).offset(0);
        make.left.equalTo(bridgeLab.right).offset(5);
        make.width.equalTo(70);
        make.height.equalTo(25);
    }];
    
    
    // 条款背景视图
    self.legalBgView = [[UIView alloc] init];
    _legalBgView.backgroundColor = [UIColor whiteColor];
    [_contenBGView addSubview:_legalBgView];
    [_legalBgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_longBtn.bottom).offset(65);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(_legalHeight+25);
    }];
    
    
    UILabel *legalLab = [[UILabel alloc] init];
    legalLab.text = str;
    legalLab.textColor = [UIColor blackColor];
    legalLab.numberOfLines = 0;
    legalLab.font = [UIFont systemFontOfSize:10];
    [_legalBgView addSubview:legalLab];
    [legalLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_legalBgView.top).offset(0);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(rect.size.height);
    }];
    
    UILabel *legal1Lab = [[UILabel alloc] init];
    legal1Lab.text = str1;
    legal1Lab.textColor = [UIColor blackColor];
    legal1Lab.numberOfLines = 0;
    legal1Lab.font = [UIFont systemFontOfSize:10];
    [_legalBgView addSubview:legal1Lab];
    [legal1Lab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(legalLab.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(rect1.size.height);
    }];
    
    UILabel *legalLab2 = [[UILabel alloc] init];
    legalLab2.text = str2;
    legalLab2.textColor = [UIColor blackColor];
    legalLab2.numberOfLines = 0;
    legalLab2.font = [UIFont systemFontOfSize:10];
    [_legalBgView addSubview:legalLab2];
    [legalLab2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(legal1Lab.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(rect2.size.height);
    }];
    
    UILabel *legalLab3 = [[UILabel alloc] init];
    legalLab3.text = str3;
    legalLab3.textColor = [UIColor blackColor];
    legalLab3.numberOfLines = 0;
    legalLab3.font = [UIFont systemFontOfSize:10];
    [_legalBgView addSubview:legalLab3];
    [legalLab3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(legalLab2.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(SelfWidth-20);
        make.height.equalTo(rect3.size.height);
    }];
    
}

- (void)longBtnClick:(UIButton *)sender{
    sender.selected = YES;
    sender.backgroundColor = [UIColor redColor];

    _diyBtn.backgroundColor = BGColor;
    _diyBtn.selected = NO;
    
    _timeBgView.hidden = YES;
    [self.legalBgView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_longBtn.bottom).offset(20);
    }];
    
    [self.contenBGView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(251 - 45 + _legalHeight+25);
    }];


}

- (void)diyBtnClick:(UIButton *)sender{
    sender.selected = YES;
    sender.backgroundColor = [UIColor redColor];
    
    _longBtn.backgroundColor = BGColor;
    _longBtn.selected = NO;
    
    _timeBgView.hidden = NO;
    [self.legalBgView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_longBtn.bottom).offset(65);
    }];

    [self.contenBGView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(251+_legalHeight+25);
    }];
    
}

@end
