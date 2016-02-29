//
//  GFTransformTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFTransformTableViewCell.h"

@implementation GFTransformTableViewCell


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

    
        
        NSString *lab1Str = @"发送旅客的法国萨科技的股份发送旅客房价拉萨的叫法阿萨德飞拉萨发生了";
        NSMutableDictionary *lab1Dic = [[NSMutableDictionary alloc] init];
        lab1Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        lab1Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect1 = [lab1Str boundingRectWithSize:CGSizeMake(baseViewW - kWidth * 0.023 * 2.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab1Dic context:nil];
        CGFloat lab1W = kWidth - kWidth * 0.023 * 2.0;
        CGFloat lab1H = fenRect1.size.height;
        CGFloat lab1X = kWidth * 0.023;
        CGFloat lab1Y = kHeight * 0.02864;
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1X, lab1Y, lab1W, lab1H)];
        lab1.numberOfLines = 0;
        lab1.text = lab1Str;
        lab1.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [baseView addSubview:lab1];
        
        
        
        
        
        
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
