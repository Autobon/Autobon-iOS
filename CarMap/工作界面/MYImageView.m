//
//  MYImageView.m
//  CarMap
//
//  Created by 李孟龙 on 16/3/8.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "MYImageView.h"
#import "CLTouchImageView.h"


@implementation MYImageView


- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
//        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
//        self.contentMode = UIViewContentModeScaleAspectFit;
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
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.alpha = 1;

    [UIView commitAnimations];
    //    isTouch = !isTouch;
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
