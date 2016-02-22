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
    self.userNameTxt.centerTxt.placeholder = @"+86 13868886888";
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
//    self.verifyBut.userInteractionEnabled = NO;
    self.verifyBut.userInteractionEnabled = NO;
    [self.verifyBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.verifyBut.layer.borderColor = [[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] CGColor];
    
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
    self.passWordTxt.centerTxt.placeholder = @"需要数字 字母或符号";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
    [self.view addSubview:self.passWordTxt];
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeDefault;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField.tag == 100) {
        
        //        if(s.length == 11) {
        //            statements
        //        }
        if(textField.text.length == 10 && range.length == 0) {
            
            textField.text = [NSString stringWithFormat:@"%@%@", textField.text, string];
            
            [self.view endEditing:YES];
            
        }else if(textField.text.length < 12) {
            
            self.verifyBut.userInteractionEnabled = NO;
            [self.verifyBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
            self.verifyBut.layer.borderColor = [[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] CGColor];
        }
        
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
    
    if(textField.tag == 100) {
        self.userNameTxt.centerTxt.text =  [self.userNameTxt.centerTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
        NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
        NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];  // 小灵通
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];  // 移动
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];  // 灵通
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];  // 电信
        
        if (([regextestmobile evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)
            || ([regextestcm evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)
            || ([regextestct evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)
            || ([regextestcu evaluateWithObject:self.userNameTxt.centerTxt.text] == YES)) {
            
            NSLog(@"是手机号");
            
            self.verifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
            self.verifyBut.userInteractionEnabled = YES;
            [self.verifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        }else {
            
            GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"手机号格式有误,请重新输入" withButtonNameArray:@[@"OK"]];
            [self.view addSubview:tipView];
            [self.view endEditing:YES];
        }
    }
    
    if(textField.tag == 200) {
        
        NSString * pwdStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
        NSPredicate *regextestPwdStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdStr];
        if([regextestPwdStr evaluateWithObject:self.passWordTxt.centerTxt.text]) {
            
            NSLog(@"密码格式输入正确");
        }else {
            
            GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"请输入8~18位由“字母、数字组合”的密码" withButtonNameArray:@[@"OK"]];
            [self.view addSubview:tipView];
            [self.view endEditing:YES];
        }
        
    }
    
}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)verifyButClick:(UIButton *)sender {
    
    
    
    
    // 获取验证码
    NSString *url = @"http://121.40.157.200:51234/api/mobile/verifySms";
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    parDic[@"phone"] = self.userNameTxt.centerTxt.text;
    
    [GFHttpTool codeGet:url parameters:parDic success:^(id responseObject) {
        
        NSLog(@"获取验证码成功======\n%@", responseObject);
        
    } failure:^(NSError *error) {
        
        NSLog(@"获取验证码失败  %@", error);
        
    }];
    
    time = 60;
    self.timeLab.text = [NSString stringWithFormat:@"(%ld)秒", time];
    self.timeLab.hidden = NO;
    sender.userInteractionEnabled = NO;
    
    // 计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    
    self.timeLab.hidden = NO;
}

- (void)showTime {
    if(time != 0) {
        time--;
        self.timeLab.text = [NSString stringWithFormat:@"(%ld)秒", time];
    }else {
        

        self.timeLab.hidden = YES;
        self.verifyBut.userInteractionEnabled = YES;
        
        [self.timer invalidate];
        self.timer = nil;
    }
    
    
}

- (void)nextButClick {
    
    if(self.userNameTxt.centerTxt.text.length == 0) {
        
        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"手机号不能为空" withButtonNameArray:@[@"OK"]];
        [self.view addSubview:tipView];
    }else if(self.verifyTxt.centerTxt.text.length == 0) {
        
        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"请输入验证码" withButtonNameArray:@[@"OK"]];
        [self.view addSubview:tipView];
    }else if(self.passWordTxt.centerTxt.text.length == 0) {
        
        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"密码不能为空" withButtonNameArray:@[@"OK"]];
        [self.view addSubview:tipView];
    }else {
    
        NSString *url = @"http://121.40.157.200:51234/api/mobile/technician/resetPassword";
        NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
        parDic[@"phone"] = self.userNameTxt.centerTxt.text;
        parDic[@"verifySms"] = self.verifyTxt.centerTxt.text;
        parDic[@"password"] = self.passWordTxt.centerTxt.text;

        [GFHttpTool forgetPwdPost:url parameters:parDic success:^(id responseObject) {
            
            NSLog(@"找回密码成功++++++++++%@", responseObject);
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"找回密码失败————————————————%@", error);
            
        }];
    }
    
}

- (void)passwordButClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passWordTxt.centerTxt.secureTextEntry = !self.passWordTxt.centerTxt.secureTextEntry;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
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
