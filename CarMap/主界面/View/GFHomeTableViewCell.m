//
//  GFHomeTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/12/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFHomeTableViewCell.h"
#import "GFNewOrderModel.h"

@interface GFHomeTableViewCell()

@property (nonatomic, strong) UILabel *orderLab;
@property (nonatomic, strong) UILabel *proLab;
@property (nonatomic, strong) UILabel *workTimeLab;

@property (nonatomic, strong) UILabel *mLab;
@property (nonatomic, strong) UILabel *statusLab;

@property (nonatomic, strong) NSMutableArray *labArr;

@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;

@end

@implementation GFHomeTableViewCell

- (void)setModel:(GFNewOrderModel *)model {
    
//    NSLog(@"++++=====++++");
    
    _model = model;
    
    self.mLab.hidden = NO;
    if([model.payStatus integerValue] == 1) {
        
        self.statusLab.text = @"已结算";
        self.mLab.text = [NSString stringWithFormat:@"合计：%@", model.payment];
    }else if(([model.payment integerValue] == 0) && ([model.payment integerValue] == 0)){
        
        self.statusLab.text = @"待计算";
        self.mLab.hidden = YES;
    }else {
        
        self.statusLab.text = @"未结算";
        self.mLab.text = [NSString stringWithFormat:@"合计：%@", model.payment];
    }
    
    self.orderLab.text = [NSString stringWithFormat:@"订单编号：%@", model.orderNum];
    self.workTimeLab.text = [NSString stringWithFormat:@"施工时间：%@", model.startTime];
    
    self.lab1.hidden = NO;
    self.lab2.hidden = NO;
    self.lab3.hidden = NO;
    self.lab4.hidden = NO;
    
    NSArray *arr = [model.typeName componentsSeparatedByString:@","];
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
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        UIView *vv = [[UIView alloc] init];
        vv.backgroundColor = [UIColor whiteColor];
        vv.frame = CGRectMake(-1, 10, [UIScreen mainScreen].bounds.size.width + 2, 130);
        vv.layer.borderColor = [[UIColor colorWithRed:217 / 255.0 green:217 / 255.0 blue:217 / 255.0 alpha:1] CGColor];
        vv.layer.borderWidth = 1;
        [self.contentView addSubview:vv];
        
        self.orderLab = [[UILabel alloc] initWithFrame:CGRectMake(11, 7, 300, 25)];
        self.orderLab.text = @"订单编号：999999999999999";
        self.orderLab.textColor = [UIColor darkGrayColor];
        self.orderLab.font = [UIFont systemFontOfSize:14];
        [vv addSubview:self.orderLab];
        
        for(int i=0; i<4; i++) {
            
            UILabel *lab = [[UILabel alloc] init];
            lab.frame = CGRectMake(11 + 72 * i, 40, 65, 30);
            //            lab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.9];
            lab.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
            lab.font = [UIFont systemFontOfSize:13];
            //            lab.textColor = [UIColor whiteColor];
            lab.textColor = [UIColor darkGrayColor];
            lab.layer.cornerRadius = 7;
            lab.clipsToBounds = YES;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.text = @"美容清洁";
            [vv addSubview:lab];
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
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(11, 85, [UIScreen mainScreen].bounds.size.width - 22, 1)];
        lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [vv addSubview:lineView];
        
        self.workTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(11, CGRectGetMaxY(lineView.frame) + 10, 300, 25)];
        self.workTimeLab.text = @"施工时间：2016-12-02 17:31";
        self.workTimeLab.textColor = [UIColor lightGrayColor];
        self.workTimeLab.font = [UIFont systemFontOfSize:13.5];
        [vv addSubview:self.workTimeLab];
        
        
        //        self.proLab = [[UILabel alloc] initWithFrame:CGRectMake(11, CGRectGetMaxY(self.workTimeLab.frame), 300, 25)];
        //        self.proLab.text = @"隔热膜，隐形车衣，车身改色，美容清洁";
        //        self.proLab.textColor = [UIColor orangeColor];
        //        self.proLab.font = [UIFont systemFontOfSize:15];
        //        [vv addSubview:self.proLab];
        
        self.statusLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 120, self.orderLab.frame.origin.y, 120, 25)];
        self.statusLab.text = @"已结算";
        self.statusLab.textAlignment = NSTextAlignmentRight;
        self.statusLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.statusLab.font = [UIFont systemFontOfSize:14];
        [vv addSubview:self.statusLab];
        
        self.mLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 120, self.workTimeLab.frame.origin.y, 120, 25)];
        self.mLab.text = @"合计:¥ 2000";
        self.mLab.textAlignment = NSTextAlignmentRight;
        self.mLab.textColor = [UIColor lightGrayColor];
        self.mLab.font = [UIFont systemFontOfSize:14.5];
        [vv addSubview:self.mLab];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.orderLab.frame) - 50, 7, 25, 25)];
        imgView.image = [UIImage imageNamed:@"jingbao"];
        [vv addSubview:imgView];
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
