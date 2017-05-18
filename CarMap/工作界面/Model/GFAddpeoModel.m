//
//  GFAddpeoModel.m
//  CarMap
//
//  Created by 陈光法 on 16/12/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFAddpeoModel.h"

@implementation GFAddpeoModel






- (instancetype)initWithdictionary:(NSDictionary *)dic {
    
    self = [super init];
    
    if(self != nil) {
        
        self.name = [NSString stringWithFormat:@"%@", dic[@"name"]];
        self.avatar = [NSString stringWithFormat:@"%@", dic[@"avatar"]];
        self.jishiId = [NSString stringWithFormat:@"%@", dic[@"id"]];
        self.phone = [NSString stringWithFormat:@"%@", dic[@"phone"]];
    }
    
    return self;
}


@end
