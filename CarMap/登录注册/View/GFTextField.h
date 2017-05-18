//
//  GFTextField.h
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/15.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTextField : UIView

@property (nonatomic, strong) UITextField *centerTxt;

- (instancetype)initWithImage:(UIImage *)image withFrame:(CGRect)frame;

- (instancetype)initWithImage:(UIImage *)image withRightButton:(UIButton *)button withFrame:(CGRect)frame;

- (instancetype)initWithPlaceholder:(NSString *)placeholder withFrame:(CGRect)frame;
@end
