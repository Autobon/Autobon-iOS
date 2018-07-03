//
//  CLOrderForWaitNewTableViewCell.h
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLHomeOrderCellModel.h"

@interface CLOrderForWaitNewTableViewCell : UITableViewCell
{
    UILabel *_detailLabel;
}
@property (nonatomic, strong) CLHomeOrderCellModel *model;
@property (nonatomic ,strong) UIButton *orderButton;

@end
