//
//  GFBillDetailsViewController.h
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFBillModel;

@interface GFBillDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) GFBillModel *model;


@end
