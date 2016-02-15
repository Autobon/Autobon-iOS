//
//  PoiSearchDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface PoiSearchDemoViewController : UIViewController<BMKMapViewDelegate, BMKPoiSearchDelegate> {
    BMKMapView* _mapView;
    UITextField* _cityText;
    UITextField* _keyText;
    UIButton* _nextPageButton;
    BMKPoiSearch* _poisearch;
    int curPage;
}


@end
