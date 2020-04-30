//
//  CLChooseView.m
//  CarMapB
//
//  Created by inCar on 2018/6/15.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLChooseView.h"
#import "Masonry.h"

@implementation CLChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (void)setDateView{
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(200);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"选择时间";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [baseView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView).offset(20);
        make.top.equalTo(baseView).offset(0);
        make.height.mas_offset(40);
    }];
    
    _trueButton = [[UIButton alloc]init];
    [_trueButton setTitle:@"确定" forState:UIControlStateNormal];
    [_trueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _trueButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [baseView addSubview:_trueButton];
    [_trueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(baseView).offset(-20);
        make.top.equalTo(baseView);
        make.height.mas_offset(40);
        make.width.mas_offset(60);
    }];
    
    _datePickerView = [[UIDatePicker alloc]init];
    _datePickerView.datePickerMode = UIDatePickerModeDate;
    [_datePickerView setDate:[NSDate date] animated:YES];
    [_datePickerView setValue:[UIColor blackColor] forKey:@"textColor"];
    [self addSubview:_datePickerView];
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(150);
    }];
    
    
    
    
    
    
}





@end
