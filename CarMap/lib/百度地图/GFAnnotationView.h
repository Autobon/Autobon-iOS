//
//  GFAnnotationView.h
//  GFMap_2
//
//  Created by 陈光法 on 16/1/27.
//  Copyright © 2016年 陈光法. All rights reserved.
//
//#import <BaiduMapKit/BaiduMapKit.h>
//#import "BaiduMapKit/BaiduMapKit.h"
//#import <BaiduMapAPI/BMapKit.h>
//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>
#import "BMKAnnotationView.h"
#import "BMKMapView.h"

@interface GFAnnotationView : BMKAnnotationView

+ (instancetype)annotationWithMapView:(BMKMapView *)mapView;


@end
