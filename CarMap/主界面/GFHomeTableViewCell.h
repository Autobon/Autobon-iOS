//
//  GFHomeTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/12/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFNewOrderModel;

@interface GFHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *photoImgView;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *placeLab;
//@property (nonatomic, strong) GFIndentModel *model;
@property (nonatomic, strong) GFNewOrderModel *model;
@property (nonatomic, strong) NSString *workItems;


@end
