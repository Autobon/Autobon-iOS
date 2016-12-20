//
//  CLTitleView.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLTitleView.h"

@implementation CLTitleView

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)titleString{
    self = [super initWithFrame:frame];
    if (self != nil) {
// 头线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [self addSubview:lineView];
// 浅色条
        UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 2, self.frame.size.width, 5)];
        colorView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
        [self addSubview:colorView];
// 尾线
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 1)];
        lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [self addSubview:lineView2];
// 橘条
        UIView *orangeView = [[UIView alloc]initWithFrame:CGRectMake(0, 7, 5, self.frame.size.height-9)];
        orangeView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [self addSubview:orangeView];
        
// title
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 300, 30)];
        titleLabel.text = titleString;
        titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:titleLabel];
        
        
    }
    return self;
}


@end
