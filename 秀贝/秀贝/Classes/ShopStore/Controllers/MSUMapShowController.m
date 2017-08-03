//
//  MSUMapShowController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/8/1.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUMapShowController.h"
#import "MSUHomeNavView.h"
#import "MSUMapAnnotationView.h"
#import "MSUPaoPaoPopView.h"
#import "MSUPopTableCell.h"

/// 工具类
#import "MSUPrefixHeader.pch"

/// 百度地图类
//#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>
//#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationService.h>
//#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
//#import <BaiduMapAPI_Search/BMKPoiSearchType.h>
#import <BaiduMapAPI/BMapKit.h>


@interface MSUMapShowController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKSuggestionSearchDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isFirstLocation;
}

@property(nonatomic,strong)BMKMapView* mapView;
@property(nonatomic,strong)BMKLocationService* locService;
@property(nonatomic,strong)BMKGeoCodeSearch* geocodesearch;
@property (nonatomic , strong) BMKSuggestionSearch *searcher;

@property(nonatomic,strong)UITableView *tableView;
//数据源
@property (nonatomic , strong) NSMutableArray *dataList;
@property (nonatomic , strong) NSMutableArray *cityList;
@property (nonatomic , strong) NSMutableArray *districtList;

@property(nonatomic,assign)CLLocationCoordinate2D currentCoordinate;
@property (nonatomic , copy)NSString *cityName;

@property(nonatomic,strong)UIImageView *centerCallOutImageView;
@property(nonatomic,strong)UIButton *currentLocationBtn;

/// 搜索框按钮
@property (nonatomic , strong) UISearchBar *search;

@end

@implementation MSUMapShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:10];
    [self.view addSubview:nav];
    
    [self createSearchBar];
    
    // 地图视图
    [self createMapAbout];
    [self startLocation];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, WIDTH, HEIGHT-108) style:UITableViewStylePlain];
    _tableView.backgroundColor = YELLOWCOLOR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
    self.geocodesearch.delegate = self;
    self.searcher.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
    self.geocodesearch.delegate = nil;
    self.searcher.delegate = nil;
}

- (void)dealloc{
    if (_mapView){
        _mapView = nil;
    }
    if (_geocodesearch){
        _geocodesearch = nil;
    }
    if (_locService){
        _locService=nil;
    }
}

-(void)setCurrentCoordinate:(CLLocationCoordinate2D)currentCoordinate{
    _currentCoordinate=currentCoordinate;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = currentCoordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

#pragma mark - 视图相关
- (void)createSearchBar{
    /// 搜索框
    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 44)];
    _search.placeholder =  @"搜索感兴趣的内容";
    _search.searchBarStyle = UISearchBarStyleMinimal;
    _search.backgroundImage = [self imageWithColor:WHITECOLOR size:_search.bounds.size];
    _search.delegate = self;
    [self.view addSubview:_search];

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

/* 地图视图相关 */
- (void)createMapAbout{
    // mapView
    [self.view addSubview:self.mapView];
    [self.mapView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(108);
        make.left.equalTo(self.view.left).offset(0);
        make.width.equalTo(WIDTH);
        make.height.equalTo(HEIGHT-108);
    }];
    
    // 隐藏百度地图logo
    UIView *mView = _mapView.subviews.firstObject;
    for (id logoView in mView.subviews)
    {
        if ([logoView isKindOfClass:[UIImageView class]])
        {
            UIImageView *b_logo = (UIImageView*)logoView;
            b_logo.hidden = YES;
        }
    }

    
    // 小标注
    [self.view addSubview: self.centerCallOutImageView];
    [self.view bringSubviewToFront:self.centerCallOutImageView];
    [self.centerCallOutImageView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.mapView);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    [self.mapView layoutIfNeeded];

    // 左下角标记
    self.currentLocationBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.currentLocationBtn setImage:[UIImage imageNamed:@"location_back_icon"] forState:UIControlStateNormal];
    [self.currentLocationBtn setImage:[UIImage imageNamed:@"location_blue_icon"] forState:UIControlStateSelected];
    [self.currentLocationBtn addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.currentLocationBtn];
    [self.view bringSubviewToFront:self.currentLocationBtn];
    [self.currentLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(50, 50));
        make.bottom.equalTo(self.mapView.bottom).offset(-10);
        make.left.equalTo(self.view.left).offset(10);
    }];
}

-(void)startLocation
{
    isFirstLocation = YES;//首次定位
    self.currentLocationBtn.selected = YES;
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
    [self.locService startUserLocationService];
}


#pragma mark - 代理方法相关
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_search resignFirstResponder];
}

/* 搜索框代理 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText && searchText.length>0) {
        self.tableView.hidden = NO;
    }else{
        self.tableView.hidden = YES;
    }
    
    BMKSuggestionSearchOption *option = [[BMKSuggestionSearchOption alloc] init];
    option.keyword = searchText;
    option.cityname = self.cityName;
    NSLog(@"城市---%@",self.cityName);
    BOOL flag = [self.searcher suggestionSearch:option];
    if(flag)
    {
        NSLog(@"建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_search resignFirstResponder];
}

/**
 *在地图View将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
    //    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    isFirstLocation=NO;
    self.currentLocationBtn.selected=NO;
    [self.mapView  updateLocationData:userLocation];
    self.currentCoordinate = userLocation.location.coordinate;
    NSLog(@"坐标坐标坐标 %f %f",_currentCoordinate.latitude,_currentCoordinate.longitude);
    
    if (self.currentCoordinate.latitude!=0)
    {
        [self.locService stopUserLocationService];
    }
    
    BMKPointAnnotation *point1 = [[BMKPointAnnotation alloc]init];
    point1.coordinate = self.currentCoordinate;
    point1.title = @"北京";
    [self.mapView addAnnotation:point1];
    [_mapView selectAnnotation:point1 animated:YES];
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    
}

/* maoView 相关 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"map view: click blank");
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!isFirstLocation)
    {
        CLLocationCoordinate2D tt =[mapView convertPoint:self.centerCallOutImageView.center toCoordinateFromView:self.centerCallOutImageView];
        self.currentCoordinate=tt;
    }
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    BMKAnnotationView *annotationView=[[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    annotationView.calloutOffset = CGPointMake(0, -15);
//    BMKPinAnnotationView *annotationView=[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//    annotationView.animatesDrop = YES;
    
    MSUMapAnnotationView *anno = [[MSUMapAnnotationView alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
    anno.layer.cornerRadius = 8;
    anno.backgroundColor = [UIColor whiteColor];
//    anno.layer.contents =(id)[UIImage imageNamed:@"pao.png"].CGImage;//这张图片是做好的透明
    anno.annoNickLab.text = @"迪凯银座";
    [anno.annoAddBtn setTitle:@"杭州市江干区解放东路嘻米哈" forState:UIControlStateNormal];
    BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc] initWithCustomView:anno];
    annotationView.paopaoView = paopao;
    
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"点击了标注");
}

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    NSLog(@"点击了气泡");
    MSUPaoPaoPopView *paoPaoPopView = [[MSUPaoPaoPopView alloc] initWithFrame:CGRectMake(20, 64+25, WIDTH-40, HEIGHT-64-25-25)];
    paoPaoPopView.backgroundColor = [UIColor orangeColor];
    paoPaoPopView.locaLab.text = @"迪凯银座";
    paoPaoPopView.popTablView.delegate = self;
    paoPaoPopView.popTablView.dataSource = self;
    paoPaoPopView.popTablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:paoPaoPopView];
    [paoPaoPopView.closeBtn addTarget:self action:@selector(paopaoViewClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - BMKGeoCodeSearchDelegate
/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        if (!isFirstLocation)
        {
            self.mapView.centerCoordinate = result.location;
//            self.mapView.center =  [_mapView convertCoordinate:result.location toPointToView:_mapView];
            BMKPointAnnotation *point1 = [[BMKPointAnnotation alloc]init];
            point1.coordinate = result.location;
            point1.title = @"北京";
            [self.mapView addAnnotation:point1];
            [_mapView selectAnnotation:point1 animated:YES];
        }
    }
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        if (!isFirstLocation)
        {
            self.cityName = result.addressDetail.city;
        }
    }
}

- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"成功");
        self.dataList = [NSMutableArray arrayWithArray:result.keyList];
        self.cityList = [NSMutableArray arrayWithArray:result.cityList];
        self.districtList = [NSMutableArray arrayWithArray:result.districtList];

        [self.tableView reloadData];
    }else{
        NSLog(@"失败");
    }
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return self.dataList.count;
    } else {
        return 6;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        return 30;
    } else {
        return 155;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        static NSString *cellID = @"poiCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        if (self.dataList && self.dataList.count>0) {
            cell.textLabel.text = self.dataList[indexPath.row];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",self.cityList[indexPath.row],self.districtList[indexPath.row]];
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }
        
        return cell;
    } else {
        static NSString *cellID = @"paoPopCell";
        MSUPopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[MSUPopTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID popHeight:WIDTH-40-20];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.iconIma.image = [UIImage imageNamed:@"icon-z"];
        cell.nickLab.text = @"叶叶叶叶叶子";
        cell.introLab.text = @"美食重度爱好者666666";
        
        return cell;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        [_search resignFirstResponder];
        _search.text = @"";
        _tableView.hidden = YES;
        
        BMKGeoCodeSearchOption *option = [[BMKGeoCodeSearchOption alloc] init];
        option.city = self.cityList[indexPath.row];
        option.address = self.dataList[indexPath.row];
        BOOL flag = [_geocodesearch geoCode:option];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }
    }
    
}

#pragma mark - 点击事件
- (void)paopaoViewClick:(UIButton *)sender{
    [sender.superview removeFromSuperview];
}

#pragma mark - 初始化
-(BMKMapView*)mapView{
    if (_mapView==nil)
    {
        _mapView =[[BMKMapView alloc] init];
        _mapView.zoomEnabled=NO;
        _mapView.zoomEnabledWithTap=NO;
        _mapView.zoomLevel=17;
    }
    return _mapView;
}

-(BMKLocationService*)locService{
    if (_locService==nil)
    {
        _locService = [[BMKLocationService alloc]init];
    }
    return _locService;
}

-(BMKGeoCodeSearch*)geocodesearch{
    if (_geocodesearch==nil)
    {
        _geocodesearch=[[BMKGeoCodeSearch alloc]init];
    }
    return _geocodesearch;
}

- (BMKSuggestionSearch *)searcher{
    if (_searcher == nil) {
        _searcher = [[BMKSuggestionSearch alloc] init];
    }
    return _searcher;
}

-(UIImageView*)centerCallOutImageView
{
    if (_centerCallOutImageView==nil)
    {
        _centerCallOutImageView=[UIImageView new];
        [_centerCallOutImageView setImage:[UIImage imageNamed:@"location_green_icon"]];
    }
    return _centerCallOutImageView;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        self.dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
