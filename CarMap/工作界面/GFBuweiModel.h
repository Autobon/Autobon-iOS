//
//  GFBuweiModel.h
//  CarMap
//
//  Created by 陈光法 on 16/11/10.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFBuweiModel : NSObject

@property (nonatomic, strong) NSMutableArray *buweiDicArr;
@property (nonatomic, copy) NSString *proId;
@property (nonatomic, copy) NSString *proName;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
