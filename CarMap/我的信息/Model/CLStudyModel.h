//
//  CLStudyModel.h
//  CarMap
//
//  Created by inCar on 2018/6/19.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLStudyModel : NSObject

@property (nonatomic ,strong) NSString *fileName;
@property (nonatomic ,strong) NSString *idString;
@property (nonatomic ,strong) NSString *path;
@property (nonatomic ,strong) NSString *remark;
@property (nonatomic ) int type;
@property (nonatomic ,strong) NSString *typeString;

- (void)setModelForDataWithDictionary:(NSDictionary *)dataDictionary;



@end
