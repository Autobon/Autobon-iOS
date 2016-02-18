//
//  CLTouchScrollView.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLTouchScrollView.h"

@implementation CLTouchScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
