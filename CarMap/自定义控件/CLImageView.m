//
//  CLImageView.m
//  CLWi-Fi
//
//  Created by 李孟龙 on 16/6/6.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLImageView.h"
#import "CLTouchImageView.h"

@implementation CLImageView







- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;     
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CLTouchImageView *imageView = [CLTouchImageView sharedManager];
    imageView.backgroundColor = [UIColor blackColor];
   
    imageView.alpha = 0;
    imageView.image = self.image;
    imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-self.frame.size.width/2, [UIScreen mainScreen].bounds.size.height/2-self.frame.size.height/2, self.frame.size.width, self.frame.size.height);
    imageView.rect = self.frame;
    imageView.userInteractionEnabled = YES;
    
//    static BOOL isTouch = YES;
//    self.userInteractionEnabled = NO;
//    self.backgroundColor = [UIColor redColor];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
//    if (isTouch) {
    
        
        
        
        
//        UIViewController *viewController = [self getCurrentViewController];
//        [viewController.view bringSubviewToFront:self];
//        _rect = self.frame;
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.alpha = 1;
//    }else{
//        self.frame = _rect;
//    }
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
//    isTouch = !isTouch;
    

}


-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{

    self.userInteractionEnabled = YES;
    
}

-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        NSLog(@"寻找视图控制器");
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
