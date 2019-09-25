//
//  CLLineTextFieldView.h
//  CarMapB
//
//  Created by inCar on 2018/6/14.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLLineTextFieldView : UIView

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UITextField *textField;


- (instancetype)initWithTitle:(NSString *)titleString width:(int )width;

@end
