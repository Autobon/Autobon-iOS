//
//  CLNotificationModel.h
//  CarMap
//
//  Created by 李孟龙 on 16/4/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLNotificationModel : NSObject

@property (nonatomic ,strong) NSString *titleString;
@property (nonatomic ,strong) NSString *timeString;
@property (nonatomic ,strong) NSString *contentString;
@property (nonatomic ) NSInteger cellHeight;

@end
