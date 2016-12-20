//
//  GFAddPeoTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/12/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFAddpeoModel;

@interface GFAddPeoTableViewCell : UITableViewCell

@property (nonatomic, strong) GFAddpeoModel *model;

@property (nonatomic, strong) UIButton *addBut;
@end
