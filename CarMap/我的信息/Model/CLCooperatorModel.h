//
//  CLCooperatorModel.h
//  CarMap
//
//  Created by inCar on 17/5/18.
//  Copyright © 2017年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCooperatorModel : NSObject


@property (nonatomic ,strong) NSString *address;                //商户地址
@property (nonatomic ,strong) NSString *businessLicense;        //营业执照编号
@property (nonatomic ,strong) NSString *bussinessLicensePic;    //营业执照照片
@property (nonatomic ,strong) NSString *city;                   //商户城市
@property (nonatomic ,strong) NSString *contact;                //联系人
@property (nonatomic ,strong) NSString *contactPhone;           //联系电话
@property (nonatomic ,strong) NSString *corporationIdNo;        //法人身份证号
@property (nonatomic ,strong) NSString *corporationIdPicA;      //身份证正面照
@property (nonatomic ,strong) NSString *corporationIdPicB;      //身份证反面照
@property (nonatomic ,strong) NSString *corporationName;        //法人姓名
@property (nonatomic ,strong) NSString *createTime;             //创建时间
@property (nonatomic ,strong) NSString *district;               //所属区域
@property (nonatomic ,strong) NSString *fullname;               //商户全称
@property (nonatomic ,strong) NSString *idString;               //商户id
@property (nonatomic ,strong) NSString *invoiceHeader;          //发票抬头
@property (nonatomic ,strong) NSString *latitude;               //纬度
@property (nonatomic ,strong) NSString *longitude;              //经度
@property (nonatomic ,strong) NSString *orderNum;               //
@property (nonatomic ,strong) NSString *postcode;               //邮编
@property (nonatomic ,strong) NSString *province;               //所在省
@property (nonatomic ,strong) NSString *salesman;               //
@property (nonatomic ,strong) NSString *salesmanPhone;          //
@property (nonatomic ,strong) NSString *statusCode;             //状态编码
@property (nonatomic ,strong) NSString *taxIdNo;                //纳税识别号


- (void)setModelForData:(NSDictionary *)dictionary;

@end
