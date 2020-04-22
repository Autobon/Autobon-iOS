//
//  GFChangePwdViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFChangePwdViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFHttpTool.h"
#import "GFAlertView.h"

@interface GFChangePwdViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) GFTextField *oldPassWordTxt;
@property (nonatomic, strong) GFTextField *passwordTxt;

@property (nonatomic, strong) UIView *tipView;

@end

@implementation GFChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"修改密码" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {

    // 密码输入框
    UIButton *passwordBut = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBut.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [passwordBut setImage:[UIImage imageNamed:@"eyeClose.png"] forState:UIControlStateNormal];
    [passwordBut setImage:[UIImage imageNamed:@"eyeOpen.png"] forState:UIControlStateSelected];
    passwordBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBut addTarget:self action:@selector(passwordButClick:) forControlEvents:UIControlEventTouchUpInside];

    CGFloat passWordTxtW = kWidth * 0.768;
    CGFloat passWordTxtH = kHeight * 0.0625;
    CGFloat passWordTxtX = (kWidth - passWordTxtW) / 2.0 - 3 / 320.0 * kWidth;
    CGFloat passWordTxtY = kHeight * 0.081 + 64;
    self.oldPassWordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"password.png"] withRightButton:passwordBut withFrame:CGRectMake(passWordTxtX, passWordTxtY, passWordTxtW, passWordTxtH)];
    self.oldPassWordTxt.centerTxt.font = [UIFont systemFontOfSize:(15 / 320.0 * kWidth)];
//    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.oldPassWordTxt.centerTxt setTextFieldPlaceholderString:@"请输入旧密码"];
    self.oldPassWordTxt.centerTxt.secureTextEntry = YES;
    //    self.passWordTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.oldPassWordTxt];
    self.oldPassWordTxt.centerTxt.keyboardType = UIKeyboardTypeDefault;
    self.oldPassWordTxt.centerTxt.delegate = self;
    self.oldPassWordTxt.centerTxt.tag = 1000;


    // 重置密码输入框
    UIButton *passwordBut1 = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBut1.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [passwordBut1 setImage:[UIImage imageNamed:@"eyeClose.png"] forState:UIControlStateNormal];
    [passwordBut1 setImage:[UIImage imageNamed:@"eyeOpen.png"] forState:UIControlStateSelected];
    passwordBut1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBut1 addTarget:self action:@selector(passwordBut1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat passwordTxtW = passWordTxtW;
    CGFloat passwordTxtH = passWordTxtH;
    CGFloat passwordTxtX = passWordTxtX;
    CGFloat passwordTxtY = CGRectGetMaxY(self.oldPassWordTxt.frame) + kHeight * 0.024 + 10;
    self.passwordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"passwordAgain.png"] withRightButton:passwordBut1 withFrame:CGRectMake(passwordTxtX, passwordTxtY, passwordTxtW, passwordTxtH)];
//    [self.passwordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.passwordTxt.centerTxt setTextFieldPlaceholderString:@"请输入新密码"];
    self.passwordTxt.centerTxt.font = [UIFont systemFontOfSize:(15 / 320.0 * kWidth)];
    self.passwordTxt.centerTxt.secureTextEntry = YES;
    [self.view addSubview:self.passwordTxt];
    self.passwordTxt.centerTxt.keyboardType = UIKeyboardTypeDefault;
    self.passwordTxt.centerTxt.delegate = self;
    self.passwordTxt.centerTxt.tag = 2000;

    
    // 提交按钮
    CGFloat submitButW = kWidth - kWidth * 0.116 * 2 + 8;
    CGFloat submitButH = kHeight * 0.073;
    CGFloat submitButX = kWidth * 0.116 - 4;
    CGFloat submitButY = CGRectGetMaxY(self.passwordTxt.frame) + kHeight * 0.07;
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBut.frame = CGRectMake(submitButX, submitButY, submitButW, submitButH);
    [submitBut setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [submitBut setBackgroundImage:[UIImage imageNamed:@"buttonClick.png"] forState:UIControlStateHighlighted];
    [submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [submitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:submitBut];
    [submitBut addTarget:self action:@selector(submitBut) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    [self.tipView removeFromSuperview];
    
    NSString * pwdStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
    NSPredicate *regextestPwdStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdStr];
    if([regextestPwdStr evaluateWithObject:textField.text]) {
        
//        NSLog(@"密码格式输入正确");
    }else {
        
//        NSLog(@"密码格式不正确");
        if(textField.tag == 1000) {
            
//            [textField becomeFirstResponder];
            
            [UIView animateWithDuration:1.5 animations:^{
                [self tipView:CGRectGetMaxY(self.oldPassWordTxt.frame) withTipmessage:@"密码由“8~18字母、数字组成”"];
            } completion:^(BOOL finished) {
                [self.tipView removeFromSuperview];
            }];
            
        
            
        }else {
            
//            [textField becomeFirstResponder];
        
            [UIView animateWithDuration:1.8 animations:^{
                [self tipView:CGRectGetMaxY(self.passwordTxt.frame) withTipmessage:@"密码由“8~18字母、数字组成”"];
            } completion:^(BOOL finished) {
                [self.tipView removeFromSuperview];
            }];
        }
        

        
    }

}




- (void)submitBut {
    
    NSString * pwdStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
    NSPredicate *regextestPwdStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdStr];
    BOOL flage1 = [regextestPwdStr evaluateWithObject:self.oldPassWordTxt.centerTxt.text];
    
    BOOL flage2 = [regextestPwdStr evaluateWithObject:self.passwordTxt.centerTxt.text];
    
//    NSLog(@"修改密码提交按钮");
    
//    [self.tipView removeFromSuperview];
//    [self.tipView removeFromSuperview];
    [self.view endEditing:YES];
    
    if(self.oldPassWordTxt.centerTxt.text.length == 0) {
        
        [self tipShow:@"请输入旧密码"];
    
    }else if(!flage1) {
        
        [UIView animateWithDuration:1.5 animations:^{
            [self tipView:CGRectGetMaxY(self.oldPassWordTxt.frame) withTipmessage:@"密码由“8~18字母、数字组成”"];
        } completion:^(BOOL finished) {
            [self.tipView removeFromSuperview];
        }];
        
    }else if(self.passwordTxt.centerTxt.text.length == 0) {
        
        [self tipShow:@"请输入新密码"];
    
    }else if(!flage2) {
    
        [UIView animateWithDuration:1.8 animations:^{
            [self tipView:CGRectGetMaxY(self.passwordTxt.frame) withTipmessage:@"密码由“8~18字母、数字组成”"];
        } completion:^(BOOL finished) {
            [self.tipView removeFromSuperview];
        }];
    
    }else {
        
//        NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/changePassword";
        NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
        parDic[@"autoken"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        parDic[@"oldPassword"] = self.oldPassWordTxt.centerTxt.text;
        parDic[@"newPassword"] = self.passwordTxt.centerTxt.text;
        
//        NSLog(@"\n%@", parDic);
        
        [GFHttpTool changePwdPostWithParameters:parDic success:^(id responseObject) {
            
//            NSLog(@"修改密码提交成功+++++++++++ \n %@", responseObject);
            
//            NSLog(@"#####%@  \n####%@", responseObject[@"result"], responseObject[@"message"]);
            
            NSInteger result = [responseObject[@"status"] integerValue];
            
            if(result == 1) {
            
                [UIView animateWithDuration:2 animations:^{
                    [self tipView:kHeight * 0.8 withTipmessage:@"修改成功"];
                } completion:^(BOOL finished) {
                    [self.tipView removeFromSuperview];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                    [userDefaults setObject:self.userNameTxt.centerTxt.text forKey:@"userName"];
                    [userDefaults setObject:self.passwordTxt.centerTxt.text forKey:@"userPassword"];
                    
                }];
            }else {
                
                [self tipShow:responseObject[@"message"]];
            
            }

            
        } failure:^(NSError *error) {
//            NSLog(@"修改密码提交失败---%@", error);
//            [self tipShow:@"修改密码失败"];
        }];
    
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

- (void)passwordButClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.oldPassWordTxt.centerTxt.secureTextEntry = !self.oldPassWordTxt.centerTxt.secureTextEntry;
    
    
    
}
- (void)passwordBut1Click:(UIButton *)sender {

    sender.selected = !sender.selected;
    self.passwordTxt.centerTxt.secureTextEntry = !self.passwordTxt.centerTxt.secureTextEntry;
    
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 *  提示框
 */
- (void)tipShow:(NSString *)str {
    
    [self.tipView removeFromSuperview];
    
    [UIView animateWithDuration:2 animations:^{
        
        [self tipView:kHeight * 0.8 withTipmessage:str];
        
    } completion:^(BOOL finished) {
        
        [self.tipView removeFromSuperview];
        
    }];
}

- (void)tipView:(CGFloat)tipviewY withTipmessage:(NSString *)messageStr {
    
    [self.tipView removeFromSuperview];
    
    NSString *str = messageStr;
    NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    CGRect strRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    
    CGFloat tipViewW = strRect.size.width + 30;
    CGFloat tipViewH = kHeight * 0.0625;
    CGFloat tipViewX = (kWidth - tipViewW) / 2.0;
    CGFloat tipViewY = tipviewY;
    self.tipView = [[UIView alloc] initWithFrame:CGRectMake(tipViewX, tipViewY, tipViewW, tipViewH)];
    self.tipView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.tipView.layer.cornerRadius = 7.5;
    [self.view addSubview:self.tipView];
    
    CGFloat msgLabW = tipViewW;
    CGFloat msgLabH = tipViewH;
    CGFloat msgLabX = 0;
    CGFloat msgLabY = 0;
    UILabel *msgLab = [[UILabel alloc] init];
    msgLab.frame = CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH);
    msgLab.text = messageStr;
    [self.tipView addSubview:msgLab];
    msgLab.textAlignment = NSTextAlignmentCenter;
    msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    msgLab.textColor = [UIColor whiteColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
