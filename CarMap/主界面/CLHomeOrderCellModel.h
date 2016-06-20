//
//  CLHomeOrderCellModel.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHomeOrderCellModel : NSObject

@property (nonatomic ,strong) NSString *orderId;            //订单id
@property (nonatomic ,strong) NSString *orderNumber;        //订单编号
@property (nonatomic ,strong) NSString *orderTime;          //施工时间
@property (nonatomic ,strong) NSString *orderType;          //订单类型
@property (nonatomic ,strong) NSString *orderPhotoURL;      //订单照片
@property (nonatomic ,strong) NSString *customerLat;        //商户坐标
@property (nonatomic ,strong) NSString *customerLon;        //商户坐标
@property (nonatomic ,strong) NSString *remark;             //订单备注
@property (nonatomic ,strong) NSString *status;             //订单状态标示符
@property (nonatomic ,strong) NSString *mainTechId;         //订单主技师id
@property (nonatomic ,strong) NSString *mainName;           //订单主技师name
@property (nonatomic ,strong) NSString *secondTechId;       //订单次技师id
@property (nonatomic ,strong) NSString *mateName;           //订单次技师name
@property (nonatomic ,strong) NSString *startTime;          //订单开始时间
@property (nonatomic ,strong) NSString *signinTime;         //订单签到时间
@property (nonatomic ,strong) NSString *beforePhotos;       //订单工作前照片
@property (nonatomic ,strong) NSString *afterPhotos;        //订单工作后照片
@property (nonatomic ,strong) NSString *cooperatorName;     //订单下单人
@property (nonatomic ,strong) NSString *cooperatorAddress;  //订单下单商户位置
@property (nonatomic ,strong) NSString *cooperatorFullname; //订单下单商户名称








@end
