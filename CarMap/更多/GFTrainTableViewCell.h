//
//  GFTrainTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTrainTableViewCell : UITableViewCell


@property (nonatomic, copy) NSString *xiangmuStr;
@property (nonatomic, copy) NSString *dengjiStr;
@property (nonatomic, copy) NSString *riqiStr;
@property (nonatomic, copy) NSString *otherStr;

@property (nonatomic, assign) NSInteger cellHeight;


@end
