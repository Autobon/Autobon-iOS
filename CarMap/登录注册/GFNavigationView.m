//
//  GFNavigationView.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/15.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFNavigationView.h"

@implementation GFNavigationView


- (instancetype)initWithLeftImgName:(NSString *)leftImgName withLeftImgHightName:(NSString *)leftImgHightName withRightImgName:(NSString *)rightImgName withRightImgHightName:(NSString *)rightImgHightName withCenterTitle:(NSString *)titleName withFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        
        self.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        
        // 左边按钮
        CGFloat leftButW = 44;
        CGFloat leftButH = 44;
        CGFloat leftButX = 0;
        CGFloat leftButY = 20;
        self.leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBut.frame = CGRectMake(leftButX, leftButY, leftButW, leftButH);
        [self.leftBut setImage:[UIImage imageNamed:leftImgName] forState:UIControlStateNormal];
        [self.leftBut setImage:[UIImage imageNamed:leftImgHightName] forState:UIControlStateHighlighted];
        [self addSubview:self.leftBut];
        
        // 中间标题
        CGFloat titleLabW = kWidth * 2 / 5;
        CGFloat titleLabH = leftButH;
        CGFloat titleLabX = kWidth * 1.5 / 5;
        CGFloat titleLabY = leftButY;
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLabX, titleLabY, titleLabW, titleLabH)];
        self.titleLab.text = titleName;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.titleLab];
        
        // 右边按钮
        if(rightImgName != nil) {
            
            CGFloat rightButW = leftButW;
            CGFloat rightButH = leftButH;
            CGFloat rightButX = kWidth - rightButW;
            CGFloat rightButY = leftButY;
            self.rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBut.frame = CGRectMake(rightButX, rightButY, rightButW, rightButH);
            [self.rightBut setImage:[UIImage imageNamed:rightImgName] forState:UIControlStateNormal];
            [self.rightBut setImage:[UIImage imageNamed:rightImgHightName] forState:UIControlStateHighlighted];
            [self addSubview:self.rightBut];

        }
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
