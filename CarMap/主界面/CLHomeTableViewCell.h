//
//  CLHomeTableViewCell.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFNewOrderModel;

@interface CLHomeTableViewCell : UITableViewCell

@property (nonatomic ,strong) UIButton *orderNumberLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UIButton *orderButton;
@property (nonatomic ,strong) UIImageView *orderImageView;
@property (nonatomic ,strong) UILabel *orderTypeLabel;

@property (nonatomic, copy) NSString *orderTypeLabelText;

- (void)initWithOrder;


//@property (nonatomic, strong) UILabel *numberLab;
//@property (nonatomic, strong) UILabel *moneyLab;
//@property (nonatomic, strong) UILabel *tipLabel;
//@property (nonatomic, strong) UIImageView *photoImgView;
//@property (nonatomic, strong) UILabel *timeLab;
//@property (nonatomic, strong) UILabel *placeLab;
////@property (nonatomic, strong) GFIndentModel *model;
//@property (nonatomic, strong) GFNewOrderModel *model;
//@property (nonatomic, strong) NSString *workItems;

@end
