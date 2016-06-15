//
//  CLHomeTableViewCell.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLHomeTableViewCell : UITableViewCell

@property (nonatomic ,strong) UILabel *orderNumberLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UIButton *orderButton;
@property (nonatomic ,strong) UIImageView *orderImageView;
@property (nonatomic ,strong) UILabel *orderTypeLabel;



- (void)initWithOrder;



@end
