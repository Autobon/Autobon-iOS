//
//  GFTrainTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFTrainTableViewCell.h"

@implementation GFTrainTableViewCell





- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self != nil) {
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat baseViewW = kWidth - kWidth * 0.028 * 2.0;
        CGFloat baseViewH = 400;
        CGFloat baseViewX = kWidth * 0.028;
        CGFloat baseViewY = kHeight * 0.026;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        baseView.layer.borderWidth = 1;
        baseView.layer.borderColor = [[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1] CGColor];
        
        
        // 技能
        CGFloat lab1W = kWidth * 0.122;
        CGFloat lab1H = kHeight * 0.0287;
        CGFloat lab1X = kWidth * 0.032;
        CGFloat lab1Y = kHeight * 0.02864;
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1X, lab1Y, lab1W, lab1H)];
        [baseView addSubview:lab1];
        lab1.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab1.text = @"技能: ";
        NSString *lab1Str = @"隔热膜";
        NSMutableDictionary *lab1Dic = [[NSMutableDictionary alloc] init];
        lab1Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab1Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect1 = [lab1Str boundingRectWithSize:CGSizeMake(baseViewW - lab1W - lab1X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab1Dic context:nil];
        CGFloat contLab1W = baseViewW - lab1W - lab1X * 2;
        CGFloat contLab1H = fenRect1.size.height;
        CGFloat contLab1X = CGRectGetMaxX(lab1.frame);
        CGFloat contLab1Y = lab1Y;
        UILabel *contLab1 = [[UILabel alloc] initWithFrame:CGRectMake(contLab1X, contLab1Y, contLab1W, contLab1H)];
        contLab1.numberOfLines = 0;
        contLab1.text = lab1Str;
        contLab1.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [baseView addSubview:contLab1];
        
        
        
        // 时间
        CGFloat lab2W = kWidth * 0.122;
        CGFloat lab2H = kHeight * 0.0287;
        CGFloat lab2X = kWidth * 0.032;
        CGFloat lab2Y = CGRectGetMaxY(contLab1.frame) + kHeight * 0.02;
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab2X, lab2Y, lab2W, lab2H)];
        [baseView addSubview:lab2];
        lab2.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab2.text = @"时间: ";
        NSString *lab2Str = @"2015年12月24日";
        NSMutableDictionary *lab2Dic = [[NSMutableDictionary alloc] init];
        lab2Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab2Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect2 = [lab2Str boundingRectWithSize:CGSizeMake(baseViewW - lab1W - lab1X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab2Dic context:nil];
        CGFloat contLab2W = baseViewW - lab1W - lab1X * 2;
        CGFloat contLab2H = fenRect2.size.height;
        CGFloat contLab2X = CGRectGetMaxX(lab1.frame);
        CGFloat contLab2Y = lab2Y;
        UILabel *contLab2 = [[UILabel alloc] initWithFrame:CGRectMake(contLab2X, contLab2Y, contLab2W, contLab2H)];
        contLab2.numberOfLines = 0;
        contLab2.text = lab2Str;
        contLab2.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [baseView addSubview:contLab2];
        
        // 地点
        CGFloat lab3W = kWidth * 0.122;
        CGFloat lab3H = kHeight * 0.0287;
        CGFloat lab3X = kWidth * 0.032;
        CGFloat lab3Y = CGRectGetMaxY(lab2.frame) + kHeight * 0.02;
        UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(lab3X, lab3Y, lab3W, lab3H)];
        [baseView addSubview:lab3];
        lab3.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab3.text = @"地点: ";
        NSString *lab3Str = @"阿斯顿会计法律上看到几个卡时间的";
        NSMutableDictionary *lab3Dic = [[NSMutableDictionary alloc] init];
        lab3Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab3Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect3 = [lab3Str boundingRectWithSize:CGSizeMake(baseViewW - lab1W - lab1X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab3Dic context:nil];
        CGFloat contLab3W = baseViewW - lab1W - lab1X * 2;
        CGFloat contLab3H = fenRect3.size.height;
        CGFloat contLab3X = CGRectGetMaxX(lab2.frame);
        CGFloat contLab3Y = lab3Y;
        UILabel *contLab3 = [[UILabel alloc] initWithFrame:CGRectMake(contLab3X, contLab3Y, contLab3W, contLab3H)];
        contLab3.numberOfLines = 0;
        contLab3.text = lab3Str;
        contLab3.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [baseView addSubview:contLab3];
        
        
        // 内容
        CGFloat lab4W = kWidth * 0.122;
        CGFloat lab4H = kHeight * 0.0287;
        CGFloat lab4X = kWidth * 0.032;
        CGFloat lab4Y = CGRectGetMaxY(lab3.frame) + kHeight * 0.02;
        UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(lab4X, lab4Y, lab4W, lab4H)];
        [baseView addSubview:lab4];
        lab4.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab4.text = @"内容: ";
        NSString *lab4Str = @"2015年5月1日2015年5月1日2015年5月1日2015年5月1日2015年5月1日2015年5月1日2015年5月1日2015年5月1日2015年5月1日2015年5月1日2015年5月1日";
        NSMutableDictionary *lab4Dic = [[NSMutableDictionary alloc] init];
        lab4Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab4Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect4 = [lab4Str boundingRectWithSize:CGSizeMake(baseViewW - lab1W - lab1X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab4Dic context:nil];
        CGFloat contLab4W = baseViewW - lab1W - lab1X * 2;
        CGFloat contLab4H = fenRect4.size.height;
        CGFloat contLab4X = CGRectGetMaxX(lab3.frame);
        CGFloat contLab4Y = lab4Y;
        UILabel *contLab4 = [[UILabel alloc] initWithFrame:CGRectMake(contLab4X, contLab4Y, contLab4W, contLab4H)];
        contLab4.numberOfLines = 0;
        contLab4.text = lab4Str;
        contLab4.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [baseView addSubview:contLab4];
        
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(contLab4.frame) + kHeight * 0.026);
        
        self.cellHeight = baseView.frame.size.height + kHeight * 0.026;
    }
    
    
    
    
    return self;
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
