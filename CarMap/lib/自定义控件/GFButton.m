//
//  GFButton.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/4.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFButton.h"

@implementation GFButton


- (instancetype)initWithButtonName:(NSString *)butName withImgName:(NSString *)normalName withImgName:(NSString *)hightName {

    self = [super init];
    
    
    if(self != nil) {
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.but = [UIButton buttonWithType:UIButtonTypeCustom];
        self.but.frame = CGRectMake(0, 0, kWidth * 0.33, kHeight * 0.03125);
        [self.but setTitle:butName forState:UIControlStateNormal];
        [self.but setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
        [self.but setImage:[UIImage imageNamed:hightName] forState:UIControlStateSelected];
        self.but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.but.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [self addSubview:self.but];
        
        self.but.backgroundColor = [UIColor redColor];
        
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
