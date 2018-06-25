//
//  CLStudyModel.m
//  CarMap
//
//  Created by inCar on 2018/6/19.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLStudyModel.h"

@implementation CLStudyModel

- (void)setModelForDataWithDictionary:(NSDictionary *)dataDictionary{
    self.fileName = dataDictionary[@"fileName"];
    self.idString = [NSString stringWithFormat:@"%@",dataDictionary[@"id"]];
    self.path = dataDictionary[@"path"];
    self.remark = dataDictionary[@"remark"];
    self.type = [dataDictionary[@"type"] intValue];
    if (self.type == 1) {
        self.typeString = @"培训资料";
    }else if(self.type == 2){
        self.typeString = @"施工标准";
    }else if(self.type == 3){
        self.typeString = @"业务规则";
    }
}


@end
