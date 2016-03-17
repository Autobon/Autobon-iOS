//
//  GFNothingView.m
//  CarMap
//
//  Created by 陈光法 on 16/3/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFNothingView.h"

@implementation GFNothingView







- (instancetype)initWithImageName:(NSString *)imgName withTipString:(NSString *)tipStr withSubtipString:(NSString *)subTipStr{
    
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self = [super init];
    
    if(self != nil) {
    
        self.frame = CGRectMake(0, 100, kWidth, kHeight - 64);
        
        CGFloat imgViewW = 50 / 320.0 * kWidth;
        CGFloat imgViewH = imgViewW;
        CGFloat imgViewX = (kWidth - imgViewW) / 2.0;
        CGFloat imgViewY = kHeight * 0.30 - 40;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        imgView.image = [UIImage imageNamed:imgName];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imgView];
        
        CGFloat lab1W = kWidth;
        CGFloat lab1H = 40;
        CGFloat lab1X = 0;
        CGFloat lab1Y = CGRectGetMaxY(imgView.frame);
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1X, lab1Y, lab1W, lab1H)];
        lab1.text = tipStr;
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        lab1.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [self addSubview:lab1];
        
        CGFloat lab2W = kWidth;
        CGFloat lab2H = 40;
        CGFloat lab2X = 0;
        CGFloat lab2Y = CGRectGetMaxY(lab1.frame) - 15;
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab2X, lab2Y, lab2W, lab2H)];
        lab2.text = subTipStr;
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        lab2.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
        [self addSubview:lab2];
        
        
    }
    
    return self;
}



//- (instancetype)initWithImageName:(NSString *)imgName withFrame:() withTipString:(NSString *)tipStr withSubtipString:(NSString *)subTipStr{
//    
//    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
//    
//    self = [super init];
//    
//    if(self != nil) {
//        
//        self.frame = CGRectMake(0, 64, kWidth, kHeight - 64);
//        
//        
////        UIView *baseView = [[UIView alloc] initWithFrame:<#(CGRect)#>];
//        
//        CGFloat imgViewW = 50 / 320.0 * kWidth;
//        CGFloat imgViewH = imgViewW;
//        CGFloat imgViewX = (kWidth - imgViewW) / 2.0;
//        CGFloat imgViewY = kHeight * 0.30;
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
//        imgView.image = [UIImage imageNamed:imgName];
//        imgView.contentMode = UIViewContentModeScaleAspectFit;
//        [self addSubview:imgView];
//        
//        CGFloat lab1W = kWidth;
//        CGFloat lab1H = 40;
//        CGFloat lab1X = 0;
//        CGFloat lab1Y = CGRectGetMaxY(imgView.frame);
//        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1X, lab1Y, lab1W, lab1H)];
//        lab1.text = tipStr;
//        lab1.textAlignment = NSTextAlignmentCenter;
//        lab1.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//        lab1.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
//        [self addSubview:lab1];
//        
//        CGFloat lab2W = kWidth;
//        CGFloat lab2H = 40;
//        CGFloat lab2X = 0;
//        CGFloat lab2Y = CGRectGetMaxY(lab1.frame) - 15;
//        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab2X, lab2Y, lab2W, lab2H)];
//        lab2.text = subTipStr;
//        lab2.textAlignment = NSTextAlignmentCenter;
//        lab2.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//        lab2.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
//        [self addSubview:lab2];
//        
//        
//    }
//    
//    return self;
//}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
