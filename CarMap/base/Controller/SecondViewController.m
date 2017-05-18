//
//  SecondViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/1.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController ()<BMKMapViewDelegate, BMKPoiSearchDelegate>
{
    BMKMapView *_mapView;
    BMKPoiSearch* _poisearch;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-150)];
//    [self.view addSubview:_mapView];
//    _poisearch = [[BMKPoiSearch alloc]init];
//    
//    
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _poisearch.delegate = self;
//    [_mapView setZoomLevel:13];
////    _nextPageButton.enabled = false;
//    _mapView.isSelectedAnnotationViewFront = YES;
    
    
    
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 150, 400, 500)];
//
//    _poisearch =[[BMKPoiSearch alloc]init];
//    _poisearch.delegate = self;
//    //发起检索
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    
//    option.location = CLLocationCoordinate2DMake(39.915, 116.404);
//    option.keyword = @"小吃";
//    BOOL flag = [_poisearch poiSearchNearBy:option];
//    
//    if(flag)
//    {
//        NSLog(@"周边检索发送成功");
//    }else{
//        NSLog(@"周边检索发送失败");
//    }
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-150)];
    [self.view addSubview:_mapView];
    _poisearch = [[BMKPoiSearch alloc]init];
    
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = self;
    [_mapView setZoomLevel:13];
    _mapView.isSelectedAnnotationViewFront = YES;
    
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(100, 50, 120, 40);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnClick{
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.city= @"武汉";
    citySearchOption.keyword = @"光谷软件园";
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
//        NSLog(@"城市内检索发送成功");
    }
    else
    {
//        NSLog(@"城市内检索发送失败");
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil;
}

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
//        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
//    NSLog(@"didAddAnnotationViews");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
