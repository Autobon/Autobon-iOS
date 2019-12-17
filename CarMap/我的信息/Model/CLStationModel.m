//
//  CLStationModel.m
//  CarMap
//
//  Created by inCarL on 2019/12/16.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLStationModel.h"

@implementation CLStationModel

- (void)setModelForDataDictionary:(NSDictionary *)dataDictionary{
    self.address = [NSString stringWithFormat:@"%@", dataDictionary[@"address"]];
    if ([self.address isEqualToString:@"<null>"]){
        self.address = @"无";
    }
    self.coopId = [NSString stringWithFormat:@"%@", dataDictionary[@"coopId"]];
    self.coopName = [NSString stringWithFormat:@"%@", dataDictionary[@"coopName"]];
    self.latitude = [NSString stringWithFormat:@"%@", dataDictionary[@"latitude"]];
    self.longitude = [NSString stringWithFormat:@"%@", dataDictionary[@"longitude"]];
}


@end
