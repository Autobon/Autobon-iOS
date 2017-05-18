//
//  CLWorkOverViewController.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLHomeOrderCellModel;

@interface CLWorkOverViewController : UIViewController


@property (nonatomic ,strong) NSString *orderId;
@property (nonatomic ,strong) NSString *orderNumber;
@property (nonatomic ,strong) NSString *orderType;
@property (nonatomic ,strong) NSString *startTime;

@property (nonatomic, strong) CLHomeOrderCellModel *model;

@end
