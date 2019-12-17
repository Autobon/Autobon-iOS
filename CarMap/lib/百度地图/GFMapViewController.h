//
//  GFMapViewController.h
//  GFMap_2
//
//  Created by 陈光法 on 16/1/28.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "GFAnnotation.h"

// 距离店铺Block
typedef void (^DistanceBlock)(double distance);


@protocol CLMapForViewDelegate <NSObject>

- (void)getCarDistanceForSign:(NSInteger )distance;

@end

@interface GFMapViewController : UIViewController

@property (nonatomic) id<CLMapForViewDelegate>delegate;

@property (nonatomic ,copy) DistanceBlock distanceBlock;

@property (nonatomic ,strong) FirstViewController *first;
// 地图
@property(nonatomic, strong) BMKMapView *mapView;

@property(nonatomic, strong) GFAnnotation *bossPointAnno;
// 大头针
@property(nonatomic, strong) GFAnnotation *workerPointAnno;




- (void)startUserLocationService;

- (void)userLocationService;


+ (double)calculatorWithCoordinate1:(CLLocationCoordinate2D)coordinate1 withCoordinate2:(CLLocationCoordinate2D)coordinate2;

- (void)getCarDistanceWithCoordinate1:(CLLocationCoordinate2D)coordinate1 withCoordinate2:(CLLocationCoordinate2D)coordinate2;



@end




