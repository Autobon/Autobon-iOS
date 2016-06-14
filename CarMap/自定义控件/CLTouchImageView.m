//
//  CLTouchImageView.m
//  CarMap
//
//  Created by 李孟龙 on 16/6/13.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLTouchImageView.h"

@implementation CLTouchImageView



+ (instancetype)sharedManager {
    static CLTouchImageView* imageView = nil;
    
    //一定要使用系统的提示，防止出错。
    // dispatch_once snippet
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageView = [[CLTouchImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [[UIColor alloc]initWithWhite:0.2 alpha:1];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:imageView];
    });
    
    return imageView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"支持放大的图片的点击方法");
    CLTouchImageView *imageView = [CLTouchImageView sharedManager];
    imageView.backgroundColor = [UIColor clearColor];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-_rect.size.width/2, [UIScreen mainScreen].bounds.size.height/2-_rect.size.height/2, _rect.size.width, _rect.size.height);
    imageView.alpha = 0;
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    
}
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    CLTouchImageView *imageView = [CLTouchImageView sharedManager];
    imageView.hidden = YES;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
