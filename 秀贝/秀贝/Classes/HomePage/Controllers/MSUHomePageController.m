//
//  MSUHomePageController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUHomePageController.h"
#import "MSUScanController.h"
#import "MSULocationController.h"
#import "MSUSearchController.h"
#import "AppDelegate.h"

/* 视图类 */
#import "MSUHomeNavView.h"

/* 工具类 */
#import "MSUPrefixHeader.pch"
#import "MSUPermissionTool.h"

/* 地图框架 */
#import <CoreLocation/CoreLocation.h>
#import "TQLocationConverter.h"
#import "ZCChinaLocation.h"

@interface MSUHomePageController ()<CLLocationManagerDelegate>

/// 定位
@property (nonatomic , strong) CLLocationManager *locationManager;
/// 得到当前位置的经纬度
@property (nonatomic , assign) CLLocationCoordinate2D curCoordinate2D;

@property (nonatomic , strong) MSUHomeNavView *navView;

@end

@implementation MSUHomePageController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 背景颜色
//    self.view.backgroundColor = NavColor;
    self.view.backgroundColor = [UIColor orangeColor];
    [self locationInit];

    // 导航栏
    [self createNavView];
    // 中部视图
    [self createCenterView];
}

#pragma mark - 视图相关
/// 导航栏视图
- (void)createNavView{
    self.navView = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:0];
//    nav.backgroundColor = NavColor;
    _navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    // 点击事件
    [_navView.scanBtn addTarget:self action:@selector(scanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.LocationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.homeSearchBtn addTarget:self action:@selector(homeSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

/// 中部视图
- (void)createCenterView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    navView.backgroundColor = CyanColor;
    [self.view addSubview:navView];
}

/// 定位初始化
- (void)locationInit{
    NSLog(@"定位初始化");
    //定位管理器
    self.locationManager=[[CLLocationManager alloc]init];
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined ){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        //        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance = 100;
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
        
        //重大位置变化通知
//        [_locationManager startMonitoringSignificantLocationChanges];
    }
}

#pragma mark - 点击事件相关
/* 扫描点击事件 */
- (void)scanBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUScanController *scan = [[MSUScanController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

/* 城市定位点击事件 */
- (void)locationBtnClick:(UIButton *)sender{
    [MSUPermissionTool getLocationPermission:NO result:^(NSInteger authStatus) {
        if (authStatus == 1 || authStatus == 0) {
            self.hidesBottomBarWhenPushed = YES;
            MSULocationController *location = [[MSULocationController alloc] init];
            location.locationCityBlock = ^(NSString *locaCity) {
                [_navView.LocationBtn setTitle:locaCity forState:UIControlStateNormal];
            };
            [self presentViewController:location animated:YES completion:nil];
            self.hidesBottomBarWhenPushed = NO;
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 定位服务 - 秀贝] 打开访问开关" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //确定按钮点击事件处理
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

/* 搜索点击事件 */
- (void)homeSearchBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUSearchController *search = [[MSUSearchController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 代理方法相关
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currentLoction = [locations lastObject];
    /// 得到当前位置的经纬度
    self.curCoordinate2D = currentLoction.coordinate;
//    NSLog(@"定位直接得到的坐标===%f  %f",_curCoordinate2D.latitude,_curCoordinate2D.longitude);
    [self.locationManager stopUpdatingLocation];

    /// 判断当前坐标是否在中国
    BOOL isChina = [[ZCChinaLocation shared] isInsideChina:(CLLocationCoordinate2D){_curCoordinate2D.latitude,_curCoordinate2D.longitude}];
    if (isChina) {
        /// 转换坐标 不转换会出现偏移
        _curCoordinate2D = [TQLocationConverter transformFromWGSToGCJ:_curCoordinate2D];
        
        //获得地理位置名字
        [self googleMapAddress];
    }

}

// 获得地理位置名字
- (NSString *)googleMapAddress{
    __block NSString *addressStr;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:_curCoordinate2D.latitude longitude:_curCoordinate2D.longitude];
//    NSLog(@"转换后得到的坐标===%f  %f",_curCoordinate2D.latitude,_curCoordinate2D.longitude);

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            addressStr = @"";
            NSLog(@"获取定理位置失败");
        }else{
            addressStr = [placemarks firstObject].locality;
//            NSLog(@"------------ %@",addressStr);
            NSString *locationCity = [addressStr substringWithRange:NSMakeRange(0, 2) ];
            [_navView.LocationBtn setTitle:locationCity forState:UIControlStateNormal];
            
            //存储city  用以判断下次app进入city默认显示值
            [[NSUserDefaults standardUserDefaults] setObject:locationCity forKey:@"city"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    return addressStr;
}

@end
