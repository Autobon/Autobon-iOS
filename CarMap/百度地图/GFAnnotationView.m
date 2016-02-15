//
//  GFAnnotationView.m
//  GFMap_2
//
//  Created by 陈光法 on 16/1/27.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFAnnotationView.h"
#import "GFAnnotation.h"

@implementation GFAnnotationView

+ (instancetype)annotationWithMapView:(BMKMapView *)mapView {
    static NSString *ID = @"ID";
    GFAnnotationView *annView = (GFAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if(annView == nil) {
        annView = [[GFAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
    }
    
    return annView;
}

- (instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if(self != nil) {
    
        // 设置后能看到泡泡
        self.canShowCallout = YES;
    }

    return self;
}

- (void)setAnnotation:(GFAnnotation *)annotation {

    [super setAnnotation:annotation];
    
    // 给大头针自定义图片
    self.image = [UIImage imageNamed:annotation.iconImgName];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
