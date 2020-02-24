//
//  GFMapViewController.m
//  GFMap_2
//
//  Created by 陈光法 on 16/1/28.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFMapViewController.h"
#import <UIKit/UIKit.h>
#import "GFHttpTool.h"


// 百度地图类库
#import <BaiduMapAPI_Base/BMKMapManager.h>
//#import "BMKMapManager.h"
#import <BMKLocationKit/BMKLocationManager.h>

#import <BaiduMapAPI_Map/BMKMapView.h>
//#import "BMKMapView.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
//#import "BMKPoiSearch.h"
#import "GFAnnotationView.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "AppDelegate.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
    
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end
//#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface GFMapViewController () <BMKMapViewDelegate, BMKShareURLSearchDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,BMKRouteSearchDelegate,BMKLocationManagerDelegate,UIAlertViewDelegate> {

    NSInteger num;
    UILabel *_distanceLabel;
    UILabel *_timeLabel;
    UIView *_baseView;
    BMKRouteSearch *_routesearch;
}


// 地图管理者
@property(nonatomic, strong) BMKMapManager *mapManager;

// 定位
@property(nonatomic, strong) BMKLocationManager *locationService;







@end

@implementation GFMapViewController

- (GFAnnotation *)bossPointAnno{
    if (_bossPointAnno == nil) {
        self.bossPointAnno = [[GFAnnotation alloc] init];
    }
    return _bossPointAnno;
}

- (void)viewDidLoad {
    
//    FirstViewController *first = [[FirstViewController alloc]init];
//    [self presentViewController:first animated:YES completion:nil];
    
//    self.view.backgroundColor = [UIColor cyanColor];
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
    
//    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 410, self.view.frame.size.width-40, 40)];
    [self.view addSubview:_distanceLabel];
//    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 450, self.view.frame.size.width-40, 40)];
    [self.view addSubview:_timeLabel];
    // 基础设置
    [self _setBase];

    // 创建地图管理者
//    [self _setMapManager];
    
    // 添加地图
    [self _setMapView];
    
    // 进行定位
    [self _setLocationService];
    
    // 添加大头针
    [self _setAnnonation];
    
    _routesearch = [[BMKRouteSearch alloc] init];
    _routesearch.delegate = self;
}

#pragma mark - ***** 基础设置 *****
- (void)_setBase {
    
        num = 0;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 80, 60)];
//    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:_first action:@selector(firstBackClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
//    button = [[UIButton alloc]init];
//    button.frame = CGRectMake(100, 50, 120, 40);
//    button.backgroundColor = [UIColor cyanColor];
//    [button setTitle:@"搜索" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
}
-(void)backClick{
//    NSLog(@"出栈啦");
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - ***** 管理者 *****
- (void)_setMapManager {
    
//    self.mapManager = [[BMKMapManager alloc] init];
//    BOOL ret = [self.mapManager start:@"qQxUcaGNCZfeFmhB8EHWVvgt" generalDelegate:nil];
//    if(ret == YES) {
//        NSLog(@"打开成功");
//    }else {
//        NSLog(@"打开失败");
//    }
}

#pragma mark - ***** 定位 *****
- (void)_setLocationService {
    
    self.locationService = [[BMKLocationManager alloc] init];
    /* 设定代理 */
    // 开启定位
    [self.locationService startUpdatingLocation];
    self.locationService.allowsBackgroundLocationUpdates = NO;
    self.locationService.pausesLocationUpdatesAutomatically = YES;
    
}






#pragma mark - ***** 地图 *****
- (void)_setMapView {
//    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width - 20, 350)];
    self.mapView = [[BMKMapView alloc]init];
    
    /* 设定代理 */
    self.mapView.delegate = self;
    
    UIView *mapView = _mapView.subviews[0];
    [mapView.subviews[mapView.subviews.count-1] removeFromSuperview];
    
    [self.view addSubview:self.mapView];
    
    [self.mapView setMapType:BMKMapTypeStandard];   // 地图类型
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;  // 跟随模式
//    self.mapView.zoomLevel = 10;    // 缩放比例
    [_mapView setZoomLevel:13];
    
}






#pragma mark - ***** 大头针 *****
- (void)_setAnnonation {
    
    // 技师大头针
    self.workerPointAnno = [[GFAnnotation alloc] init];
    self.workerPointAnno.title = @"我";
//    self.workerPointAnno.subtitle = @"天赐我一个单吧";
    self.workerPointAnno.iconImgName = @"me-1";
    [self.mapView addAnnotation:self.workerPointAnno];
    
    
    // 老板大头针
    
//    self.bossPointAnno.title = @"我是老板";
//    self.bossPointAnno.subtitle = @"派活啦，赶紧抢吧";
//    self.bossPointAnno.coordinate = CLLocationCoordinate2DMake(30.4,114.4);
//    self.bossPointAnno.iconImgName = @"location";
//    self.bossPointAnno.title
    [self.mapView addAnnotation:self.bossPointAnno];
//    NSLog(@"加载地图");
    
    
//#pragma mark - 路径
//    
//    BMKShareURLSearch *shareurlsearch = [[BMKShareURLSearch alloc]init];
//    shareurlsearch.delegate = self;
//    
//    BMKRoutePlanShareURLOption *option = [[BMKRoutePlanShareURLOption alloc] init];
//    BMKPlanNode *fromNode = [[BMKPlanNode alloc] init];
////    fromNode.name = @"百度大厦";
////    fromNode.cityID = 131;
//    fromNode.pt = self.workerPointAnno.coordinate;
//    option.from = fromNode;
//    BMKPlanNode *toNode = [[BMKPlanNode alloc] init];
////    toNode.name = @"天安门";
////    toNode.cityID = 131;
//    toNode.pt = self.bossPointAnno.coordinate;
//    option.to = toNode;
//    option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_WALK;
//    BOOL flag = [shareurlsearch requestRoutePlanShareURL:option];
//    if (flag) {
//        NSLog(@"routePlanShortUrlShare检索发送成功");
//    } else {
//        NSLog(@"routePlanShortUrlShare检索发送失败");
//    }
    
}


//*******************  代理方法  **********************

#pragma mark - ***** 定位代理 *****
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    NSString *dateString = [formatter stringFromDate:location.location.timestamp];
    
    //    NSLog(@"---%@---定位",userLocation.location);
    self.workerPointAnno.coordinate = location.location.coordinate;
//    [self.mapView updateLocationData:userLocation];
//    [self.mapView updateLocationData:location];
    
    
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    float myLocationLat = [appDelegate.locationDictionary[@"lat"] floatValue];
    float myLocationLng = [appDelegate.locationDictionary[@"lng"] floatValue];
    self.workerPointAnno.coordinate = CLLocationCoordinate2DMake(myLocationLat, myLocationLng);
    
    
    
    double a = [self calculatorWithCoordinate1:self.workerPointAnno.coordinate withCoordinate2:self.bossPointAnno.coordinate];
    //    NSLog(@"---技师和客户的距离－－%@--",@(a));
    _distanceLabel.text = [NSString stringWithFormat:@"距离工作地点%0.1fkm",a/1000];
    if (_distanceBlock) {
        _distanceBlock(a);
    }
    _timeLabel.text = [NSString stringWithFormat:@"时间：%@",dateString];
    if(num == 0) {
        self.mapView.centerCoordinate = location.location.coordinate;
        num = 1;
        BMKCoordinateRegion region ;//表示范围的结构体
        region.center = CLLocationCoordinate2DMake((self.workerPointAnno.coordinate.latitude + self.bossPointAnno.coordinate.latitude)/2,(self.workerPointAnno.coordinate.longitude + self.bossPointAnno.coordinate.longitude)/2);//中心点
        region.span.latitudeDelta = (self.workerPointAnno.coordinate.latitude - self.bossPointAnno.coordinate.latitude)*2;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
        region.span.longitudeDelta = (self.workerPointAnno.coordinate.latitude - self.bossPointAnno.coordinate.latitude)*2;//纬度范围
        [_mapView setRegion:region animated:YES];
        //         _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
    }
    
    [self.locationService stopUpdatingLocation];
}


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    NSString *dateString = [formatter stringFromDate:userLocation.location.timestamp];
    
    
    
    //    NSLog(@"---%@---定位",userLocation.location);
    self.workerPointAnno.coordinate = userLocation.location.coordinate;
    [self.mapView updateLocationData:userLocation];
    
    double a = [self calculatorWithCoordinate1:self.workerPointAnno.coordinate withCoordinate2:self.bossPointAnno.coordinate];
//    NSLog(@"---技师和客户的距离－－%@--",@(a));
    _distanceLabel.text = [NSString stringWithFormat:@"距离工作地点%0.1fkm",a/1000];
    if (_distanceBlock) {
        _distanceBlock(a);
    }
    _timeLabel.text = [NSString stringWithFormat:@"时间：%@",dateString];
    if(num == 0) {
        self.mapView.centerCoordinate = userLocation.location.coordinate;
        num = 1;
        BMKCoordinateRegion region ;//表示范围的结构体
        region.center = CLLocationCoordinate2DMake((self.workerPointAnno.coordinate.latitude + self.bossPointAnno.coordinate.latitude)/2,(self.workerPointAnno.coordinate.longitude + self.bossPointAnno.coordinate.longitude)/2);//中心点
        region.span.latitudeDelta = (self.workerPointAnno.coordinate.latitude - self.bossPointAnno.coordinate.latitude)*2;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
        region.span.longitudeDelta = (self.workerPointAnno.coordinate.latitude - self.bossPointAnno.coordinate.latitude)*2;//纬度范围
        [_mapView setRegion:region animated:YES];
//         _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
    }
    
    [self.locationService stopUpdatingLocation];
    
}

#pragma mark - 定位方法，发送定位信息
- (void)startUserLocationService{
    [self.locationService startUpdatingLocation];
    
//    [GFHttpTool PostReportLocation:@{@"positionLon":@(self.workerPointAnno.coordinate.longitude),@"positionLat":@(self.workerPointAnno.coordinate.latitude)} success:^(NSDictionary *responseObject) {
//        NSLog(@"------%@-----%@----",responseObject,responseObject[@"message"]);
//    } failure:^(NSError *error) {
//        NSLog(@"----失败原因----%@---",error);
//    }];
    
    
}

- (void)userLocationService{
    self.bossPointAnno.coordinate = self.workerPointAnno.coordinate;
//    NSLog(@"--------self.work---%@-",self.workerPointAnno.coordinate);
//    self.bossPointAnno.coordinate = CLLocationCoordinate2DMake(self.workerPointAnno.coordinate.longitude,self.workerPointAnno.coordinate.latitude);
    [self.locationService startUpdatingLocation];
}
    
    
#pragma mark - 路径
//    if(num == 1) {
//        BMKShareURLSearch *shareurlsearch = [[BMKShareURLSearch alloc]init];
//        shareurlsearch.delegate = self;
//        
//        BMKRoutePlanShareURLOption *option = [[BMKRoutePlanShareURLOption alloc] init];
//        BMKPlanNode *fromNode = [[BMKPlanNode alloc] init];
//        //    fromNode.name = @"百度大厦";
//        //    fromNode.cityID = 131;
//        fromNode.pt = self.workerPointAnno.coordinate;
//        option.from = fromNode;
//        
//        BMKPlanNode *toNode = [[BMKPlanNode alloc] init];
//        //    toNode.name = @"天安门";
//        //    toNode.cityID = 131;
//        toNode.pt = self.bossPointAnno.coordinate;
//        option.to = toNode;
//        option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_WALK;
//        BOOL flag = [shareurlsearch requestRoutePlanShareURL:option];
//        if (flag) {
//            NSLog(@"routePlanShortUrlShare检索发送成功");
//        } else {
//            NSLog(@"routePlanShortUrlShare检索发送失败");
//        }
//        num = 5;
        
//        BMKRouteSearch *searcher = [[BMKRouteSearch alloc]init];
//        searcher.delegate = self;
        
//        BMKPlanNode *start = [[BMKPlanNode alloc]init];
//        start.pt = self.workerPointAnno.coordinate;
//        BMKPlanNode *end = [[BMKPlanNode alloc]init];
//        end.pt = self.bossPointAnno.coordinate;
//        
//        BMKTransitRoutePlanOption *transit = [[BMKTransitRoutePlanOption alloc]init];
//        transit.from = start;
//        transit.to = end;
//        BOOL flag = [searcher transitSearch:transit];
//        if (flag) {
//            NSLog(@"BUS检索成功");
//        }else{
//            NSLog(@"BUS检索失败");
//        }
        
        
        
//        BMKPlanNode* start = [[BMKPlanNode alloc]init];
//        start.pt = self.workerPointAnno.coordinate;
//        BMKPlanNode* end = [[BMKPlanNode alloc]init];
//        end.pt = self.bossPointAnno.coordinate;
//        
//        
//        BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
//        walkingRouteSearchOption.from = start;
//        walkingRouteSearchOption.to = end;
//        BOOL flag = [searcher walkingSearch:walkingRouteSearchOption];
//        if(flag)
//        {
//            NSLog(@"walk检索发送成功");
//        }
//        else
//        {
//            NSLog(@"walk检索发送失败");
//        }
//        
//        
//        
//         num = 5;
        
//    }
//}



//- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
//{
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:array];
//    array = [NSArray arrayWithArray:_mapView.overlays];
//    [_mapView removeOverlays:array];
//    if (error == BMK_SEARCH_NO_ERROR) {
//        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
//        NSInteger size = [plan.steps count];
//        int planPointCounts = 0;
//        for (int i = 0; i < size; i++) {
//            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
//            if(i==0){
//                RouteAnnotation* item = [[RouteAnnotation alloc]init];
//                item.coordinate = plan.starting.location;
//                item.title = @"起点";
//                item.type = 0;
//                [_mapView addAnnotation:item]; // 添加起点标注
//                
//            }else if(i==size-1){
//                RouteAnnotation* item = [[RouteAnnotation alloc]init];
//                item.coordinate = plan.terminal.location;
//                item.title = @"终点";
//                item.type = 1;
//                [_mapView addAnnotation:item]; // 添加起点标注
//            }
//            //添加annotation节点
//            RouteAnnotation* item = [[RouteAnnotation alloc]init];
//            item.coordinate = transitStep.entrace.location;
//            item.title = transitStep.entraceInstruction;
//            item.degree = transitStep.direction * 30;
//            item.type = 4;
//            [_mapView addAnnotation:item];
//            
//            //轨迹点总数累计
//            planPointCounts += transitStep.pointsCount;
//        }
//        
//        //轨迹点
//        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
//        int i = 0;
//        for (int j = 0; j < size; j++) {
//            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
//            int k=0;
//            for(k=0;k<transitStep.pointsCount;k++) {
//                temppoints[i].x = transitStep.points[k].x;
//                temppoints[i].y = transitStep.points[k].y;
//                i++;
//            }
//        }
//        // 通过points构建BMKPolyline
//        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
//        [_mapView addOverlay:polyLine]; // 添加路线overlay
//        delete []temppoints;
//        [self mapViewFitPolyLine:polyLine];
//    }
//}
//
//- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
//{
//    
//    BMKAnnotationView* view = nil;
//    switch (routeAnnotation.type) {
//        case 0:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
////                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
////                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 1:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
////                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
////                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 2:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
////                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
////                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 3:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
////                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
////                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 4:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
//                view.canShowCallout = TRUE;
//            } else {
//                [view setNeedsDisplay];
//            }
//            
////            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
////            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
//            view.annotation = routeAnnotation;
//            
//        }
//            break;
//        case 5:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
//                view.canShowCallout = TRUE;
//            } else {
//                [view setNeedsDisplay];
//            }
//            
////            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
////            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
//            view.annotation = routeAnnotation;
//        }
//            break;
//        default:
//            break;
//    }
//    
//    return view;
//}

- (void)getCarDistanceWithCoordinate1:(CLLocationCoordinate2D)coordinate1 withCoordinate2:(CLLocationCoordinate2D)coordinate2{
    //线路检索节点信息
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = coordinate1;
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    end.pt = coordinate2;
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc] init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    if (flag) {
    }
}

#pragma mark 返回驾乘搜索结果
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //表示一条驾车路线
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        ICLog(@"distance---%d--", plan.distance);
        [_delegate getCarDistanceForSign:plan.distance];
    }
}



#pragma mark - 设置地图范围
//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel + 1.3;
}

-(void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:    (BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        //当路线起终点有歧义时通，获取建议检索起终点
        //result.routeAddrResult
    }
    else {
//        NSLog(@"抱歉，未找到结果");
    }
}
- (void)onGetRoutePlanShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
//    NSLog(@"onGetRoutePlanShareURLResult error:%d", (int)error);
    if (error == BMK_SEARCH_NO_ERROR) {
        NSString *shortUrl = result.url;
        NSString *showmeg = [NSString stringWithFormat:@"%@",shortUrl];
//        NSLog(@"----%@----",shortUrl);
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"短串分享" message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"分享",@"取消",nil];
        myAlertView.tag = 1000;
        [myAlertView show];
    }
}


/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    
//    NSLog(@"获取当前位置失败，请检查您的网络－－%@",error);
    static BOOL first = YES;
    if (first) {
        first = NO;
        _baseView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _baseView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 blue:0 alpha:0.65];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:_baseView];
        
        [self _setTapGest];
        
        UIButton *changBut = [UIButton buttonWithType:UIButtonTypeCustom];
        changBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.125, [UIScreen mainScreen].bounds.size.height * 0.4, [UIScreen mainScreen].bounds.size.width - ([UIScreen mainScreen].bounds.size.width * 0.100 * 2), [UIScreen mainScreen].bounds.size.height * 0.09);
        changBut.backgroundColor = [UIColor whiteColor];
        [changBut setTitle:@"无法获取用户定位信息或定位权限被禁" forState:UIControlStateNormal];
        [changBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        changBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * [UIScreen mainScreen].bounds.size.width];
//        changBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        changBut.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        changBut.layer.cornerRadius = 7.5;
        [_baseView addSubview:changBut];
//        [changBut addTarget:self action:@selector(changeButClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    
}



- (void)_setTapGest {
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] init];
    
    [_baseView addGestureRecognizer:tapGest];
    
    [tapGest addTarget:self action:@selector(tapGestDone:)];
    
}
- (void)tapGestDone:(UITapGestureRecognizer *)tapGest {
    
    [_baseView removeFromSuperview];
    
    
}

#pragma mark - ***** 地图协议 *****
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */

#pragma mark - 私有

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}
//- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[BMKPolyline class]]) {
//        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
//        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
//        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
//        polylineView.lineWidth = 3.0;
//        return polylineView;
//    }
//    return nil;
//}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[GFAnnotation class]]) {
        GFAnnotationView *annView = [GFAnnotationView annotationWithMapView:mapView];
        
        annView.annotation = annotation;
        if (![annotation.title isEqualToString:@"我"]){
            annView.tag = 5;
        }
        return annView;
    }

    
    return nil;
}


/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    ICLog(@"点击标注的方法调用了--%ld--",view.tag);
    if (view.tag == 5 && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否进入百度地图导航导航" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"导航", nil];
        [alertView show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [_mapView deselectAnnotation:_bossPointAnno animated:YES];
    if (buttonIndex == 1) {
//        百度地图
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {

            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=商户&mode=driving",_bossPointAnno.coordinate.latitude,_bossPointAnno.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            ICLog(@"URLString----%@--",urlString);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }

        
    }
}



//*******************  自定义封装方法  **********************

#pragma mark - ***** 计算两点间的距离 *****
- (double)calculatorWithCoordinate1:(CLLocationCoordinate2D)coordinate1 withCoordinate2:(CLLocationCoordinate2D)coordinate2 {
    ICLog(@"----dian-%f----diandian--%f--",coordinate1.latitude,coordinate1.longitude);
    ICLog(@"----dian-%f----diandian--%f--",coordinate2.latitude,coordinate2.longitude);
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:coordinate1.latitude longitude:coordinate1.longitude];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:coordinate2.latitude longitude:coordinate2.longitude];
    
    double distance = [location1 distanceFromLocation:location2];

    return distance;
}

+ (double)calculatorWithCoordinate1:(CLLocationCoordinate2D)coordinate1 withCoordinate2:(CLLocationCoordinate2D)coordinate2 {
    ICLog(@"----dian-%f----diandian--%f--",coordinate1.latitude,coordinate1.longitude);
    ICLog(@"----dian-%f----diandian--%f--",coordinate2.latitude,coordinate2.longitude);
    
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:coordinate1.latitude longitude:coordinate1.longitude];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:coordinate2.latitude longitude:coordinate2.longitude];
    
    double distance = [location1 distanceFromLocation:location2];
    
    return distance;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    /**
     *  关键一句
     */
    [self.mapView viewWillAppear];
    // 地图相关代理
    self.locationService.delegate = self;
    self.mapView.delegate = self;
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    /**
     *  关键一句
     */
    [self.mapView viewWillDisappear];
    // 地图相关代理移除
    self.locationService.delegate = nil;
    self.mapView.delegate = nil;
    
    num = 0;
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
