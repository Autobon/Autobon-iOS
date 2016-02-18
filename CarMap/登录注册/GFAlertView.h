//
//  GFAlertView.h
//  CarMap
//
//  Created by 陈光法 on 16/2/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFAlertView : UIView

//@property (nonatomic, strong) UIView *baseView;

- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray;


@end
