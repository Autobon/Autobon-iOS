//
//  GFTitleView.h
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/1.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTitleView : UIView

- (instancetype)initWithY:(CGFloat)y Title:(NSString *)titleString;


@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *rightLab;
- (instancetype)initWithY:(CGFloat)y;

@end
