//
//  CLTitleTableViewCell.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLTitleTableViewCell.h"

@implementation CLTitleTableViewCell


- (void)initWithTitle{
//    if (self = [super init]) {
//        self.backgroundColor = [UIColor redColor];
//标题label
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, [UIScreen mainScreen].bounds.size.width-20, 40)];
    _titleLable.text = @"未完成的订单数：0";
//    _titleLable.textColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1.0];
//    _titleLable.font = [UIFont systemFontOfSize:19];
//    _titleLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLable];
        
//详情标题
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, [UIScreen mainScreen].bounds.size.width, 30)];
    _detailLabel.text = @"今日完成订单数：0    共计金额：0";
//    _detailLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
//    _detailLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_detailLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 83, [UIScreen mainScreen].bounds.size.width-20, 1)];
    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self addSubview:view];
        
//    }
//    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
