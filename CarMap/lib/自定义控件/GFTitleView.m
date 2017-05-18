//
//  GFTitleView.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/1.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFTitleView.h"

@implementation GFTitleView






- (instancetype)initWithY:(CGFloat)y Title:(NSString *)titleString {

    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat baseViewW = kWidth;
        CGFloat baseViewH = kHeight * 0.0782;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = y;
        self.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH);
        self.backgroundColor = [UIColor whiteColor];
        
        // 橘条
        UIView *orangeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5 / 320.0 * kWidth, baseViewH)];
        orangeView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [self addSubview:orangeView];
        
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth * 0.065, 0, kWidth * 0.9, baseViewH)];
        titleLabel.text = titleString;
        [self addSubview:titleLabel];
        
        
        // 底线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [self addSubview:lineView];
    
    }
    
    
    return self;
}

- (instancetype)initWithY:(CGFloat)y {
    
    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat baseViewW = kWidth;
        CGFloat baseViewH = kHeight * 0.0782;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = y;
        self.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH);
        self.backgroundColor = [UIColor whiteColor];
        
        // 橘条
        UIView *orangeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5 / 320.0 * kWidth, baseViewH)];
        orangeView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [self addSubview:orangeView];
        
        
        // 标题
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kWidth * 0.065, 0, kWidth * 0.9, baseViewH)];
        self.titleLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        [self addSubview:self.titleLab];
        
        
        // 底线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [self addSubview:lineView];
        
        
        // 右边lab
        self.rightLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth - kWidth * 0.065, baseViewH)];
        self.rightLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        self.rightLab.textAlignment = NSTextAlignmentRight;
        
        
        
        [self addSubview:self.rightLab];
        
    }
    
    
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
