//
//  CLTeamPeopleModel.m
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLTeamPeopleModel.h"

@implementation CLTeamPeopleModel

- (void)setModelDataForDictionary:(NSDictionary *)dictionary{
    self.avatar = dictionary[@"avatar"];
    self.bank = dictionary[@"bank"];
    self.bankAddress = dictionary[@"bankAddress"];
    self.bankCardNo = dictionary[@"bankCardNo"];
    self.beautyLevel = [NSString stringWithFormat:@"%@",dictionary[@"beautyLevel"]];
    self.beautyWorkingSeniority = [NSString stringWithFormat:@"%@",dictionary[@"beautyWorkingSeniority"]];
    self.carCoverLevel = [NSString stringWithFormat:@"%@",dictionary[@"carCoverLevel"]];
    self.carCoverWorkingSeniority = [NSString stringWithFormat:@"%@",dictionary[@"carCoverWorkingSeniority"]];
    self.colorModifyLevel = [NSString stringWithFormat:@"%@",dictionary[@"colorModifyLevel"]];
    self.colorModifyWorkingSeniority = [NSString stringWithFormat:@"%@",dictionary[@"colorModifyWorkingSeniority"]];
    self.filmLevel = [NSString stringWithFormat:@"%@",dictionary[@"filmLevel"]];
    self.filmWorkingSeniority = [NSString stringWithFormat:@"%@",dictionary[@"filmWorkingSeniority"]];
    self.idString = [NSString stringWithFormat:@"%@",dictionary[@"id"]];
    self.idNo = dictionary[@"idNo"];
    self.idPhoto = dictionary[@"idPhoto"];
    self.name = dictionary[@"name"];
    self.phone = dictionary[@"phone"];
    self.resume = dictionary[@"resume"];
    self.skill = dictionary[@"skill"];
    self.teamId = [NSString stringWithFormat:@"%@",dictionary[@"teamId"]];
    self.workStatus = [NSString stringWithFormat:@"%@",dictionary[@"workStatus"]];
    if ([self.workStatus isEqualToString:@"1"]) {
        self.workStatusString = @"可接单";
    }else if([self.workStatusString isEqualToString:@"2"]){
        self.workStatusString = @"工作中";
    }else if([self.workStatusString isEqualToString:@"3"]){
        self.workStatusString = @"休息中";
    }
}

@end
