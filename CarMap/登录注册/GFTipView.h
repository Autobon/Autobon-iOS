//
//  GFTipView.h
//  CarMap
//
//  Created by 陈光法 on 16/2/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTipView : UIView {

    CGFloat time;
}

//默认高度
- (instancetype)initWithNormalHeightWithMessage:(NSString *)messageStr withViewController:(UIViewController *)viewController withShowTimw:(CGFloat)times;
// 手动设置高度
- (instancetype)initWithHeight:(CGFloat)height WithMessage:(NSString *)messageStr withViewController:(UIViewController *)viewController withShowTimw:(CGFloat)times;


// 调用上面init方法后，调用此方法可显示提示框
- (void)tipViewShow;


@end
