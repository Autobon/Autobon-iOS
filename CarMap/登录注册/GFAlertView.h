//
//  GFAlertView.h
//  CarMap
//
//  Created by 陈光法 on 16/2/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFAlertView : UIView

@property (nonatomic, strong) UIButton *okBut;
@property (nonatomic, strong) UIButton *rightButton;

- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray;

- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray withRightUpButtonNormalImage:(UIImage *)butNorImg withRightUpButtonHightImage:(UIImage *)butHigImg;


- (instancetype)initWithHeadImageURL:(NSString *)imageURL name:(NSString *)name mark:(float )mark orderNumber:(NSInteger )orderNumber goodNumber:(float)good order:(NSString *)order;


- (instancetype)initWithTitle:(NSString *)title leftBtn:(NSString *)leftBtn rightBtn:(NSString *)rightBtn;

// 进度条
+ (instancetype)initWithJinduTiaoTipName:(NSString *)tipName;


// 延迟移除进度条
- (void)remove;


- (instancetype)initWithTitleString:(NSString *)title withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray;



@end
