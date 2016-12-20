//
//  CLNewOrderTableViewCell.h
//  CarMap
//
//  Created by 李孟龙 on 16/4/21.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CLImageView.h"

@class CLListNewModel;

@interface CLNewOrderTableViewCell : UITableViewCell


@property (nonatomic ,strong) UILabel *orderNumberLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UIButton *orderButton;
@property (nonatomic ,strong) UIImageView *orderImageView;
@property (nonatomic ,strong) UILabel *typeLabel;
@property (nonatomic, copy) NSString *orderTypeLabelText;

- (void)initWithOrder;


@property (nonatomic, strong) CLListNewModel *model;

@end
