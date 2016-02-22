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
@property (nonatomic, strong) GFTextField *passWordTxt;
@property (nonatomic, strong) GFTextField *passwordTxt;

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
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的信息" withFrame:CGRectMake(0, 0, kWidth, 64)];
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
    self.passWordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"password.png"] withRightButton:passwordBut withFrame:CGRectMake(passWordTxtX, passWordTxtY, passWordTxtW, passWordTxtH)];
    self.passWordTxt.centerTxt.placeholder = @"请输入旧密码";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
    //    self.passWordTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.passWordTxt];
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeDefault;
    self.passWordTxt.centerTxt.delegate = self;
    self.passWordTxt.centerTxt.tag = 100;

    // 重置密码输入框
    UIButton *passwordBut1 = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBut1.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [passwordBut1 setImage:[UIImage imageNamed:@"eyeClose.png"] forState:UIControlStateNormal];
    [passwordBut1 setImage:[UIImage imageNamed:@"eyeOpen.png"] forState:UIControlStateSelected];
    passwordBut1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBut1 addTarget:self action:@selector(passwordButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat passwordTxtW = passWordTxtW;
    CGFloat passwordTxtH = passWordTxtH;
    CGFloat passwordTxtX = passWordTxtX;
    CGFloat passwordTxtY = CGRectGetMaxY(self.passWordTxt.frame) + kHeight * 0.024 + 10;
    self.passwordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"passwordAgain.png"] withRightButton:passwordBut1 withFrame:CGRectMake(passwordTxtX, passwordTxtY, passwordTxtW, passwordTxtH)];
    self.passwordTxt.centerTxt.placeholder = @"请输入新密码";
    [self.passwordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passwordTxt.centerTxt.secureTextEntry = YES;
    [self.view addSubview:self.passwordTxt];
    self.passwordTxt.centerTxt.keyboardType = UIKeyboardTypeDefault;
    self.passWordTxt.centerTxt.delegate = self;
    self.passWordTxt.centerTxt.tag = 200;
    
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

    NSString * pwdStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
    NSPredicate *regextestPwdStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdStr];
    if([regextestPwdStr evaluateWithObject:self.passWordTxt.centerTxt.text]) {
        
        NSLog(@"密码格式输入正确");
    }else {
        
        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"请输入8~18位由“字母、数字组合”的密码" withButtonNameArray:@[@"OK"]];
        [self.view addSubview:tipView];
        [self.view endEditing:YES];
        tipView.okBut.tag = textField.tag;
        [tipView.okBut addTarget:self action:@selector(okButClick:) forControlEvents:UIControlEventTouchUpInside];

        
    }

}

- (void)okButClick:(UIButton *)sender {

    if(sender.tag == 100) {
        
        self.passWordTxt.centerTxt.text = nil;
        
        [self.passwordTxt.centerTxt resignFirstResponder];
        [self.passWordTxt.centerTxt becomeFirstResponder];
    
    }else {
    
        
        self.passwordTxt.centerTxt.text = nil;
    }
    
    
}


- (void)submitBut {
    
    
    NSLog(@"修改密码提交界面");

    NSString *url = @"http://121.40.157.200:51234/api/mobile/technician/changePassword";
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    parDic[@"autoken"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
    parDic[@"password"] = self.passwordTxt.centerTxt.text;

    [GFHttpTool changePwdPost:url parameters:parDic success:^(id responseObject) {
        
        NSLog(@"修改成功+++++++++++ \n %@", responseObject);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"修改失败");
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

- (void)passwordButClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passwordTxt.centerTxt.secureTextEntry = !self.passwordTxt.centerTxt.secureTextEntry;
    
    
}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
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
