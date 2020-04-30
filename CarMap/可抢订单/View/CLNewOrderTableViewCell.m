//
//  CLHomeTableViewCell.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLNewOrderTableViewCell.h"

#import "CLListNewModel.h"

@interface CLNewOrderTableViewCell()

@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;


@end


@implementation CLNewOrderTableViewCell

- (void)setModel:(CLListNewModel *)model {
    
    _model = model;
    
    
//    _orderNumberLabel.text = [NSString stringWithFormat:@"订单编号%@", model.orderNumber];
    
}

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
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self != nil) {
        self.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
        view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.contentView addSubview:view];
        
        
        // 订单编号
        _orderNumberLabel = [[UILabel alloc] init];
        _orderNumberLabel.frame = CGRectMake(10, 10, 250, 25);
        _orderNumberLabel.font = [UIFont systemFontOfSize:14.0];
        _orderNumberLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_orderNumberLabel];
        
        
        for(int i=0; i<4; i++) {
            
            UILabel *lab = [[UILabel alloc] init];
            lab.frame = CGRectMake(11 + 72 * i, 48, 65, 27);
            //            lab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.9];
            lab.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
            lab.font = [UIFont systemFontOfSize:13];
            //            lab.textColor = [UIColor whiteColor];
            lab.textColor = [UIColor darkGrayColor];
            lab.layer.cornerRadius = 7;
            lab.clipsToBounds = YES;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.text = @"美容清洁";
            [self.contentView addSubview:lab];
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
        [self.contentView addSubview:lineView];
        
        // 预约时间
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame) + 10, 250, 25);
        //    _timeLabel.text = @"预约时间 今天 12:00";
        _timeLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        //    timeLabel.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_timeLabel];
        
        // 进入订单按钮
        _orderButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _orderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 15, 70, 28);
        [_orderButton setTitle:@"抢单" forState:UIControlStateNormal];
        _orderButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        _orderButton.layer.borderWidth = 1.0f;
        _orderButton.layer.cornerRadius = 5;
        [_orderButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self.contentView addSubview:_orderButton];
        
        // 订单图片
        /*
         _orderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.width*5/12-20)];
         _orderImageView.image = [UIImage imageNamed:@"orderImage"];
         //    orderImageView.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
         _orderImageView.contentMode = UIViewContentModeScaleAspectFit;
         [self addSubview:_orderImageView];
         */
        
        //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 89, [UIScreen mainScreen].bounds.size.width-20, 1)];
        //    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        //    [vv addSubview:view];
        
        
    }
    
    return self;
}


- (void)initWithOrder{
    //    if (self = [super init]) {
    //    self.backgroundColor = [UIColor cyanColor];
    
    
    
    
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
