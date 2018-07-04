//
//  CLTeamModel.m
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLTeamModel.h"

@implementation CLTeamModel

- (void)setModelDataWithDictionary:(NSDictionary *)dictionary{
    self.idString = [NSString stringWithFormat:@"%@",dictionary[@"id"]];
    self.managerId = [NSString stringWithFormat:@"%@",dictionary[@"managerId"]];
    self.managerName = dictionary[@"managerName"];
    self.managerPhone = dictionary[@"managerPhone"];
    self.name = dictionary[@"name"];
}


@end
