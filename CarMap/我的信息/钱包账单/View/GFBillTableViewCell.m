//
//  GFBillTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFBillTableViewCell.h"

@implementation GFBillTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat jianjv = kWidth * 0.063;

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self != nil) {
        
        self.backgroundColor = [UIColor clearColor];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat baseViewH = kHeight * 0.081;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        
        CGFloat jiesuanButW = kWidth * 0.144;
        CGFloat jiesuanButH = kHeight * 0.0286;
        CGFloat jiesuanButX = 0;
        CGFloat jiesuanButY = 0;
        self.jiesuanBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.jiesuanBut.frame = CGRectMake(jiesuanButX, jiesuanButY, jiesuanButW, jiesuanButH);
        [self.jiesuanBut setBackgroundImage:[UIImage imageNamed:@"accountDark"] forState:UIControlStateNormal];
        [self.jiesuanBut setBackgroundImage:[UIImage imageNamed:@"account"] forState:UIControlStateSelected];
        [self.jiesuanBut setTitle:@"未结算" forState:UIControlStateNormal];
        [self.jiesuanBut setTitle:@"已结算" forState:UIControlStateSelected];
        [self.jiesuanBut setTitleColor:[UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:163 / 255.0] forState:UIControlStateNormal];
        [self.jiesuanBut setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [baseView addSubview:self.jiesuanBut];
        self.jiesuanBut.titleLabel.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
        
        
    
        CGFloat monthLabW = (kWidth - 2 * jianjv) / 2.0;
        CGFloat monthLabH = baseViewH - 4;
        CGFloat monthLabX = jianjv;
        CGFloat monthLabY = 4;
        self.monthLab = [[UILabel alloc] init];
        self.monthLab.frame = CGRectMake(monthLabX, monthLabY, monthLabW, monthLabH);
        self.monthLab.text = @"一月";
        [baseView addSubview:self.monthLab];
        self.monthLab.font = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
        
        
        CGFloat sumMoneyLabW = kWidth - (kWidth * 0.046) * 2;
        CGFloat sumMoneyLabH = monthLabH;
//        CGFloat sumMoneyLabX = CGRectGetMaxX(self.monthLab.frame);
        CGFloat sumMoneyLabX = kWidth * 0.046;
        CGFloat sumMoneyLabY = 0;
        self.sumMoneyLab = [[UILabel alloc] init];
        self.sumMoneyLab.frame = CGRectMake(sumMoneyLabX, sumMoneyLabY, sumMoneyLabW, sumMoneyLabH);
        self.sumMoneyLab.textAlignment = NSTextAlignmentRight;
        self.sumMoneyLab.text = @"￥ 888888.88";
        self.sumMoneyLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:self.sumMoneyLab];
        self.sumMoneyLab.font = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
        
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
        upLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:upLine];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH, kWidth, 1)];
        downLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:downLine];
        
        
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
