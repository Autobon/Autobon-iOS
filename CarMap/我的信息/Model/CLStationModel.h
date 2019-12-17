//
//  CLStationModel.h
//  CarMap
//
//  Created by inCarL on 2019/12/16.
//  Copyright © 2019 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLStationModel : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *coopId;
@property (nonatomic, strong) NSString *coopName;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

- (void)setModelForDataDictionary:(NSDictionary *)dataDictionary;

@end

NS_ASSUME_NONNULL_END
