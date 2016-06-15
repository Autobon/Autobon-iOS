//
//  MYImageView.m
//  CarMap
//
//  Created by 李孟龙 on 16/3/8.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "MYImageView.h"
#import "CLTouchImageView.h"
#import "CLTouchScrollView.h"


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
    
    CLTouchScrollView *scrollView = [self sharedScrollView];
    if (self.imageArray == nil) {
        scrollView.hidden = YES;
    }else{
        NSLog(@"---imageView.tag----%ld---",self.tag);
        NSLog(@"---imageView.imageArray----%@--",self.imageArray);
        
        scrollView.hidden = NO;
        
        NSLog(@"------scrollView---%@---scrollView.imageArray--%@--",scrollView,scrollView.imageArray);
        
        
        scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*self.imageArray.count, [UIScreen mainScreen].bounds.size.height);
        scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width*self.tag, 0);
        [self.imageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = scrollView.imageArray[idx];
//            imageView.backgroundColor = [UIColor cyanColor];
            imageView.image = obj.image;
        }];
    }
    
    
    
    
//    imageView.alpha = 0;
//    imageView.image = self.image;
//    imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-self.frame.size.width/2, [UIScreen mainScreen].bounds.size.height/2-self.frame.size.height/2, self.frame.size.width, self.frame.size.height);
//    imageView.rect = self.frame;
//    imageView.userInteractionEnabled = YES;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    imageView.frame = [UIScreen mainScreen].bounds;
//    imageView.alpha = 1;
//
//    [UIView commitAnimations];
    //    isTouch = !isTouch;
    
    
}



- (CLTouchScrollView *)sharedScrollView {
    static CLTouchScrollView* scrollView = nil;
    
    //一定要使用系统的提示，防止出错。
    // dispatch_once snippet
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scrollView = [[CLTouchScrollView alloc] init];
        scrollView.contentMode = UIViewContentModeScaleAspectFit;
        scrollView.backgroundColor = [[UIColor alloc]initWithWhite:0.2 alpha:1];
        scrollView.frame = [UIScreen mainScreen].bounds;
        scrollView.imageArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < 9; i++) {
            UIImageView *imageView = [[MYImageView alloc]init];
            imageView.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [scrollView addSubview:imageView];
            [scrollView.imageArray addObject:imageView];
            scrollView.pagingEnabled = YES;
            scrollView.bounces = NO;
        }
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:scrollView];
    });
    
    return scrollView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
