//
//  CLTeamPeopleModel.h
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLTeamPeopleModel : NSObject

@property (nonatomic ,strong) NSString *avatar;
@property (nonatomic ,strong) NSString *bank;
@property (nonatomic ,strong) NSString *bankAddress;
@property (nonatomic ,strong) NSString *bankCardNo;
@property (nonatomic ,strong) NSString *beautyLevel;
@property (nonatomic ,strong) NSString *beautyWorkingSeniority;
@property (nonatomic ,strong) NSString *carCoverLevel;
@property (nonatomic ,strong) NSString *carCoverWorkingSeniority;
@property (nonatomic ,strong) NSString *colorModifyLevel;
@property (nonatomic ,strong) NSString *colorModifyWorkingSeniority;
@property (nonatomic ,strong) NSString *filmLevel;
@property (nonatomic ,strong) NSString *filmWorkingSeniority;
@property (nonatomic ,strong) NSString *idString;
@property (nonatomic ,strong) NSString *idNo;
@property (nonatomic ,strong) NSString *idPhoto;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) NSString *resume;
@property (nonatomic ,strong) NSString *skill;
@property (nonatomic ,strong) NSString *teamId;
@property (nonatomic ,strong) NSString *workStatus;
@property (nonatomic ,strong) NSString *workStatusString;


- (void)setModelDataForDictionary:(NSDictionary *)dictionary;

@end
