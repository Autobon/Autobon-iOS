//
//  CLTeamTableViewCell.h
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTeamModel.h"


@interface CLTeamTableViewCell : UITableViewCell
{
    UILabel *_teamNameLabel;
    UILabel *_managerNameLabel;
    UILabel *_managerPhoneLabel;
}
@property (nonatomic ,strong) CLTeamModel *teamModel;


@end
