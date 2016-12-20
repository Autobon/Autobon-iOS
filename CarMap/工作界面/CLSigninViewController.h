//
//  SigninViewController.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLHomeOrderCellModel;

@interface CLSigninViewController : UIViewController

@property (nonatomic ,strong) NSString *customerLat;
@property (nonatomic ,strong) NSString *customerLon;
@property (nonatomic ,strong) NSString *orderId;
@property (nonatomic ,strong) NSString *orderNumber;
@property (nonatomic ,strong) NSString *orderType;
@property (nonatomic ,strong) NSString *startTime;

@property (nonatomic, strong) CLHomeOrderCellModel *model;

@end
