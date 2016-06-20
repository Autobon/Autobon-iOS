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
@property (nonatomic, copy) NSString *signinTime;   // 施工时间
@property (nonatomic, copy) NSString *workItems;    // 施工部位
@property (nonatomic, copy) NSString *remark;       // 下单备注
@property (nonatomic, copy) NSString *workTime;     // 施工时间
@property (nonatomic, copy) NSDictionary *commentDictionary;     // 评论字典
@property (nonatomic, copy) NSString *indentType;   // 订单类型
@property (nonatomic, copy) NSMutableArray *workerArr;      // 施工人员
@property (nonatomic, copy) NSString *beforePhotos; //施工前照片
@property (nonatomic, copy) NSString *afterPhotos; //施工后照片

@end
