//
//  MSUHomeNavView.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"

@implementation MSUHomeNavView

- (instancetype)initWithFrame:(CGRect)frame showNavWithNumber:(NSInteger)number
{
    if (self = [super initWithFrame:frame]) {
        switch (number) {
            case 0:
            {
                /// 首页导航栏
                [self createHomePageNavView];
            }
                break;
            case 1:
            {
                /// 扫描导航栏
                [self createScanNavView];
            }
                break;
            case 2:
            {
                /// 定位城市导航栏
                [self createLocationNavView];
            }
                break;
            case 3:
            {
                /// 视频导航栏
                [self createVideoNavView];
            }
                break;
            case 4:
            {
                /// 搜索导航栏
                [self createSerachNavView];
            }
                break;
            case 5:
            {
                /// 播放器导航栏
                [self createPlayerNavView];
            }
                break;
            case 6:
            {
                /// 动态页面
                [self createDanamicWithTittle:@"动态"];
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

#pragma mark - 首页的导航视图
- (void)createHomePageNavView{
    NSString *city;
    //取出存值，判断是否第一次进入 如果第一次进入 city默认为上海 ；如果不是第一次进入 city为上次定位位置
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"city"]) {
        city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    }else{
        city = @"上海";
    }
    // 定位按钮
    self.LocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _LocationBtn.backgroundColor = [UIColor whiteColor];
    [_LocationBtn setTitle:city forState:UIControlStateNormal];
    _LocationBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:_LocationBtn];
//    [_LocationBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_LocationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(17);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(80);
        make.height.equalTo(20);
    }];
    
    // 中部标识
    UIImageView *logoIma = [[UIImageView alloc] init];
    logoIma.image = [UIImage imageNamed:@"logo"];
    logoIma.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logoIma];
    [logoIma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(7);
        make.left.equalTo(self.left).offset(WIDTH * 0.5 - 50);
        make.width.equalTo(100);
        make.height.equalTo(30);
    }];

    // 扫描按钮
    self.scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_scanBtn setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    [self addSubview:_scanBtn];
    [_scanBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(7);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
    
    // 搜索按钮
    self.homeSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_homeSearchBtn setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
    [self addSubview:_homeSearchBtn];
    [_homeSearchBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(7);
        make.right.equalTo(_scanBtn.left).offset(-10);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
}

#pragma mark - 扫描页面的导航视图
- (void)createScanNavView{
    // 左箭头
    self.arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _arrowBtn.backgroundColor = [UIColor blueColor];
    [self addSubview:_arrowBtn];
    [_arrowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(7);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(20);
        make.height.equalTo(30);
    }];
    
    // 扫描二维码
    UILabel *scanLab = [[UILabel alloc] init];
    scanLab.text = @"扫描二维码";
    scanLab.font = [UIFont systemFontOfSize:20];
    scanLab.textAlignment = NSTextAlignmentCenter;
    [scanLab setTextColor:WHITECOLOR];
    [self addSubview:scanLab];
    [scanLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(WIDTH * 0.5 - 60);
        make.width.equalTo(120);
        make.height.equalTo(34);
    }];
    
    // 相册
    self.photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_photoBtn];
    [_photoBtn setTitle:@"相册" forState:UIControlStateNormal];
    _photoBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_photoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(7);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(40);
        make.height.equalTo(30);
    }];
}

#pragma mark - 视频页面导航图
- (void)createVideoNavView{
    NSArray *textArr = @[@"推荐",@"热门",@"十三香",@"十三香",@"十三香",@"十三香",@"十三香",@"十三香",@"十三香",@"十三香"];
    
    /// 线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, WIDTH, 1)];
    lineView.backgroundColor = TEXTCOLOR;
    [self addSubview:lineView];
    
    /// 滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(5 + (50 + 10) * textArr.count, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(WIDTH - 30);
        make.height.equalTo(44);
    }];

    /// 文字按钮
    for (NSInteger i = 0; i < textArr.count; i++) {
        self.titBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        titBtn.frame = CGRectMake(5 + (50 + 10)*i, 0, 50, 55);
        [_titBtn setTitle:textArr[i] forState:UIControlStateNormal];
        _titBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_titBtn setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        [scrollView addSubview:_titBtn];
        [_titBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scrollView.top).offset(0);
            make.left.equalTo(scrollView.left).offset(5 + (50 + 10) * i);
            make.width.equalTo(50);
            make.height.equalTo(44);
        }];
    }
    
    /// 搜索按钮
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
    [self addSubview:_searchBtn];
    [_searchBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.top).offset(0);
        make.left.equalTo(scrollView.right).offset(0);
        make.width.equalTo(30);
        make.height.equalTo(44);
    }];
}

#pragma mark - 定位导航图
- (void)createLocationNavView{
    /// 选择城市
    UILabel *cityLab = [[UILabel alloc] init];
    cityLab.text = @"选择城市";
    cityLab.font = [UIFont systemFontOfSize:20];
    [cityLab setTextColor:WHITECOLOR];
    [self addSubview:cityLab];
    [cityLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(WIDTH * 0.5 - 60);
        make.width.equalTo(120);
        make.height.equalTo(34);
    }];
    
    /// 取消按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_cancelBtn];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(7);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(40);
        make.height.equalTo(30);
    }];
}

#pragma mark - 搜索框视图
- (void)createSerachNavView{
    /// 搜索框
//    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 0, WIDTH-10-60, 44)];
//    _search.placeholder =  @"请搜索输入";
//    _search.searchBarStyle = UISearchBarStyleMinimal;
//    _search.backgroundImage = [self imageWithColor:WHITECOLOR size:_search.bounds.size];
//    [self addSubview:_search];
    
    
    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 3, WIDTH-10-60, 38)];
    _search.placeholder =  @"搜索商品、视频";
    _search.backgroundImage = [self imageWithColor:WHITECOLOR size:_search.bounds.size];
    _search.layer.borderColor = NavColor.CGColor;
    _search.layer.borderWidth = 2;
    _search.layer.cornerRadius = 7;
    _search.clipsToBounds = YES;
    [self addSubview:_search];
    
    /// 取消按钮
    self.searchCancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_searchCancleBtn];
    [_searchCancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    _searchCancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_searchCancleBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(_search.right).offset(5);
        make.width.equalTo(40);
        make.height.equalTo(44);
    }];

}

/** 搜索框背景图片的封装方法 */
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect recte = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(recte.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, recte);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 视频播放页面的导航视图
- (void)createPlayerNavView{
    // 左箭头
    self.arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _arrowBtn.backgroundColor = [UIColor blueColor];
    [self addSubview:_arrowBtn];
    [_arrowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(7);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(20);
        make.height.equalTo(30);
    }];
    
    // 扫描二维码
    UILabel *videoLab = [[UILabel alloc] init];
    videoLab.text = @"视频播放";
    videoLab.font = [UIFont systemFontOfSize:20];
    videoLab.textAlignment = NSTextAlignmentCenter;
    [videoLab setTextColor:WHITECOLOR];
    [self addSubview:videoLab];
    [videoLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(WIDTH * 0.5 - 60);
        make.width.equalTo(120);
        make.height.equalTo(34);
    }];
}

#pragma mark - 动态
- (void)createDanamicWithTittle:(NSString *)tittle{
    UILabel *titeleLab = [[UILabel alloc] init];
    titeleLab.text = tittle;
    titeleLab.font = [UIFont systemFontOfSize:20];
    [titeleLab setTextColor:[UIColor whiteColor]];
    [self addSubview:titeleLab];
    [titeleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(WIDTH * 0.5 - 25);
        make.width.equalTo(50);
        make.height.equalTo(44);
    }];

    
    // 搜索按钮
    self.homeSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_homeSearchBtn setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
    [self addSubview:_homeSearchBtn];
    [_homeSearchBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(7);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
}

@end
