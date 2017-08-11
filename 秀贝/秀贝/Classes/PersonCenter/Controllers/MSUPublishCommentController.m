//
//  MSUPublishCommentController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/10.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPublishCommentController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"

#import "MSUPublishView.h"

#import "MSUStringTools.h"
#import "MSUPathTools.h"

@interface MSUPublishCommentController ()<UITextViewDelegate>

@property (nonatomic , strong) MSUPublishView *publish ;
/// 输入框
@property (nonatomic , strong) UITextView *textView;
@property (nonatomic , strong) UILabel *splaceLab;

@end

@implementation MSUPublishCommentController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:19];
    [self.view addSubview:nav];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    bgView.backgroundColor = BGLINECOLOR;
    [self.view addSubview:bgView];
    
    self.publish = [[MSUPublishView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 175)];
    [bgView addSubview:_publish];
    _publish.nickLab.text = @"叶叶叶叶叶子";
    _publish.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect rect = [MSUStringTools danamicGetHeightFromText:_publish.shopNameLab.text WithWidth:WIDTH font:16];
    _publish.shopNameLab.frame = CGRectMake(95, 4, WIDTH-105-10-10, rect.size.height);
    _publish.timeLab.text = @"交易成功实践：2017-07-28 14：21";

    
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 175, WIDTH, 160);
    navView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:navView];
    
    self.textView = [[UITextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textColor = [UIColor grayColor];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor =  BGLINECOLOR.CGColor;
    _textView.delegate = self;
    [navView addSubview:_textView];
    [_textView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.top).offset(5);
        make.left.equalTo(self.view.left).offset(10);
        make.width.equalTo(WIDTH-20);
        make.height.equalTo(100);
    }];
    
    self.splaceLab = [[UILabel alloc] init];
    _splaceLab.text = @"宝贝满足你的期待么";
    _splaceLab.textColor = [UIColor grayColor];
    _splaceLab.font = [UIFont systemFontOfSize:14];
    [_textView addSubview:_splaceLab];
    [_splaceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.top).offset(5);
        make.left.equalTo(_textView.left).offset(10);
        make.width.equalTo(150);
        make.height.equalTo(20);
    }];
    
    UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"location_back_icon"] forState:UIControlStateNormal];
    privateBtn.backgroundColor = [UIColor whiteColor];
    privateBtn.adjustsImageWhenHighlighted = NO;
    [navView addSubview:privateBtn];
    [privateBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.bottom).offset(5);
        make.left.equalTo(_textView.left).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame = CGRectMake(0, HEIGHT-50-64, WIDTH, 50);
    [publishBtn setTitle:@"发表评价" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    publishBtn.backgroundColor = [UIColor redColor];
    publishBtn.adjustsImageWhenHighlighted = NO;
    [bgView addSubview:publishBtn];

    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    _splaceLab.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    if (_textView.text.length > 0) {
        _splaceLab.hidden = YES;
    }else{
        _splaceLab.hidden =  NO;
    }
}

@end
