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
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 80, 80)];
    _headImage.image = [UIImage imageNamed:@"userHeadImage"];
    _headImage.layer.cornerRadius = 40;
    _headImage.clipsToBounds = YES;
    [self addSubview:_headImage];
    
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 200, 40)];
//    _userNameLabel.text = @"林峰";
    _userNameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self addSubview:_userNameLabel];
    
   _identityLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, 120, 40)];
//    _identityLabel.text = @"15836163101";
    _identityLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self addSubview:_identityLabel];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 35, 60, 30)];
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    _button.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _button.layer.borderWidth = 1.0f;
    _button.layer.cornerRadius = 10;
    
    [self addSubview:_button];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 98, [UIScreen mainScreen].bounds.size.width, 2)];
    lineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:lineView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
