//
//  CLCollectTableViewCell.h
//  CarMapB
//
//  Created by inCar on 17/5/19.
//  Copyright © 2017年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCooperatorModel.h"

@interface CLCollectTableViewCell : UITableViewCell
{
    UILabel *_nameLab;
    UILabel *_peopleLab;
    UILabel *_phoneLab;
}
@property (nonatomic ,strong) CLCooperatorModel *model;
@property (nonatomic ,strong) UIButton *removeButton;


@end
