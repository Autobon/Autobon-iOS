//
//  CLHomeOrderCellModel.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHomeOrderCellModel : NSObject

@property (nonatomic ,copy) NSString *orderId;            //订单id
@property (nonatomic ,copy) NSString *orderNumber;        //订单编号
@property (nonatomic ,copy) NSString *orderTime;          //预约施工时间
@property (nonatomic ,copy) NSString *orderType;          //订单类型
@property (nonatomic ,copy) NSString *orderPhotoURL;      //订单照片
@property (nonatomic ,copy) NSString *customerLat;        //商户坐标
@property (nonatomic ,copy) NSString *customerLon;        //商户坐标
@property (nonatomic ,copy) NSString *remark;             //订单备注
@property (nonatomic ,copy) NSString *status;             //订单状态标示符
@property (nonatomic ,copy) NSString *mainTechId;         //订单主技师id
@property (nonatomic ,copy) NSString *mainName;           //订单主技师name
@property (nonatomic ,copy) NSString *secondTechId;       //订单次技师id
@property (nonatomic ,copy) NSString *mateName;           //订单次技师name
@property (nonatomic ,copy) NSString *startTime;          //订单开始时间
@property (nonatomic ,copy) NSString *signinTime;         //订单签到时间
@property (nonatomic ,copy) NSString *beforePhotos;       //订单工作前照片
@property (nonatomic ,copy) NSString *afterPhotos;        //订单工作后照片
@property (nonatomic ,copy) NSString *cooperatorName;     //订单下单人
@property (nonatomic ,copy) NSString *cooperatorAddress;  //订单下单商户位置
@property (nonatomic ,copy) NSString *cooperatorFullname; //订单下单商户名称
@property (nonatomic ,copy) NSString *cooperatorId;         //订单下单商户id
@property (nonatomic, copy) NSString *address;            //商户地址
@property (nonatomic, copy) NSString *agreedEndTime;        // 最晚交车时间
@property (nonatomic, copy) NSString *createTime;           // 下单时间
@property (nonatomic, copy) NSString *creatorName;          // 下单人
@property (nonatomic, copy) NSString *contactPhone;         //联系方式
@property (nonatomic, copy) NSString *vehicleModel;         //车型
@property (nonatomic, copy) NSString *vin;         //车架号
@property (nonatomic, copy) NSString *license;         //车牌号

@property (nonatomic ) CGFloat cellHeight;

- (instancetype)initWithDictionary:(NSDictionary *)dic;





@end
