//
//  GFTextField.m
//  obdInterface
//
//  Created by 陈光法 on 15/12/24.
//  Copyright © 2015年 lubo. All rights reserved.
//

#import "GFTextField.h"

@implementation GFTextField


/**
 *  左边是中文字的输入框
 */
- (instancetype)initWithLeftStr:(NSString *)string {

    self = [super init];
    
    if(self != nil) {
        // 计算文字size
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
        attDic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
        attDic[NSForegroundColorAttributeName] = [UIColor blueColor];
        CGRect strRect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        
        UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, strRect.size.width + 20, 50)];
        
        // 添加lab
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, strRect.size.width, 50)];
        lab.text = string;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor colorWithRed:88 / 255.0 green:89 / 255.0 blue:90 / 255.0 alpha:1];
        
        [vv addSubview:lab];
    
        self.leftView = vv;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.backgroundColor = [UIColor whiteColor];
        

    }

    return self;
}

/**
 *  左边是图片的输入框
 */
- (instancetype)initWithLeftView:(UIImage *)img {

    self = [super init];
    
    if(self != nil) {
        UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
        imgView.image = img;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [vv addSubview:imgView];
        
        UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 10, 50)];
        
        [vv addSubview:v2];
        
        self.leftView = vv;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.backgroundColor = [UIColor whiteColor];
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
