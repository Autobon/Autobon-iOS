//
//  GFTipView.m
//  CarMap
//
//  Created by 陈光法 on 16/2/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFTipView.h"

@implementation GFTipView

- (instancetype)initWithHeight:(CGFloat)height WithMessage:(NSString *)messageStr withViewController:(UIViewController *)viewController withShowTimw:(CGFloat)times {

    self = [super init];
    
    if(self != nil) {
        
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        
        NSString *str = messageStr;
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
        attDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        CGRect strRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        
        CGFloat tipViewW = strRect.size.width + 30;
        CGFloat tipViewH = kHeight * 0.0625;
        CGFloat tipViewX = (kWidth - tipViewW) / 2.0;
        CGFloat tipViewY = height;
        UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(tipViewX, tipViewY, tipViewW, tipViewH)];
        tipView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        tipView.layer.cornerRadius = 7.5;
        [self addSubview:tipView];
        
        CGFloat msgLabW = tipViewW;
        CGFloat msgLabH = tipViewH;
        CGFloat msgLabX = 0;
        CGFloat msgLabY = 0;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.text = messageStr;
        [tipView addSubview:msgLab];
        msgLab.textAlignment = NSTextAlignmentCenter;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor whiteColor];
        
        [viewController.view addSubview:self];
        
        self.hidden = YES;
        
        time = times;
    }
    
    
    return self;

}


- (instancetype)initWithNormalHeightWithMessage:(NSString *)messageStr withViewController:(UIViewController *)viewController withShowTimw:(CGFloat)times {
    
    self = [super init];
    
    if(self != nil) {
        
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        
        NSString *str = messageStr;
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
        attDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        CGRect strRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        
        CGFloat tipViewW = strRect.size.width + 30;
        CGFloat tipViewH = kHeight * 0.0625;
        CGFloat tipViewX = (kWidth - tipViewW) / 2.0;
        CGFloat tipViewY = kHeight * 0.8;
        UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(tipViewX, tipViewY, tipViewW, tipViewH)];
        tipView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        tipView.layer.cornerRadius = 7.5;
        [self addSubview:tipView];
        
        CGFloat msgLabW = tipViewW;
        CGFloat msgLabH = tipViewH;
        CGFloat msgLabX = 0;
        CGFloat msgLabY = 0;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.text = messageStr;
        [tipView addSubview:msgLab];
        msgLab.textAlignment = NSTextAlignmentCenter;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor whiteColor];
        
        [viewController.view addSubview:self];
        
        self.hidden = YES;
        
        time = times;
    }
    
    
    return self;
}

- (void)tipViewShow {
    self.hidden = NO;

    [self performSelector:@selector(tipVIewRemove) withObject:nil afterDelay:time];
}

- (void)tipVIewRemove {

    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
