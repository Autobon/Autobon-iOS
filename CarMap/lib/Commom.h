//
//  Commom.h
//  CarMap
//
//  Created by inCar on 2017/10/24.
//  Copyright © 2017年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commom : NSObject

#pragma mark - 整数验证
+ (BOOL) validateInt: (NSString *)string;

#pragma mark - 证书和浮点数验证
+ (BOOL) validateIntAndFloat: (NSString *)string;

#pragma mark - 身份证号正则表达式
+ (BOOL) validateIdentityCard: (NSString *)identityCard;




@end
