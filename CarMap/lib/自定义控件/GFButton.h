//
//  GFButton.h
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/4.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFButton : UIView


@property (nonatomic, strong) UIButton *but;
- (instancetype)initWithButtonName:(NSString *)butName withImgName:(NSString *)normalName withImgName:(NSString *)hightName;


@end
