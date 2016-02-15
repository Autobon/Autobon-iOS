//
//  GFAnnotation.h
//  GFMap_2
//
//  Created by 陈光法 on 16/1/27.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMKAnnotation.h"

@interface GFAnnotation : NSObject <BMKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;



@property (nonatomic, copy) NSString  *iconImgName;


@end
