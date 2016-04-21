//
//  CLListNewModel.h
//  CarMap
//
//  Created by 李孟龙 on 16/4/20.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLListNewModel : NSObject

@property (nonatomic ,strong) NSString *orderId;
@property (nonatomic ,strong) NSString *orderType;
@property (nonatomic ,strong) NSString *orderNumber;
@property (nonatomic ,strong) NSString *orderTime;
@property (nonatomic ,strong) NSString *orderPhoto;
@property (nonatomic ,strong) NSString *orderRemark;
@property (nonatomic ,strong) NSString *orderLat;
@property (nonatomic ,strong) NSString *orderLon;
@property (nonatomic ,strong) NSDictionary *dataDictionary;


@end
