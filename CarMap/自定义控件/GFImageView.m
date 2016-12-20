//
//  GFImageView.m
//  图片处理
//
//  Created by 陈光法 on 16/10/26.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFImageView.h"
#import "GFTouchImageView.h"

@implementation GFImageView




- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    return self;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    GFTouchImageView *imageView = [GFTouchImageView sharedManager];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.hidden = NO;
    imageView.image = self.image;
    imageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height / 2.0);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    imageView.frame = [UIScreen mainScreen].bounds;
    [UIView commitAnimations];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
