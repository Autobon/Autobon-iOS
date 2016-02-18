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
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 100;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
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
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(tipLab.frame);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        msgLab.attributedText = attStr;
//        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        
        // 下方按钮
        CGFloat okButW = baseViewW;
        CGFloat okButH = tipLabH;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 20;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = 60;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = buttonArray[0];
        okLab.textAlignment = NSTextAlignmentCenter;
        [_okBut addSubview:okLab];
    
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2);
        
    }

    return self;
}


- (void)okButClick {

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
