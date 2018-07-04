//
//  CLTeamPeopleTableViewCell.h
//  CarMap
//
//  Created by inCar on 2018/7/4.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTeamPeopleModel.h"



@interface CLTeamPeopleTableViewCell : UITableViewCell
{
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    UILabel *_statusLabel;
    UILabel *_filmLevelLabel;
    UILabel *_carCoverLevelLabel;
    UILabel *_colorModifyLevelLabel;
    UILabel *_beautyLevelLabel;
}

@property (nonatomic ,strong) CLTeamPeopleModel *teamPeopleModel;

@end
