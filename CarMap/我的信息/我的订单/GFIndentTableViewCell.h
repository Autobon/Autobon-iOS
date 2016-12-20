//
//  GFIndentTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class GFIndentModel;
@class GFNewOrderModel;

@interface GFIndentTableViewCell : UITableViewCell


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
