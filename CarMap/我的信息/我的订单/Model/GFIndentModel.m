//
//  GFIndentModel.m
//  CarMap
//
//  Created by 陈光法 on 16/3/8.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFIndentModel.h"

@implementation GFIndentModel


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    
    if(self != nil) {
        
        if(dic[@""] == nil) {
        
            _orderNum = [NSString stringWithFormat:@"无"];
        }else {
            
            _orderNum = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        
        if(dic[@""] == nil) {
            
            self.payment = [NSString stringWithFormat:@"无"];
        }else {
            
            self.payment = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.payStatus = [NSString stringWithFormat:@"无"];
        }else {
            
            self.payStatus = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.photo = [NSString stringWithFormat:@"无"];
        }else {
            
            self.photo = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.signinTime = [NSString stringWithFormat:@"无"];
        }else {
            
            self.signinTime = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.workItems = [NSString stringWithFormat:@"无"];
        }else {
            
            self.workItems = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.remark = [NSString stringWithFormat:@"无"];
        }else {
            
            self.remark = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        
        if(dic[@""] == nil) {
            
            self.workTime = [NSString stringWithFormat:@"无"];
        }else {
            
            self.workTime = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.indentType = [NSString stringWithFormat:@"无"];
        }else {
            
            self.indentType = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.beforePhotos = [NSString stringWithFormat:@"无"];
        }else {
            
            self.beforePhotos = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.afterPhotos = [NSString stringWithFormat:@"无"];
        }else {
            
            self.afterPhotos = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        if(dic[@""] == nil) {
            
            self.orderStatus = [NSString stringWithFormat:@"无"];
        }else {
            
            self.orderStatus = [NSString stringWithFormat:@"%@", dic[@""]];
        }
        
        if(dic[@""] != nil) {
        
            self.commentDictionary = dic[@""];
        }
        
        if(dic[@""] != nil) {
        
            self.workerArr = dic[@""];
        }
    }
    
    return self;
}


@end
