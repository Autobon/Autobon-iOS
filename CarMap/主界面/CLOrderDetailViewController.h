//
//  CLOrderDetailViewController.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLOrderDetailViewController : UIViewController

@property (nonatomic ,strong) NSString *customerLat;
@property (nonatomic ,strong) NSString *customerLon;
@property (nonatomic ,strong) NSString *orderPhotoURL;
@property (nonatomic ,strong) NSString *orderTime;
@property (nonatomic ,strong) NSString *remark;
@property (nonatomic ,strong) NSString *orderId;
@property (nonatomic ,strong) NSString *action;
@property (nonatomic ,strong) NSString *mainTechId;



@end
