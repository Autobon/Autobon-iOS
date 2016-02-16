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

@interface GFMapViewController : UIViewController

@property (nonatomic ,copy) DistanceBlock distanceBlock;

@property (nonatomic ,strong) FirstViewController *first;
// 地图
@property(nonatomic, strong) BMKMapView *mapView;

@property(nonatomic, strong) GFAnnotation *bossPointAnno;

@end
