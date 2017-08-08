//
//  MSUPushSetController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/8.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUPushSetController.h"
#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUPushSetTopView.h"
#import "MSUPushSetCenterView.h"
#import "MSUPickPopView.h"

#import "MSUStringTools.h"

@interface MSUPushSetController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic , strong) UIView *shadowView;
@property (nonatomic , strong) MSUPickPopView *pickView;

@end

@implementation MSUPushSetController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:17];
    [self.view addSubview:nav];
    
    [self createContentView];
    
    UIButton *privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    privateBtn.frame = CGRectMake(0, HEIGHT-50, WIDTH, 50);
    [privateBtn setTitle:@"保存" forState:UIControlStateNormal];
    [privateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    privateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    privateBtn.backgroundColor = [UIColor redColor];
    privateBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:privateBtn];
    
}

- (void)createContentView{
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64-50);
    navView.backgroundColor = BGLINECOLOR;
    [self.view addSubview:navView];
    
    MSUPushSetTopView *topView = [[MSUPushSetTopView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 130)];
    [navView addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    topView.shopNameLab.text = @"天青色等烟雨，而我在等你；炊烟袅袅升起，隔江千万里!";
    CGRect hotRect = [MSUStringTools danamicGetHeightFromText:topView.shopNameLab.text WithWidth:(WIDTH-30) font:16];
    topView.shopNameLab.frame = CGRectMake(10+80+10, 10, WIDTH-20-(10+80+10), hotRect.size.height);
    topView.priceLab.text = [NSString stringWithFormat:@"¥%@",@"88.80"];
    
    MSUPushSetCenterView *centerView = [[MSUPushSetCenterView alloc] initWithFrame:CGRectMake(0,130, WIDTH, HEIGHT-64-130-50)];
    [navView addSubview:centerView];
    [centerView.leftTimeBtn addTarget:self action:@selector(leftTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerView.rightTimeBtn addTarget:self action:@selector(leftTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}


#pragma mark - 点击事件
- (void)leftTimeBtnClick:(UIButton *)sender{
    self.shadowView.hidden = NO;
    self.pickView.hidden = NO;
}

- (void)cancelBtnClick:(UIButton *)sender{
    self.shadowView.hidden = YES;
}

- (void)sureBtnClick:(UIButton *)sender{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.pickView];
    if (![_pickView.layer containsPoint:point]) {
        self.shadowView.hidden = YES;
    }
}

#pragma mark - 初始化
- (UIView *)shadowView{
    if (!_shadowView) {
        self.shadowView = [[UIView alloc] initWithFrame:self.view.bounds];
        _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:_shadowView];
        _shadowView.hidden = YES;
    }
    return _shadowView;
}

- (MSUPickPopView *)pickView{
    if (!_pickView) {
        self.pickView = [[MSUPickPopView alloc] initWithFrame:CGRectMake(30, 128, WIDTH-60, HEIGHT-128-128) text:@"请选择日期"];
        _pickView.backgroundColor = [UIColor whiteColor];
        [self.shadowView addSubview:_pickView];
        _pickView.picker.delegate = self;
        _pickView.picker.dataSource = self;
        [_pickView.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_pickView.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pickView;
}

#pragma mark - 代理
/* pickerView的代理 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return 10;
    }else if (component == 1){
        return 12;
    }else{
        return 31;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return @"年年";
    }else if (component == 1){
        return @"月月";
    }else{
        return @"日日";
    }

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [_pickView.picker reloadComponent: 0];
    } else {
        
    }
}

@end
