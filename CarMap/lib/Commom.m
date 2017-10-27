//
//  Commom.m
//  CarMap
//
//  Created by inCar on 2017/10/24.
//  Copyright © 2017年 mll. All rights reserved.
//

#import "Commom.h"

@implementation Commom


#pragma mark - 整数验证
+ (BOOL) validateInt: (NSString *)string
{
    BOOL flag;
    if (string.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(0|[1-9][0-9]*)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:string];
}

#pragma mark - 证书和浮点数验证
+ (BOOL) validateIntAndFloat: (NSString *)string
{
    BOOL flag;
    if (string.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^[0-9]+(.[0-9]{1,2})?$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:string];
}


#pragma mark - 身份证号正则表达式
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

@end
