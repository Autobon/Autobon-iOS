//
//  GFAlertView.m
//  CarMap
//
//  Created by 陈光法 on 16/2/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFAlertView.h"

@implementation GFAlertView


- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray {

    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor blackColor];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 100;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor greenColor];
        [self addSubview:baseView];
        
        // 提示标题
        CGFloat tipLabW = baseViewW;
        CGFloat tipLabH = 40 / 568.0 * kHeight;
        CGFloat tipLabX = 0;
        CGFloat tipLabY = 0;
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.text = tipName;
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.font = [UIFont systemFontOfSize:17 / 320.0 * kWidth];
        [baseView addSubview:tipLab];
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        msgLab.attributedText = attStr;
        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        msgLab.backgroundColor = [UIColor redColor];
    
        
        
        
        
        
        
        
        
        
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
