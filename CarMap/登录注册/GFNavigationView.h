//
//  GFNavigationView.h
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/15.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFNavigationView : UIView

@property (nonatomic, strong) UIButton *leftBut;
@property (nonatomic, strong) UIButton *rightBut;
@property (nonatomic, strong) UILabel *titleLab;

- (instancetype)initWithLeftImgName:(NSString *)leftImgName withLeftImgHightName:(NSString *)leftImgHightName withRightImgName:(NSString *)rightImgName withRightImgHightName:(NSString *)rightImgHightName withCenterTitle:(NSString *)titleName withFrame:(CGRect)frame;



@end
