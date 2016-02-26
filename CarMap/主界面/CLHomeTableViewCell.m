//
//  CLHomeTableViewCell.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLHomeTableViewCell.h"

@implementation CLHomeTableViewCell

- (void)initWithOrder{
//    if (self = [super init]) {
//    self.backgroundColor = [UIColor cyanColor];
// 订单编号
    _orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 250, 30)];
//     orderNumberLabel.textAlignment = NSTextAlignmentCenter;
    _orderNumberLabel.text = @"订单编号CLB280050900001";
    _orderNumberLabel.font = [UIFont systemFontOfSize:16.0];
//    orderNumberLabel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_orderNumberLabel];
        
// 预约时间
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 250, 30)];
    _timeLabel.text = @"预约时间 今天 12:00";
    _timeLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
    _timeLabel.font = [UIFont systemFontOfSize:16.0];
//    timeLabel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_timeLabel];
        
// 进入订单按钮
    _orderButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _orderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 20, 80, 40);
    [_orderButton setTitle:@"进入订单" forState:UIControlStateNormal];
    
//    orderButton.backgroundColor = [UIColor greenColor];
    _orderButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _orderButton.layer.borderWidth = 1.0f;
    _orderButton.layer.cornerRadius = 10;
    [_orderButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self addSubview:_orderButton];
        
// 订单图片
    _orderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.width*5/12)];
    _orderImageView.image = [UIImage imageNamed:@"orderImage"];
//    orderImageView.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:_orderImageView];
        
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 78 + [UIScreen mainScreen].bounds.size.width*5/12, [UIScreen mainScreen].bounds.size.width-20, 2)];
    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self addSubview:view];

    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
