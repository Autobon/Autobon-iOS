//
//  GFNewOrderModel.h
//  CarMap
//
//  Created by 陈光法 on 16/12/7.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFNewOrderModel : NSObject

@property (nonatomic, copy) NSString *address;          // 商户地址
@property (nonatomic, copy) NSString *afterPhotos;      // 施工后照片
@property (nonatomic, copy) NSString *agreedEndTime;    // 预约施工时间
@property (nonatomic, copy) NSString *agreedStartTime;  // 最迟交车时间
@property (nonatomic, copy) NSString *beforePhotos;     // 施工前照片
@property (nonatomic, copy) NSString *coopName;         // 商户名字
@property (nonatomic, copy) NSString *coopId;         // 商户ID
@property (nonatomic, copy) NSString *createTime;       // 订单创建时间
@property (nonatomic, copy) NSString *creatorName;      // 下单人姓名
@property (nonatomic, copy) NSString *contactPhone;     //联系方式
@property (nonatomic, copy) NSString *orderID;          // 订单ID
@property (nonatomic, copy) NSString *latitude;         // 商户维度
@property (nonatomic, copy) NSString *longitude;        // 商户经度
@property (nonatomic, copy) NSString *orderNum;         // 订单编号
@property (nonatomic, copy) NSString *payStatus;        // 支付状态
@property (nonatomic, copy) NSString *payment;          // 支付金额
@property (nonatomic, copy) NSString *photo;            // 订单图片
@property (nonatomic, copy) NSString *remark;           // 订单备注
@property (nonatomic, copy) NSString *signTime;         // 签到时间
@property (nonatomic, copy) NSString *startTime;        // 开始施工时间
@property (nonatomic, copy) NSString *endTime;        // 开始施工时间
@property (nonatomic, copy) NSString *status;           // 订单状态
@property (nonatomic, copy) NSString *techAvatar;       // 技师头像地址
@property (nonatomic, copy) NSString *techId;           // 技师ID
@property (nonatomic, copy) NSString *techLatitude;     // 技师维度
@property (nonatomic, copy) NSString *techLongitude;    // 技师经度
@property (nonatomic, copy) NSString *techName;         // 技师名字
@property (nonatomic, copy) NSString *techPhone;        // 技师电话
@property (nonatomic, copy) NSString *type;             // 订单类型
@property (nonatomic, copy) NSString *typeName;         // 订单类型名字
@property (nonatomic, copy) NSString *royalty;          // 提成
@property (nonatomic, copy) NSString *totalCost;          // 报废扣除

@property (nonatomic, strong) NSArray *orderConstructionShow;
@property (nonatomic, copy) NSString *jishiAllName;
@property (nonatomic, strong) NSDictionary *comment;
@property (nonatomic, copy) NSString *commentStr;

@property (nonatomic, strong) NSArray *constructionWasteShows;
@property (nonatomic, strong) NSString *license;
@property (nonatomic, strong) NSString *vin;

@property (nonatomic, strong) NSArray *productOfferArray;
@property (nonatomic, strong) NSArray *setMenusArray;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
