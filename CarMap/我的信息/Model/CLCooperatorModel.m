//
//  CLCooperatorModel.m
//  CarMap
//
//  Created by inCar on 17/5/18.
//  Copyright © 2017年 mll. All rights reserved.
//

#import "CLCooperatorModel.h"

@implementation CLCooperatorModel


- (void)setModelForData:(NSDictionary *)dictionary{
    self.address = dictionary[@"address"];
    self.businessLicense = dictionary[@"businessLicense"];
    self.bussinessLicensePic = dictionary[@"bussinessLicensePic"];
    self.city = dictionary[@"city"];
    self.contact = dictionary[@"contact"];
    self.contactPhone = dictionary[@"contactPhone"];
    self.corporationIdNo = dictionary[@"corporationIdNo"];
    self.corporationIdPicA = dictionary[@"corporationIdPicA"];
    self.corporationIdPicB = dictionary[@"corporationIdPicB"];
    self.corporationName = dictionary[@"corporationName"];
    self.createTime = dictionary[@"createTime"];
    self.district = dictionary[@"district"];
    self.fullname = dictionary[@"fullname"];
    self.idString = dictionary[@"id"];
    self.invoiceHeader = dictionary[@"invoiceHeader"];
    self.latitude = dictionary[@"latitude"];
    self.longitude = dictionary[@"longitude"];
    self.orderNum = dictionary[@"orderNum"];
    self.postcode = dictionary[@"postcode"];
    self.province = dictionary[@"province"];
    self.salesman = dictionary[@"salesman"];
    self.salesmanPhone = dictionary[@"salesmanPhone"];
    self.statusCode = dictionary[@"statusCode"];
    self.taxIdNo = dictionary[@"taxIdNo"];
    
}

@end
