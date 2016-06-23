//
//  CLHomeTableViewCell.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLNewOrderTableViewCell.h"

@implementation CLNewOrderTableViewCell

- (void)initWithOrder{
    //    if (self = [super init]) {
    //    self.backgroundColor = [UIColor cyanColor];
    
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.frame = CGRectMake(10, 5, 250, 30);
//    _typeLabel.text = @"美容清洁";
    _typeLabel.font = [UIFont systemFontOfSize:14.0];
    _typeLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self addSubview:_typeLabel];
    
    
    // 订单编号
    _orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 250, 30)];
    //     orderNumberLabel.textAlignment = NSTextAlignmentCenter;
    //    _orderNumberLabel.text = @"订单编号CLB280050900001";
    _orderNumberLabel.font = [UIFont systemFontOfSize:14.0];
    //    orderNumberLabel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_orderNumberLabel];
    
    // 预约时间
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 250, 30)];
    //    _timeLabel.text = @"预约时间 今天 12:00";
    _timeLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
    _timeLabel.font = [UIFont systemFontOfSize:15.0];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_timeLabel];
    
    // 进入订单按钮
    _orderButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _orderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-80, 15, 70, 30);
    [_orderButton setTitle:@"进入订单" forState:UIControlStateNormal];
    
    //    orderButton.backgroundColor = [UIColor greenColor];
    _orderButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _orderButton.layer.borderWidth = 1.0f;
    _orderButton.layer.cornerRadius = 5;
    [_orderButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self addSubview:_orderButton];
    
    // 订单图片
    _orderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.width*5/12-20)];
    _orderImageView.image = [UIImage imageNamed:@"orderImage"];
    //    orderImageView.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    _orderImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_orderImageView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 73 + [UIScreen mainScreen].bounds.size.width*5/12, [UIScreen mainScreen].bounds.size.width-20, 1)];
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
