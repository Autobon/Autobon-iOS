//
//  GFTextField.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/15.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFTextField.h"

@implementation GFTextField


- (instancetype)initWithImage:(UIImage *)image withFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self != nil) {
        // 基础View
        CGFloat baseViewW = frame.size.width;
        CGFloat baseViewH = frame.size.height;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = 0;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        [self addSubview:baseView];

        
        // 左边头视图
        CGFloat iconImgViewW = baseViewH * 0.583;
        CGFloat iconImgViewH = baseViewH * 0.583;
        CGFloat iconImgViewX = 0;
        CGFloat iconImgViewY = 0;
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
        iconImgView.image = image;
        iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [baseView addSubview:iconImgView];

        
        // 头视图和输入框的间距
        CGFloat iconBack = baseViewW * 0.10;
        
        
        // 输入框
        CGFloat centerTxtW = baseViewW - iconImgViewW - iconBack;
        CGFloat centerTxtH = iconImgViewH;
        CGFloat centerTxtX = iconImgViewW + iconBack;
        CGFloat centerTxtY = iconImgViewX;
        self.centerTxt = [[UITextField alloc] initWithFrame:CGRectMake(centerTxtX, centerTxtY, centerTxtW, centerTxtH)];
        self.centerTxt.textColor = [UIColor colorWithRed:40 / 255.0 green:40 / 255.0 blue:40 / 255.0 alpha:1];
        [baseView addSubview:self.centerTxt];

        
        // 下划线
        CGFloat lineViewW = centerTxtW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = centerTxtX;
//        CGFloat lineViewY = baseViewH - lineViewH;
        CGFloat lineViewY = baseViewH;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
    }
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image withRightButton:(UIButton *)button withFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self != nil) {
        // 基础View
        CGFloat baseViewW = frame.size.width;
        CGFloat baseViewH = frame.size.height;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = 0;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        [self addSubview:baseView];

        
        // 左边头视图
        CGFloat iconImgViewW = baseViewH * 0.583;
        CGFloat iconImgViewH = baseViewH * 0.583;
        CGFloat iconImgViewX = 0;
        CGFloat iconImgViewY = 0;
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
        iconImgView.image = image;
        iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [baseView addSubview:iconImgView];

        
        // 右边的按钮
        CGFloat rightButViewW = button.frame.size.width;
        CGFloat rightButViewH = button.frame.size.height;
        CGFloat rightButViewX = baseViewW - rightButViewW;
        CGFloat rightButViewY = 0;
        UIView *rightButView = [[UIView alloc] initWithFrame:CGRectMake(rightButViewX, rightButViewY, rightButViewW, rightButViewH)];
        [rightButView addSubview:button];
        [baseView addSubview:rightButView];
        
        
        // 头视图和输入框的间距
        CGFloat iconBack = baseViewW * 0.10;
        
        
        // 输入框
        CGFloat centerTxtW = baseViewW - iconImgViewW - iconBack - rightButViewW;
        CGFloat centerTxtH = iconImgViewH;
        CGFloat centerTxtX = iconImgViewW + iconBack;
        CGFloat centerTxtY = iconImgViewX;
        self.centerTxt = [[UITextField alloc] initWithFrame:CGRectMake(centerTxtX, centerTxtY, centerTxtW, centerTxtH)];
        self.centerTxt.textColor = [UIColor colorWithRed:40 / 255.0 green:40 / 255.0 blue:40 / 255.0 alpha:1];
        [baseView addSubview:self.centerTxt];

        
        // 下划线
        CGFloat lineViewW = centerTxtW + rightButViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = centerTxtX;
//        CGFloat lineViewY = baseViewH - lineViewH;
        CGFloat lineViewY = baseViewH;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
    }
    
    return self;
}


- (instancetype)initWithPlaceholder:(NSString *)placeholder withFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self != nil) {
        // 基础View
        CGFloat baseViewW = frame.size.width;
        CGFloat baseViewH = frame.size.height;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = 0;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        [self addSubview:baseView];
        
        // 输入框
        CGFloat centerTxtW = baseViewW;
        CGFloat centerTxtH = baseViewH * 0.583;
        CGFloat centerTxtX = 0;
        CGFloat centerTxtY = 0;
        self.centerTxt = [[UITextField alloc] initWithFrame:CGRectMake(centerTxtX, centerTxtY, centerTxtW, centerTxtH)];
        self.centerTxt.textColor = [UIColor colorWithRed:40 / 255.0 green:40 / 255.0 blue:40 / 255.0 alpha:1];
        self.centerTxt.placeholder = placeholder;
        [self.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * ([UIScreen mainScreen].bounds.size.width))] forKeyPath:@"_placeholderLabel.font"];
        [baseView addSubview:self.centerTxt];
        
        // 下划线
        CGFloat lineViewW = centerTxtW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = centerTxtX;
        //        CGFloat lineViewY = baseViewH - lineViewH;
        CGFloat lineViewY = baseViewH;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:1];
        [baseView addSubview:lineView];

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
