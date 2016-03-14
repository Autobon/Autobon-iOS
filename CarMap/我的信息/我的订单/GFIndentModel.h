//
//  GFIndentModel.h
//  CarMap
//
//  Created by 陈光法 on 16/3/8.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFIndentModel : NSObject


@property (nonatomic, copy) NSString *orderNum;     // 订单编号
@property (nonatomic, copy) NSString *payment;      // 订单金额
@property (nonatomic, copy) NSString *payStatus;    // 是否结算
@property (nonatomic, copy) NSString *photo;        // 订单图片
@property (nonatomic, copy) NSString *signinTime;   // 开始时间
@property (nonatomic, copy) NSString *workItems;    // 施工部位




@end
