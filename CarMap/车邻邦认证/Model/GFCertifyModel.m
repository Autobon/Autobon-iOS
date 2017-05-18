//
//  GFCertifyModel.m
//  CarMap
//
//  Created by 陈光法 on 16/11/30.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFCertifyModel.h"

@implementation GFCertifyModel



- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    
    if(self != nil) {
        
        if(dic[@"avatar"] != nil) {
            self.avatar = [NSString stringWithFormat:@"%@", dic[@"avatar"]];
        }else {
            self.avatar = @"无";
        }
        
        if(dic[@"name"] != nil) {
            self.name = [NSString stringWithFormat:@"%@", dic[@"name"]];
        }else {
            self.name = @"无";
        }
        
        if(dic[@"idNo"] != nil) {
            self.idNo = [NSString stringWithFormat:@"%@", dic[@"idNo"]];
        }else {
            self.idNo = @"无";
        }
     
        if(dic[@"reference"] != nil) {
            self.reference = [NSString stringWithFormat:@"%@", dic[@"reference"]];
        }else {
            self.reference = @"无";
        }
        
        
        if(dic[@"bank"] != nil) {
            self.bank = [NSString stringWithFormat:@"%@", dic[@"bank"]];
        }else {
            self.bank = @"无";
        }
        
        
        if(dic[@"bankAddress"] != nil) {
            self.bankAddress = [NSString stringWithFormat:@"%@", dic[@"bankAddress"]];
        }else {
            self.bankAddress = @"无";
        }
        
        
        if(dic[@"bankCardNo"] != nil) {
            self.bankCardNo = [NSString stringWithFormat:@"%@", dic[@"bankCardNo"]];
        }else {
            self.bankCardNo = @"无";
        }
        
        
        if(dic[@"resume"] != nil) {
            self.resume = [NSString stringWithFormat:@"%@", dic[@"resume"]];
        }else {
            self.resume = @"无";
        }
        
        if(dic[@"filmLevel"] != nil) {
            self.filmLevel = [NSString stringWithFormat:@"%@", dic[@"filmLevel"]];
        }else {
            self.filmLevel = @"无";
        }
        if(dic[@"filmWorkingSeniority"] != nil) {
            self.filmWorkingSeniority = [NSString stringWithFormat:@"%@", dic[@"filmWorkingSeniority"]];
        }else {
            self.filmWorkingSeniority = @"无";
        }
        
        if(dic[@"carCoverLevel"] != nil) {
            self.carCoverLevel = [NSString stringWithFormat:@"%@", dic[@"carCoverLevel"]];
        }else {
            self.carCoverLevel = @"无";
        }
        if(dic[@"carCoverWorkingSeniority"] != nil) {
            self.carCoverWorkingSeniority = [NSString stringWithFormat:@"%@", dic[@"carCoverWorkingSeniority"]];
        }else {
            self.carCoverWorkingSeniority = @"无";
        }
        
        if(dic[@"colorModifyLevel"] != nil) {
            self.colorModifyLevel = [NSString stringWithFormat:@"%@", dic[@"colorModifyLevel"]];
        }else {
            self.colorModifyLevel = @"无";
        }
        
        if(dic[@"colorModifyWorkingSeniority"] != nil) {
            self.colorModifyWorkingSeniority = [NSString stringWithFormat:@"%@", dic[@"colorModifyWorkingSeniority"]];
        }else {
            self.colorModifyWorkingSeniority = @"无";
        }
        
        if(dic[@"beautyLevel"] != nil) {
            self.beautyLevel = [NSString stringWithFormat:@"%@", dic[@"beautyLevel"]];
        }else {
            self.beautyLevel = @"无";
        }
        
        if(dic[@"beautyWorkingSeniority"] != nil) {
            self.beautyWorkingSeniority = [NSString stringWithFormat:@"%@", dic[@"beautyWorkingSeniority"]];
        }else {
            self.beautyWorkingSeniority = @"无";
        }
        
        if(dic[@"idPhoto"] != nil) {
            self.idPhoto = [NSString stringWithFormat:@"%@", dic[@"idPhoto"]];
        }else {
            self.idPhoto = @"无";
        }
        
        if(dic[@"status"] != nil) {
            self.status = [NSString stringWithFormat:@"%@", dic[@"status"]];
        }else {
            self.status = @"无";
        }
        
        if(dic[@"verifyMsg"] != nil) {
            self.verifyMsg = [NSString stringWithFormat:@"%@", dic[@"verifyMsg"]];
        }else {
            self.verifyMsg = @"无";
        }
    }
    
    return self;
}


@end
