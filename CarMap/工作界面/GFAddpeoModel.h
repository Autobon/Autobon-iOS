//
//  GFAddpeoModel.h
//  CarMap
//
//  Created by 陈光法 on 16/12/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFAddpeoModel : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *jishiId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;


- (instancetype)initWithdictionary:(NSDictionary *)dic;

@end
