//
//  GFNewOrderModel.m
//  CarMap
//
//  Created by 陈光法 on 16/12/7.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFNewOrderModel.h"

@implementation GFNewOrderModel


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    
    if(self != nil) {
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        
        if(dic[@"address"] == nil) {
            self.address = @"无";
        }else {
            self.address = dic[@"address"];
        }
        
        if(dic[@"afterPhotos"] == nil) {
            self.afterPhotos = @"无";
        }else {
            self.afterPhotos = dic[@"afterPhotos"];
        }
        
        if(dic[@"agreedEndTime"] == nil) {
            self.agreedEndTime = @"无";
        }else {
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[dic[@"agreedEndTime"] doubleValue]/1000];
            self.agreedEndTime = [formatter stringFromDate:date1];
        }
        
        if(dic[@"agreedStartTime"] == nil) {
            self.agreedStartTime = @"无";
        }else {
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[dic[@"agreedStartTime"] doubleValue]/1000];
            self.agreedStartTime = [formatter stringFromDate:date1];
        }
        
        if(dic[@"beforePhotos"] == nil) {
            self.beforePhotos = @"无";
        }else {
            self.beforePhotos = dic[@"beforePhotos"];
        }
        
        if(dic[@"coopName"] == nil) {
            self.coopName = @"无";
        }else {
            self.coopName = dic[@"coopName"];
        }
        
        if(dic[@"coopId"] == nil) {
            self.coopId = @"无";
        }else {
            self.coopId = dic[@"coopId"];
        }
        
        if(dic[@"createTime"] == nil) {
            self.createTime = @"无";
        }else {
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[dic[@"createTime"] doubleValue]/1000];
            self.createTime = [formatter stringFromDate:date1];
        }
        
        if(dic[@"creatorName"] == nil) {
            self.creatorName = @"无";
        }else {
            self.creatorName = dic[@"creatorName"];
        }
        
        if(dic[@"contactPhone"] == nil) {
            self.contactPhone = @"无";
        }else {
            self.contactPhone = dic[@"contactPhone"];
        }
        
        if(dic[@"id"] == nil) {
            self.orderID = @"无";
        }else {
            self.orderID = dic[@"id"];
        }
        
        if(dic[@"latitude"] == nil) {
            self.latitude = @"无";
        }else {
            self.latitude = dic[@"latitude"];
        }
        
        if(dic[@"longitude"] == nil) {
            self.longitude = @"无";
        }else {
            self.longitude = dic[@"longitude"];
        }
        
        if(dic[@"orderNum"] == nil) {
            self.orderNum = @"无";
        }else {
            self.orderNum = dic[@"orderNum"];
        }
        
        if(dic[@"payStatus"] == nil) {
            self.payStatus = @"无";
        }else {
            self.payStatus = dic[@"payStatus"];
        }
        
        if(dic[@"payment"] == nil) {
            self.payment = @"无";
        }else {
            self.payment = dic[@"payment"];
        }
        
        if(dic[@"photo"] == nil) {
            self.photo = @"无";
        }else {
            self.photo = dic[@"photo"];
        }
        
        if(dic[@"remark"] == nil) {
            self.remark = @"无";
        }else {
            self.remark = dic[@"remark"];
        }
        
        if(dic[@"signTime"] == nil) {
            self.signTime = @"无";
        }else {
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[dic[@"signTime"] doubleValue]/1000];
            self.signTime = [formatter stringFromDate:date1];
        }
        
        if(dic[@"startTime"] == nil) {
            self.startTime = @"无";
        }else {
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[dic[@"startTime"] doubleValue]/1000];
            self.startTime = [formatter stringFromDate:date1];
        }
        
        if(dic[@"endTime"] == nil) {
            self.startTime = @"无";
        }else {
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[dic[@"endTime"] doubleValue]/1000];
            self.endTime = [formatter stringFromDate:date1];
        }
        
        if(dic[@"status"] == nil) {
            self.status = @"无";
        }else {
            self.status = dic[@"status"];
        }
        
        if(dic[@"techAvatar"] == nil) {
            self.techAvatar = @"无";
        }else {
            self.techAvatar = dic[@"techAvatar"];
        }
        
        if(dic[@"techId"] == nil) {
            self.techId = @"无";
        }else {
            self.techId = dic[@"techId"];
        }
        
        if(dic[@"techLatitude"] == nil) {
            self.techLatitude = @"无";
        }else {
            self.techLatitude = dic[@"techLatitude"];
        }
        
        if(dic[@"techLongitude"] == nil) {
            self.techLongitude = @"无";
        }else {
            self.techLongitude = dic[@"techLongitude"];
        }
        
        if(dic[@"techName"] == nil) {
            self.techName = @"无";
        }else {
            self.techName = dic[@"techName"];
        }
        
        if(dic[@"techPhone"] == nil) {
            self.techPhone = @"无";
        }else {
            self.techPhone = dic[@"techPhone"];
        }
        
        if(dic[@"type"] == nil) {
            self.type = @"无";
        }else {
            self.type = dic[@"type"];
        }
        NSString *ss = @"";
        NSArray *typeNameArr = @[@"隔热膜", @"隐形车衣", @"车身改色", @"美容清洁"];
        NSArray *arr = [self.type componentsSeparatedByString:@","];
        for(int i=0; i<arr.count; i++) {
            NSInteger index = [arr[i] integerValue] - 1;
            if([ss isEqualToString:@""]) {
                ss = typeNameArr[index];
            }else {
                ss = [NSString stringWithFormat:@"%@,%@", ss, typeNameArr[index]];
            }
        }
        self.typeName = ss;
        
        
        NSString *all = @"";
        self.jishiAllName = @"无";
        if(dic[@"orderConstructionShow"] == nil || [dic[@"orderConstructionShow"] isKindOfClass:[NSNull class]]) {
            self.orderConstructionShow = @[];
            self.jishiAllName = @"无";
        }else {
            self.orderConstructionShow = dic[@"orderConstructionShow"];
            for(NSDictionary *dic in self.orderConstructionShow) {
            
                if([all isEqualToString:@""]) {
                
                    all = dic[@"techName"];
                }else {
                    
                    all = [NSString stringWithFormat:@"%@,%@", all, dic[@"techName"]];
                }
            }
            
            self.jishiAllName = all;
        }
        
        if(![dic[@"comment"] isKindOfClass:[NSDictionary class]]) {
            self.comment = nil;
            self.commentStr = @"无";
        }else {
            self.comment = dic[@"comment"];
            self.commentStr = @"有";
        }
        
        if(![dic[@"constructionWasteShows"] isKindOfClass:[NSArray class]]) {
            self.constructionWasteShows = @[];
        }else {
            self.constructionWasteShows = dic[@"constructionWasteShows"];
        }
        
    }
    
    return self;
}




@end
