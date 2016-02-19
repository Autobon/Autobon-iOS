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
        UILabel *orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 250, 30)];
//        orderNumberLabel.textAlignment = NSTextAlignmentCenter;
        orderNumberLabel.text = @"订单编号CLB280050900001";
        orderNumberLabel.font = [UIFont systemFontOfSize:16.0];
//        orderNumberLabel.backgroundColor = [UIColor cyanColor];
        [self addSubview:orderNumberLabel];
        
// 预约时间
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 200, 30)];
        timeLabel.text = @"预约时间 今天 12:00";
        timeLabel.font = [UIFont systemFontOfSize:16.0];
//        timeLabel.backgroundColor = [UIColor cyanColor];
        [self addSubview:timeLabel];
        
// 进入订单按钮
        UIButton *orderButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-100, 20, 80, 40)];
        [orderButton setTitle:@"进入订单" forState:UIControlStateNormal];
//        orderButton.backgroundColor = [UIColor greenColor];
    orderButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    orderButton.layer.borderWidth = 1.0f;
    orderButton.layer.cornerRadius = 10;
    [orderButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self addSubview:orderButton];
        
// 订单图片
        UIImageView *orderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, self.frame.size.width-20, 150)];
        orderImageView.image = [UIImage imageNamed:@"orderImage"];
//        orderImageView.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [self addSubview:orderImageView];
        
        
//    }
//    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
