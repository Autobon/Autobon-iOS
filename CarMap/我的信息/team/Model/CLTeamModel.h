//
//  CLTeamModel.h
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLTeamModel : NSObject

@property (nonatomic ,strong) NSString *idString;
@property (nonatomic ,strong) NSString *managerId;
@property (nonatomic ,strong) NSString *managerName;
@property (nonatomic ,strong) NSString *managerPhone;
@property (nonatomic ,strong) NSString *name;

- (void)setModelDataWithDictionary:(NSDictionary *)dictionary;

@end
