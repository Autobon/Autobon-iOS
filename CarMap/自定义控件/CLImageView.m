//
//  CLImageView.m
//  CLWi-Fi
//
//  Created by 李孟龙 on 16/6/6.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLImageView.h"

@implementation CLImageView







- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;     
    }
    
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    static BOOL isTouch = YES;
    self.userInteractionEnabled = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    if (isTouch) {
        
        UIViewController *viewController = [self getCurrentViewController];
        [viewController.view bringSubviewToFront:self];
        _rect = self.frame;
        self.frame = [UIScreen mainScreen].bounds;
    }else{
        self.frame = _rect;
    }
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    isTouch = !isTouch;
    

}


-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{

    self.userInteractionEnabled = YES;
    
}

-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
