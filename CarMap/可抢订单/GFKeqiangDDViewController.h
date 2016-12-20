//
//  GFKeqiangDDViewController.h
//  CarMap
//
//  Created by 陈光法 on 16/12/5.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLHomeOrderCellModel;

@interface GFKeqiangDDViewController : UIViewController


@property (nonatomic ,copy) NSString *customerLat;
@property (nonatomic ,copy) NSString *customerLon;
@property (nonatomic ,copy) NSString *orderPhotoURL;
@property (nonatomic ,copy) NSString *orderTime;
@property (nonatomic ,copy) NSString *remark;
@property (nonatomic ,copy) NSString *orderId;
@property (nonatomic ,copy) NSString *orderNumber;
@property (nonatomic ,copy) NSString *action;
@property (nonatomic ,copy) NSString *mainTechId;
@property (nonatomic ,copy) NSString *secondId;
@property (nonatomic ,copy) NSString *orderType;
@property (nonatomic, copy) NSString *startTime;

@property (nonatomic ,copy) NSString *cooperatorName;
@property (nonatomic ,copy) NSString *cooperatorAddress;
@property (nonatomic ,copy) NSString *cooperatorFullname;



@property (nonatomic, strong) CLHomeOrderCellModel *model;


@end
