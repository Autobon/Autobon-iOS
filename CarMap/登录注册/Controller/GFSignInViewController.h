//
//  GFSignInViewController.h
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/15.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFTextField;

@interface GFSignInViewController : UIViewController <UITextFieldDelegate>


// 账号输入框
@property (nonatomic, strong) GFTextField *userNameTxt;
// 密码输入框
@property (nonatomic, strong) GFTextField *passWordTxt;


@end
