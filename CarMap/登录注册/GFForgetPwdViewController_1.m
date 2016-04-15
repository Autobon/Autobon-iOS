//
//  GFForgetPwdViewController_1.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/16.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFForgetPwdViewController_1.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFForgetPwdViewController_2.h"
#import "GFHttpTool.h"
#import "GFAlertView.h"


@interface GFForgetPwdViewController_1 () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    CGFloat jianjv1;
    
    
    NSInteger time;
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) GFTextField *userNameTxt;
@property (nonatomic, strong) UIButton *verifyBut;
@property (nonatomic, strong) GFTextField *verifyTxt;
@property (nonatomic, strong) GFTextField *passWordTxt;

@property (nonatomic, strong) UIView *tipView;


@end

@implementation GFForgetPwdViewController_1

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
    
    jiange1 = kHeight * 0.081;
    jiange2 = kHeight * 0.024;
    jiange3 = kHeight * 0.104;
    
    jianjv1 = kWidth * 0.116;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    time = 60;
}

- (void)_setView {

    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"找回密码" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
    
    //账号输入框
    CGFloat userNameTxtW = kWidth * 0.768;
    CGFloat userNameTxtH = kHeight * 0.0625;
    CGFloat userNameTxtX = (kWidth - userNameTxtW) / 2.0 - 3 / 320.0 * kWidth;
    CGFloat userNameTxtY = jiange1 + 64;
    self.userNameTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"phone.png"] withFrame:CGRectMake(userNameTxtX, userNameTxtY, userNameTxtW, userNameTxtH)];
    self.userNameTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    self.userNameTxt.centerTxt.placeholder = @"请输入手机号";
    [self.userNameTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.userNameTxt.centerTxt setValue:[UIFont boldSystemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.userNameTxt];
    self.userNameTxt.centerTxt.keyboardType = UIKeyboardTypeNumberPad;
    self.userNameTxt.centerTxt.delegate = self;
    self.userNameTxt.centerTxt.tag = 100;
    
    
    // 验证码输入框
    self.verifyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.verifyBut.frame = CGRectMake(0, 0, kWidth * 0.2, kHeight * 0.037);
    self.verifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    self.verifyBut.layer.borderWidth = 1;
    self.verifyBut.layer.cornerRadius = 5;
    [self.verifyBut setTitle:@"获取验证" forState:UIControlStateNormal];
    [self.verifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self.verifyBut setTitleColor:[UIColor colorWithRed:249 / 255.0 green:103 / 255.0 blue:33 / 255.0 alpha:1] forState:UIControlStateHighlighted];
    self.verifyBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    [self.verifyBut addTarget:self action:@selector(verifyButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat verifyTxtW = userNameTxtW;
    CGFloat verifyTxtH = userNameTxtH;
    CGFloat verifyTxtX = userNameTxtX;
    CGFloat verifyTxtY = CGRectGetMaxY(self.userNameTxt.frame) + jiange2;
    self.verifyTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"code.png"] withRightButton:self.verifyBut withFrame:CGRectMake(verifyTxtX, verifyTxtY, verifyTxtW, verifyTxtH)];
    self.verifyTxt.centerTxt.placeholder = @"请输入验证码";
    [self.verifyTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.verifyTxt];
    self.verifyTxt.centerTxt.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
    // 时间lab
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth * 0.2, kHeight * 0.037)];
    self.timeLab.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    self.timeLab.textAlignment = NSTextAlignmentCenter;
    self.timeLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    self.timeLab.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    self.timeLab.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    self.timeLab.layer.borderWidth = 1;
    self.timeLab.layer.cornerRadius = 5;
    self.timeLab.text = [NSString stringWithFormat:@"(%ld)秒", time];
    [self.verifyBut addSubview:self.timeLab];
    self.timeLab.hidden = YES;
    // 计时器
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    
    
//    // 验证码已发送lab
//    CGFloat showLabW = kWidth;
//    CGFloat showLabH = kHeight * 0.024;
//    CGFloat showLabX = 0;
//    CGFloat showLabY = CGRectGetMaxY(self.verifyTxt.frame) + jiange2 + 10;
//    UILabel *showLab = [[UILabel alloc] initWithFrame:CGRectMake(showLabX, showLabY, showLabW, showLabH)];
//    showLab.text = @"验证码已以短信的形式发送到您的手机中，请注意查收";
//    showLab.textAlignment = NSTextAlignmentCenter;
//    showLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//    showLab.font = [UIFont systemFontOfSize:10.5 / 320.0 * kWidth];
//    [self.view addSubview:showLab];
    
    // 重置密码输入框
    UIButton *passwordBut = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBut.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [passwordBut setImage:[UIImage imageNamed:@"eyeClose.png"] forState:UIControlStateNormal];
    [passwordBut setImage:[UIImage imageNamed:@"eyeOpen.png"] forState:UIControlStateSelected];
    passwordBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBut addTarget:self action:@selector(passwordButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat passWordTxtW = userNameTxtW;
    CGFloat passWordTxtH = userNameTxtH;
    CGFloat passWordTxtX = userNameTxtX;
    CGFloat passWordTxtY = CGRectGetMaxY(self.verifyTxt.frame) + jiange2 + 10;
    self.passWordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"passwordAgain.png"] withRightButton:passwordBut withFrame:CGRectMake(passWordTxtX, passWordTxtY, passWordTxtW, passWordTxtH)];
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeNamePhonePad;
    self.passWordTxt.centerTxt.placeholder = @"需要数字 字母或符号";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
    [self.view addSubview:self.passWordTxt];
    self.passWordTxt.centerTxt.delegate = self;
    self.passWordTxt.centerTxt.tag = 200;
    
    // 提交按钮
    CGFloat nextButW = kWidth - jianjv1 * 2 + 8;
    CGFloat nextButH = kHeight * 0.073;
    CGFloat nextButX = jianjv1 - 4;
    CGFloat nextButY = CGRectGetMaxY(self.passWordTxt.frame) + jiange2;
    UIButton *nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBut.frame = CGRectMake(nextButX, nextButY, nextButW, nextButH);
    [nextBut setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [nextBut setBackgroundImage:[UIImage imageNamed:@"buttonClick.png"] forState:UIControlStateHighlighted];
    [nextBut setTitle:@"提交" forState:UIControlStateNormal];
    [nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:nextBut];
    [nextBut addTarget:self action:@selector(nextButClick) forControlEvents:UIControlEventTouchUpInside];

    
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    
//    if(textField.tag == 100) {
//        
//        //        if(s.length == 11) {
//        //            statements
//        //        }
//        if(textField.text.length == 10 && range.length == 0) {
//            
//            /************/
//            textField.text = [NSString stringWithFormat:@"%@%@", textField.text, string];
//            
//            [self.view endEditing:YES];
//            
//        }else if(textField.text.length < 12) {
//            
//            self.verifyBut.userInteractionEnabled = NO;
//            [self.verifyBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
//            self.verifyBut.layer.borderColor = [[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] CGColor];
//            self.timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//            self.timeLab.layer.borderColor = [[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] CGColor];
//        }
//        
//    }
//    
//    return YES;
//}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    
//    
//    
//    if(textField.tag == 100) {
//        self.userNameTxt.centerTxt.text =  [self.userNameTxt.centerTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//        NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//        NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//        NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];  // 小灵通
//        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];  // 移动
//        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];  // 灵通
//        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];  // 电信
//        
//        if (([regextestmobile evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)
//            || ([regextestcm evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)
//            || ([regextestct evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)
//            || ([regextestcu evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)) {
//            
//            NSLog(@"是手机号");
//            
//            self.verifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
//            self.verifyBut.userInteractionEnabled = YES;
//            [self.verifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
//        }else {
//            
//            /**
//             *  提示框
//             */
//            [self tipShow:@"手机号格式有误,请重新输入"];
//            [self.view endEditing:YES];
//        }
//    }
//    
//    if(textField.tag == 200) {
//        
//        NSString * pwdStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
//        NSPredicate *regextestPwdStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdStr];
//        if([regextestPwdStr evaluateWithObject:self.passWordTxt.centerTxt.text]) {
//            
//            NSLog(@"密码格式输入正确");
//        }else {
//
//            /**
//             *  提示框
//             */
//            [self tipShow:@"密码格式错误，请输入8~18位由“字母、数字组合"];
//            [self.view endEditing:YES];
//        }
//        
//    }
//    
//}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)verifyButClick:(UIButton *)sender {
    
    [self.tipView removeFromSuperview];
    
    [self.view endEditing:YES];
    
    self.userNameTxt.centerTxt.text =  [self.userNameTxt.centerTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";

    NSPredicate *phonegextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];

    if(self.userNameTxt.centerTxt.text.length == 0) {
        
        [self tipShow:@"手机号不能为空"];
        
    }else if (([phonegextestct evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)
        ) {

        time = 60;
        sender.userInteractionEnabled = NO;
        
        // 获取验证码
        NSString *url = @"http://121.40.157.200:12345/api/pub/verifySms";
        NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
        parDic[@"phone"] = self.userNameTxt.centerTxt.text;
        
        [GFHttpTool codeGet:url parameters:parDic success:^(id responseObject) {
            
//            NSLog(@"获取验证码成功======\n%@", responseObject);
            
            NSInteger flage = [responseObject[@"result"] integerValue];
            
            if(flage == 1) {
                // 计时器
                if (self.timer == nil) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
                    self.timeLab.text = [NSString stringWithFormat:@"(%ld)秒", time];
                    self.timeLab.hidden = NO;
                }
                [self tipShow:@"验证码已发送到您手机"];
            }else {
                sender.userInteractionEnabled = YES;
                [self tipShow:@"获取验证码失败"];
            }
            
            
        } failure:^(NSError *error) {
            sender.userInteractionEnabled = YES;
            [self tipShow:@"获取验证码失败"];
            
        }];
        

        
    }else {
    
        [self tipShow:@"请输入正确的手机号"];
        
    }
    

}

- (void)showTime {
    if(time != 0 && self.userNameTxt.centerTxt.text.length == 11) {
        
        time--;
        self.timeLab.text = [NSString stringWithFormat:@"(%ld)秒", time];
        
    }else {
        
        self.verifyBut.userInteractionEnabled = YES;
        [self.verifyBut setTitle:@"再次获取" forState:UIControlStateNormal];
        self.timeLab.hidden = YES;
        [self.timer invalidate];
        self.timer = nil;
    
    }
    
    
}

- (void)nextButClick {
    
    [self.view endEditing:YES];
    [self.tipView removeFromSuperview];
    
    self.userNameTxt.centerTxt.text =  [self.userNameTxt.centerTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    
    NSPredicate *phonegextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    if(self.userNameTxt.centerTxt.text.length == 0) {
        
        [self tipShow:@"手机号不能为空"];
    }else if([phonegextestct evaluateWithObject:self.userNameTxt.centerTxt.text] == NO)
              {
        
        [self tipShow:@"请输入正确的手机号"];
        
    }else if(self.verifyTxt.centerTxt.text.length == 0) {
        
        [self tipShow:@"验证码不能为空"];
    }else if(self.self.verifyTxt.centerTxt.text.length < 6) {
        
        [self tipShow:@"请输入正确的验证码"];
        
    }else if(self.passWordTxt.centerTxt.text.length == 0) {
        
        [self tipShow:@"密码不能为空"];
    }else {
        
        

        if ([phonegextestct evaluateWithObject:self.userNameTxt.centerTxt.text] == YES
            ) {

            if(self.verifyTxt.centerTxt.text.length == 6) {
                
                NSString * pwdStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
                NSPredicate *regextestPwdStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdStr];
                if([regextestPwdStr evaluateWithObject:self.passWordTxt.centerTxt.text]) {
        
                    
                            NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/resetPassword";
                            NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
                            parDic[@"phone"] = self.userNameTxt.centerTxt.text;
                            parDic[@"verifySms"] = self.verifyTxt.centerTxt.text;
                            parDic[@"password"] = self.passWordTxt.centerTxt.text;
                            
                            [GFHttpTool forgetPwdPost:url parameters:parDic success:^(id responseObject) {
                                
//                                NSLog(@"找回密码成功++++++++++%@", responseObject);
                                
                                NSInteger flage = [responseObject[@"result"] integerValue];
                                
                                if(flage == 1) {
                                    [UIView animateWithDuration:2 animations:^{
                                        
                                        [self tipView:kHeight * 0.8 withTipmessage:@"密码修改成功"];
                                        
                                        
                                    } completion:^(BOOL finished) {
                                        
                                        [self.navigationController popViewControllerAnimated:YES];
                                        
                                    }];
                                }else {
                                
                                    [self tipShow:responseObject[@"message"]];
                                
                                }
                                
                                
                                
                                
                                
                                
                                
                            } failure:^(NSError *error) {
                                
                                
                                [self tipShow:@"找回密码失败"];
                            }];

                    
                }else {

                    [UIView animateWithDuration:2 animations:^{
                        [self tipView:CGRectGetMaxY(self.passWordTxt.frame) withTipmessage:@"密码由“8~18位字母、数字组合”"];
                    } completion:^(BOOL finished) {
                        [self.tipView removeFromSuperview];
                    }];
                }
                
                
            }else {
            
                [self tipShow:@"请输入正确地验证码"];
            }

        }else {

            [self tipShow:@"请输入正确的手机号"];
        }
        
    
    }
    
}

- (void)passwordButClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passWordTxt.centerTxt.secureTextEntry = !self.passWordTxt.centerTxt.secureTextEntry;
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeNamePhonePad;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}




- (void)tipShow:(NSString *)str {
    
    
    [UIView animateWithDuration:2 animations:^{
        
        [self tipView:kHeight * 0.8 withTipmessage:str];
        
    } completion:^(BOOL finished) {
        
        [self.tipView removeFromSuperview];
        
    }];
}

- (void)tipView:(CGFloat)tipviewY withTipmessage:(NSString *)messageStr {
    
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
    UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
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
