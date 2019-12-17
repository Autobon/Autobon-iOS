//
//  GFCertifyModel.h
//  CarMap
//
//  Created by 陈光法 on 16/11/30.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFCertifyModel : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *idNo;
@property (nonatomic, copy) NSString *reference;

@property (nonatomic, copy) NSString *bank;
@property (nonatomic, copy) NSString *bankAddress;
@property (nonatomic, copy) NSString *bankCardNo;
@property (nonatomic, copy) NSString *resume;

@property (nonatomic, copy) NSString *filmLevel;
@property (nonatomic, copy) NSString *filmWorkingSeniority;
@property (nonatomic, copy) NSString *carCoverLevel;
@property (nonatomic, copy) NSString *carCoverWorkingSeniority;
@property (nonatomic, copy) NSString *colorModifyLevel;
@property (nonatomic, copy) NSString *colorModifyWorkingSeniority;
@property (nonatomic, copy) NSString *beautyLevel;
@property (nonatomic, copy) NSString *beautyWorkingSeniority;

@property (nonatomic, copy) NSString *idPhoto;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *verifyMsg;

@property (nonatomic, copy) NSString *signStatus;
@property (nonatomic, copy) NSString *stationCoopId;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
