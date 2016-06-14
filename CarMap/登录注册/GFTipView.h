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

/**
 *  默认高度；添加到window上
 *
 *  @param messageStr 提示文本内容
 *  @param times      显示时间
 *  @补充：外部调用：   [tipView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:times];
 */
+ (instancetype)tipViewWithNormalHeightWithMessage:(NSString *)messageStr withShowTimw:(CGFloat)times;

//默认高度
- (instancetype)initWithNormalHeightWithMessage:(NSString *)messageStr withViewController:(UIViewController *)viewController withShowTimw:(CGFloat)times;
// 手动设置高度
- (instancetype)initWithHeight:(CGFloat)height WithMessage:(NSString *)messageStr withViewController:(UIViewController *)viewController withShowTimw:(CGFloat)times;

- (instancetype)initWithNormalHeightWithMessage:(NSString *)messageStr withShowTimw:(CGFloat)times;

// 调用上面init方法后，调用此方法可显示提示框
- (void)tipViewShow;


@end
