//
//  CLHomeTableViewCell.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLHomeTableViewCell.h"
#import "CLImageView.h"
#import "GFIndentModel.h"
#import "GFNewOrderModel.h"


@interface CLHomeTableViewCell()

@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;


@end

@implementation CLHomeTableViewCell


- (void)setOrderTypeLabelText:(NSString *)orderTypeLabelText {
    
    _orderTypeLabelText = orderTypeLabelText;
    
    self.lab1.hidden = NO;
    self.lab2.hidden = NO;
    self.lab3.hidden = NO;
    self.lab4.hidden = NO;
    
    
    NSArray *arr = [orderTypeLabelText componentsSeparatedByString:@","];
    if(arr.count == 1) {
        self.lab1.text = arr[0];
        
        self.lab2.hidden = YES;
        self.lab3.hidden = YES;
        self.lab4.hidden = YES;
    }else if(arr.count == 2){
        
        self.lab1.text = arr[0];
        self.lab2.text = arr[1];
        
        self.lab3.hidden = YES;
        self.lab4.hidden = YES;
    }else if(arr.count == 3){
        
        self.lab1.text = arr[0];
        self.lab2.text = arr[1];
        self.lab3.text = arr[2];
        
        self.lab4.hidden = YES;
    }else if(arr.count == 4){
        
        self.lab1.text = arr[0];
        self.lab2.text = arr[1];
        self.lab3.text = arr[2];
        self.lab4.text = arr[3];
    }
    
    
    self.orderTypeLabel.text = orderTypeLabelText;
}

- (void)initWithOrder{
    
    self.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self addSubview:view];
    
//    _orderTypeLabel = [[UILabel alloc] init];
//    _orderTypeLabel.frame = CGRectMake(10, 10, 250, 25);
//    _orderTypeLabel.font = [UIFont systemFontOfSize:14.0];
//    _orderTypeLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
////    _orderTypeLabel.backgroundColor = [UIColor greenColor];
//    [self addSubview:_orderTypeLabel];

// 订单编号
    _orderNumberLabel = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 300, 25)];
    _orderNumberLabel.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _orderNumberLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_orderNumberLabel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _orderNumberLabel.enabled = NO;
//    _orderNumberLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_orderNumberLabel];
    
    
    for(int i=0; i<4; i++) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(11 + 72 * i, 53, 65, 27);
        //            lab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.9];
        lab.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
        lab.font = [UIFont systemFontOfSize:13];
        //            lab.textColor = [UIColor whiteColor];
        lab.textColor = [UIColor darkGrayColor];
        lab.layer.cornerRadius = 7;
        lab.clipsToBounds = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"美容清洁";
        [view addSubview:lab];
        //            lab.hidden = YES;
        //            [self.labArr addObject:lab];
        if(i == 0) {
            self.lab1 = lab;
        }
        if(i == 1) {
            self.lab2 = lab;
        }
        if(i == 2) {
            self.lab3 = lab;
        }
        if(i == 3) {
            self.lab4 = lab;
        }
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(11, 95, [UIScreen mainScreen].bounds.size.width - 22, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [view addSubview:lineView];
    
// 预约时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame) + 10, 250, 25);
    _timeLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
    _timeLabel.font = [UIFont systemFontOfSize:12.0];
//    _timeLabel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_timeLabel];
    
// 进入订单按钮
    _orderButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _orderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-80, 18, 70, 28);
    [_orderButton setTitle:@"进入订单" forState:UIControlStateNormal];
    _orderButton.titleLabel.font = [UIFont systemFontOfSize:13.5];
    _orderButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _orderButton.layer.borderWidth = 1.0f;
    _orderButton.layer.cornerRadius = 5;
    [_orderButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self addSubview:_orderButton];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
