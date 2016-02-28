//
//  CLPersonTableViewCell.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLPersonTableViewCell.h"

@implementation CLPersonTableViewCell




- (void)setCell{
    
//头像
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 80, 80)];
    headImage.image = [UIImage imageNamed:@"userHeadImage"];
    headImage.layer.cornerRadius = 40;
    headImage.clipsToBounds = YES;
    [self addSubview:headImage];
    
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 100, 40)];
    userNameLabel.text = @"林峰";
    userNameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self addSubview:userNameLabel];
    
    UILabel *identityLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, 100, 40)];
    identityLabel.text = @"订单数 20";
    identityLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self addSubview:identityLabel];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 30, 60, 40)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    button.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 10;
    
    [self addSubview:button];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
