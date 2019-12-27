//
//  CLHomeOrderCellModel.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLHomeOrderCellModel.h"

@implementation CLHomeOrderCellModel


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    
    if(self != nil) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        
        
        _orderId = dic[@"id"];
        _orderNumber = dic[@"orderNum"];
        _orderTime = dic[@"agreedStartTime"];
        
        if ([dic[@"agreedStartTime"] isKindOfClass:[NSNull class]]){
            _orderTime = @"";
        }else{
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dic[@"agreedStartTime"] doubleValue]/1000];
            
            _orderTime = [formatter stringFromDate:date];
        }
        
        
        
        if([dic[@"mainTechId"] isKindOfClass:[NSNull class]]) {
            
            _mainTechId = @"";
        }else {
            
            _mainTechId = dic[@"techId"];
        }

        
        if(![dic[@"type"] isKindOfClass:[NSNull class]]){
            NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
            NSArray *idArr = [dic[@"type"] componentsSeparatedByString:@","];
            NSString *str = @"";
            for(int i=0; i<idArr.count; i++) {
                
                NSInteger index = [idArr[i] integerValue] - 1;
                if([str isEqualToString:@""]) {
                    
                    str = array[index];
                }else {
                    
                    str = [NSString stringWithFormat:@"%@,%@", str, array[index]];
                }
            }
            _orderType = str;
        }else{
            _orderType = @"--";
        }
        
        
        _orderPhotoURL = [NSString stringWithFormat:@"%@", dic[@"photo"]];
        if([dic[@"latitude"] isKindOfClass:[NSNull class]]){
            _customerLon = @"0";
        }else{
            _customerLat = dic[@"latitude"];
        }
        if([dic[@"longitude"] isKindOfClass:[NSNull class]]){
            _customerLon = @"0";
        }else{
            _customerLon = dic[@"longitude"];
        }
        
        
    
        // 备注
        _remark = dic[@"remark"];
        if ([_remark isKindOfClass:[NSNull class]]) {
            
            _remark = @" ";
        }
        if ([[NSString stringWithFormat:@"%@",_remark] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",_remark] isEqualToString:@"<null>"]){
            _remark = @" ";
        }
        
        // 备注
        _technicianRemark = dic[@"technicianRemark"];
        if ([_technicianRemark isKindOfClass:[NSNull class]]) {
            
            _technicianRemark = @"";
        }
        if ([[NSString stringWithFormat:@"%@",_technicianRemark] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",_technicianRemark] isEqualToString:@"<null>"]){
            _technicianRemark = @"";
        }
        
        _status = dic[@"status"];
        // 商户名字
        _cooperatorFullname = [NSString stringWithFormat:@"%@", dic[@"coopName"]];
        _cooperatorId = [NSString stringWithFormat:@"%@",dic[@"coopId"]];
        _contactPhone = dic[@"contactPhone"];
        // 施工前照片
        if([dic[@"beforePhotos"] isKindOfClass:[NSNull class]]) {
            
            _beforePhotos = @"无";
        }else {
            
            _beforePhotos = dic[@"beforePhotos"];
        }
        
        _createTime = [NSString stringWithFormat:@"%@", dic[@"createTime"]];
        _agreedEndTime = [NSString stringWithFormat:@"%@", dic[@"agreedEndTime"]];
        
        if ([dic[@"agreedEndTime"] isKindOfClass:[NSNull class]]){
            _agreedEndTime = @"";
        }else{
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dic[@"agreedEndTime"] doubleValue]/1000];
            
            _agreedEndTime = [formatter stringFromDate:date];
        }
        
        if ([dic[@"createTime"] isKindOfClass:[NSNull class]]){
            _createTime = @"";
        }else{
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dic[@"createTime"] doubleValue]/1000];
            
            _createTime = [formatter stringFromDate:date];
        }
        
        _creatorName = [NSString stringWithFormat:@"%@", dic[@"creatorName"]];
        
        // 开始时间
        if([dic[@"startTime"] isKindOfClass:[NSNull class]]) {
            
            _startTime = @"未开始";
        }else {
            
            _startTime = dic[@"startTime"];
        }
        
        // 地址
        if([dic[@"address"] isKindOfClass:[NSNull class]]) {
            
            _address = @"暂无地址信息";
        }else {
            
            _address = dic[@"address"];
        }
        
        // 车牌号
        if([dic[@"license"] isKindOfClass:[NSNull class]]) {
            
            _license = @"";
        }else {
            
            _license = dic[@"license"];
        }
        if ([[NSString stringWithFormat:@"%@",_license] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",_license] isEqualToString:@"<null>"]){
            _license = @" ";
        }
        
        // 车型
        if([dic[@"vehicleModel"] isKindOfClass:[NSNull class]]) {
            
            _vehicleModel = @"";
        }else {
            
            _vehicleModel = dic[@"vehicleModel"];
        }
        if ([[NSString stringWithFormat:@"%@",_vehicleModel] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",_vehicleModel] isEqualToString:@"<null>"]){
            _vehicleModel = @" ";
        }
        
        
        // 车架号
        if([dic[@"vin"] isKindOfClass:[NSNull class]]) {
            
            _vin = @"";
        }else {
            
            _vin = dic[@"vin"];
        }
    }
    
    return self;
}









@end
