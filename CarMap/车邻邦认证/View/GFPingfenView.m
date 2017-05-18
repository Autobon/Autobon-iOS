//
//  GFPingfenView.m
//  CarMap
//
//  Created by 陈光法 on 16/11/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFPingfenView.h"

@interface GFPingfenView()

@property (nonatomic, strong) NSMutableArray *butArr;

@property (nonatomic, assign) BOOL flage;

@property (nonatomic, assign) NSInteger tt;

@end

@implementation GFPingfenView


- (NSString *)xingjiStr {
    
    return [NSString stringWithFormat:@"%ld", self.tt];
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self != nil) {
        
        self.butArr = [[NSMutableArray alloc] init];
        
        self.flage = NO;
        self.tt = 0;
        
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;
        
        CGFloat ssW = (w - 20) / 5.0;
        
        for(int i=0; i<5; i++) {
        
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake((ssW + 5) * i, 0, ssW, h);
            [but setImage:[UIImage imageNamed:@"detailsStarDark"] forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:@"detailsStar"] forState:UIControlStateSelected];
            but.tag = i;
            [self.butArr addObject:but];
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:but];
        }
        
    }
    
    return self;
}

- (void)butClick:(UIButton *)sender {
    
    for(int i=0; i<self.butArr.count; i++) {
    
        UIButton *but = (UIButton *)self.butArr[i];
        but.selected = NO;
        if(but.tag <= sender.tag) {
        
            but.selected = YES;
        }
    }
    
    self.tt = sender.tag + 1;
    
    if(self.flage && sender.tag == 0) {
        
        sender.selected = NO;
        self.tt = 0;
    }
    
    if(sender.tag == 0 && self.flage == NO) {
        
        self.flage = YES;
    }else {
        
        self.flage = NO;
    }
    
//    NSLog(@"===%ld", self.tt);
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
