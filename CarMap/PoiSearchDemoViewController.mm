//
//  PoiSearchDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "PoiSearchDemoViewController.h"
#import "BMKLocationService.h"
#import "GFAnnotation.h"
#import "GFAnnotationView.h"




@interface PoiSearchDemoViewController ()<UISearchBarDelegate,BMKLocationServiceDelegate,BMKMapViewDelegate>
{
     UISearchBar *_searchbar;
    
    
}



// 定位
@property(nonatomic, strong) BMKLocationService *locationService;

// 大头针
@property(nonatomic, strong) GFAnnotation *workerPointAnno;


@end



@implementation PoiSearchDemoViewController


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 84, self.view.frame.size.width-100, 40)];
    //    searchbar.backgroundColor = [UIColor whiteColor];
    _searchbar.barTintColor = [UIColor whiteColor];
    //    searchbar.barStyle = UIBarStyleDefault;
    _searchbar.layer.cornerRadius = 20;
    _searchbar.layer.borderWidth = 1.0;
    _searchbar.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]CGColor];
    
    [self.view addSubview:_searchbar];
    _searchbar.delegate = self;
    _searchbar.clipsToBounds = YES;
    
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 84, 60, 40)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    
    
    
    
    
    
    
    
    
    
    
    
     _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width , self.view.frame.size.width*7/10)];
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
	_poisearch = [[BMKPoiSearch alloc]init];

    // 设置地图级别
    [_mapView setZoomLevel:13];
    _nextPageButton.enabled = false;
    _mapView.isSelectedAnnotationViewFront = YES;
    
   
    [self _setLocationService];
    
    [self _setAnnonation];
   
}



#pragma mark - ***** 大头针 *****
- (void)_setAnnonation {
    
    // 技师大头针
    self.workerPointAnno = [[GFAnnotation alloc] init];
    self.workerPointAnno.title = @"我是技师";
    self.workerPointAnno.subtitle = @"天赐我一个单吧";
    self.workerPointAnno.iconImgName = @"me-1";
    [_mapView addAnnotation:self.workerPointAnno];
    
    
   
    
}



#pragma mark - ***** 定位 *****
- (void)_setLocationService {
    
    self.locationService = [[BMKLocationService alloc] init];
    [self.locationService startUserLocationService];
    self.locationService.allowsBackgroundLocationUpdates = NO;
    self.locationService.pausesLocationUpdatesAutomatically = YES;
    
}



#pragma mark - ***** 定位代理 *****
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {

    _mapView.centerCoordinate = userLocation.location.coordinate;
    self.workerPointAnno.coordinate = userLocation.location.coordinate;
//    [_mapView updateLocationData:userLocation];
}


- (void)didFailToLocateUserWithError:(NSError *)error {
    
    NSLog(@"获取当前位置失败，请检查您的网络－－%@",error);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self searchBtnClick];
}


-(void)backClick{
    NSLog(@"出栈啦");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [_mapView viewWillAppear];
    self.locationService.delegate = self;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [_mapView viewWillDisappear];
    self.locationService.delegate = nil;
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil; // 不用时，置nil
}



- (void)dealloc {
    if (_poisearch != nil) {
        _poisearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)searchBtnClick
{
    [self.view endEditing:YES];
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    
    option.location = CLLocationCoordinate2DMake(_workerPointAnno.coordinate.latitude, _workerPointAnno.coordinate.longitude);
    option.keyword = @"小吃";
    BOOL flag2 = [_poisearch poiSearchNearBy:option];
    
    if(flag2)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }

    
    
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    NSLog(@"看一看");
    if([annotation isKindOfClass:[GFAnnotation class]]) {
        GFAnnotationView *annView = [GFAnnotationView annotationWithMapView:mapView];
        
        annView.annotation = annotation;
        return annView;
    }
    
    
    return nil;
}


//#pragma mark -
//#pragma mark implement BMKMapViewDelegate
//- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    // 生成重用标示identifier
//    NSString *AnnotationViewID = @"xidanMark";
//	
//    // 检查是否有重用的缓存
//    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//    
//    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
//    if (annotationView == nil) {
//        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
//		// 设置重天上掉下的效果(annotation)
//        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
//    }
//	
//    // 设置位置
//	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
//    annotationView.annotation = annotation;
//    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
//	annotationView.canShowCallout = YES;
//    // 设置是否可以拖拽
//    annotationView.draggable = NO;
//    
//    return annotationView;
//}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
		for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
		}
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
	} else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

@end
