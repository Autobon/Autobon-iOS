//
//  GFTouchImageView.m
//  图片处理
//
//  Created by 陈光法 on 16/10/26.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFTouchImageView.h"

@implementation GFTouchImageView



+ (instancetype)sharedManager {
    static GFTouchImageView* imageView = nil;
    
    //一定要使用系统的提示，防止出错。
    // dispatch_once snippet
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        imageView = [[GFTouchImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [[UIColor alloc]initWithWhite:0.2 alpha:1];
        
        /** 点击手势*/
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture1:)];
        tapGesture1.numberOfTapsRequired = 1; //点击次数
        tapGesture1.numberOfTouchesRequired = 1; //点击手指数
        [imageView addGestureRecognizer:tapGesture1];
        UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture2:)];
        tapGesture2.numberOfTapsRequired = 2; //点击次数
        tapGesture2.numberOfTouchesRequired = 1; //点击手指数
        [imageView addGestureRecognizer:tapGesture2];
        // 区分单击和双击的方法
        [tapGesture1 requireGestureRecognizerToFail:tapGesture2];
        
        
        /** 捏合手势*/
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
        [imageView addGestureRecognizer:pinchGesture];
        
        
        /** 拖动手势*/
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [imageView addGestureRecognizer:panGesture];
        
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:imageView];
    });
    
    return imageView;
}

static NSInteger danshuanjiFlage = 0;
static NSInteger tuoFlage = 0;
#pragma mark - 点击手势触发方法
// 单击
+(void)tapGesture1:(UITapGestureRecognizer *)sender {
    
    if(sender.numberOfTapsRequired == 1 && danshuanjiFlage == 0) {
    
        GFTouchImageView *imageView = [GFTouchImageView sharedManager];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGRect ff = imageView.frame;
        ff.size.width = 0;
        ff.size.height = 0;
        imageView.frame = ff;
        imageView.hidden = YES;
        [UIView commitAnimations];
    }
    
    if(sender.numberOfTapsRequired == 1 && danshuanjiFlage == 1) {
        
        danshuanjiFlage = 0;
        tuoFlage = 0;
        GFTouchImageView *imageView = [GFTouchImageView sharedManager];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        imageView.transform = CGAffineTransformIdentity;
        imageView.hidden = NO;
        [UIView commitAnimations];
    }
}
// 双击
+(void)tapGesture2:(UITapGestureRecognizer *)sender {

        
    danshuanjiFlage = 1;
    tuoFlage = 1;
    
    GFTouchImageView *imageView = [GFTouchImageView sharedManager];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    imageView.transform = CGAffineTransformMakeScale(2, 2);
    [UIView commitAnimations];
}

#pragma mark - 捏合手势触发事件
+(void) pinchGesture:(UIPinchGestureRecognizer *)sender {
    
    danshuanjiFlage = 1;
    tuoFlage = 1;
    UIPinchGestureRecognizer *gesture = sender;
    GFTouchImageView *imageView = [GFTouchImageView sharedManager];
    CGAffineTransform tt = imageView.transform;
    // 手势开始
    if(sender.state == UIGestureRecognizerStateBegan) {
    
        
    }
    // 手势改变时
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        if(imageView.frame.size.width >= [UIScreen mainScreen].bounds.size.width) {
            
            //捏合手势中scale属性记录的缩放比例
            CGFloat ss = gesture.scale > 1 ? (gesture.scale - 1) / 60.0 + 1 : (gesture.scale - 1) / 10.0 + 1;
        
            imageView.transform = CGAffineTransformScale(tt, ss, ss);
            
//            NSLog(@"----%f---%f", gesture.scale, imageView.frame.size.width);
        }
    }
    // 手势结束后
    if(gesture.state==UIGestureRecognizerStateEnded) {
        
        
        if(imageView.frame.size.width < [UIScreen mainScreen].bounds.size.width || imageView.frame.size.height < [UIScreen mainScreen].bounds.size.height) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                imageView.transform = CGAffineTransformIdentity;//取消一切形变
            }];
        }
    }
}

#pragma mark - 拖动手势触发方法
+ (void)panGesture:(UIPanGestureRecognizer *)sender {
    if(tuoFlage == 1) {
    
        GFTouchImageView *imgView = [GFTouchImageView sharedManager];
        UIPanGestureRecognizer *panGesture = sender;
        CGPoint movePoint = [panGesture translationInView:imgView.superview];
        CGPoint orPoint;
        CGPoint p1;
        CGPoint p2;
        CGAffineTransform tt = imgView.transform;
        // 手势开始
        if(sender.state == UIGestureRecognizerStateBegan) {
            
            orPoint = [panGesture locationInView:imgView.superview];
            p1 = orPoint;
            p2 = p1;
        }
        
        // 手势进行
        if (sender.state == UIGestureRecognizerStateChanged) {
            
            
            if(imgView.frame.origin.x > 0 || imgView.frame.origin.y > 0) {
                
                return;
               
            }else if((CGRectGetMaxX(imgView.frame) < [UIScreen mainScreen].bounds.size.width) || (CGRectGetMaxY(imgView.frame) < [UIScreen mainScreen].bounds.size.height)) {
                
                
                return;

            }else {
                
                p1.x = orPoint.x + movePoint.x;
                p1.y = orPoint.y + movePoint.y;
                imgView.transform = CGAffineTransformTranslate(tt, -(p2.x - p1.x) / 20, -(p2.y - p1.y) / 20);
                p2 = p1;
            }
            
        }
        
        if(sender.state == UIGestureRecognizerStateEnded) {
        
            if(imgView.frame.origin.x > 0 || imgView.frame.origin.y > 0) {
                
                if(imgView.frame.origin.x > 0 && imgView.frame.origin.y > 0) {
                    
                    imgView.transform = CGAffineTransformTranslate(tt, -imgView.frame.origin.x, -imgView.frame.origin.y);
                }else if(imgView.frame.origin.x > 0) {
                    
                    imgView.transform = CGAffineTransformTranslate(tt, -imgView.frame.origin.x, 0);
                }else {
                    
                    imgView.transform = CGAffineTransformTranslate(tt, 0, -imgView.frame.origin.y);
                }
            }else if((CGRectGetMaxX(imgView.frame) < [UIScreen mainScreen].bounds.size.width) || (CGRectGetMaxY(imgView.frame) < [UIScreen mainScreen].bounds.size.height)) {
                
                if((CGRectGetMaxX(imgView.frame) < [UIScreen mainScreen].bounds.size.width) && (CGRectGetMaxY(imgView.frame) < [UIScreen mainScreen].bounds.size.height)) {
                    
                    imgView.transform = CGAffineTransformTranslate(tt, ([UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(imgView.frame)), [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(imgView.frame));
                }else if(CGRectGetMaxX(imgView.frame) < [UIScreen mainScreen].bounds.size.width) {
                    
                    imgView.transform = CGAffineTransformTranslate(tt, ([UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(imgView.frame)), 0);
                }else {
                    
                    imgView.transform = CGAffineTransformTranslate(tt, 0, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(imgView.frame));
                }
            }
        }
        
    }
}

@end
