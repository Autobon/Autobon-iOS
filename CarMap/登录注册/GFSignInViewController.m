//
//  GFSignInViewController.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/15.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFSignInViewController.h"
#import "GFTextField.h"
#import "GFSignUpViewController.h"
#import "GFForgetPwdViewController_1.h"

@interface GFSignInViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    CGFloat jianjv1;
    CGFloat jianjv2;

}
// 语言按钮
@property (nonatomic, strong) UIButton *languageBut;
// 中间标题“车邻邦”
@property (nonatomic, strong) UILabel *centerLab;
// 账号输入框
@property (nonatomic, strong) GFTextField *userNameTxt;
// 密码输入框
@property (nonatomic, strong) GFTextField *passWordTxt;
// 登录按钮
@property (nonatomic, strong) UIButton *signInBut;
// 忘记密码按钮
@property (nonatomic, strong) UIButton *forgetBut;


@end

@implementation GFSignInViewController

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
    jianjv1 = kWidth * 0.116;
    jianjv2 = kHeight * 0.03;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
}


- (void)_setView {
    
    // 语言按钮
    CGFloat languageButW = kWidth * 0.10;
    CGFloat languageButH = kHeight * 0.03;
    CGFloat languageButX = kWidth - languageButW - jianjv1;
    CGFloat languageButY = jianjv2 + 15;
    self.languageBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.languageBut.frame = CGRectMake(languageButX, languageButY, languageButW, languageButH);
    [self.languageBut setTitle:@"语言" forState:UIControlStateNormal];
    self.languageBut.titleLabel.font = [UIFont systemFontOfSize:(13 / 320.0 * kWidth)];
    [self.languageBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.languageBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.languageBut.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.view addSubview:self.languageBut];
    
    
    // 中间标题“车邻邦”
    CGFloat centerLabW = kWidth;
    CGFloat centerLabH = kHeight * 0.042;
    CGFloat centerLabX = 0;
    CGFloat centerLabY = kHeight * 0.172;
    self.centerLab = [[UILabel alloc] initWithFrame:CGRectMake(centerLabX, centerLabY, centerLabW, centerLabH)];
    self.centerLab.font = [UIFont boldSystemFontOfSize:(25 / 320.0 * kWidth)];
    self.centerLab.textAlignment = NSTextAlignmentCenter;
    self.centerLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    self.centerLab.text = @"车邻邦";
    [self.view addSubview:self.centerLab];
    
    
    // 英文lab
    CGFloat enLabW = centerLabW;
    CGFloat enLabH = kHeight * 0.022;
    CGFloat enLabX = centerLabX;
    CGFloat enLabY = CGRectGetMaxY(self.centerLab.frame) + 3;
    UILabel *enLab = [[UILabel alloc] initWithFrame:CGRectMake(enLabX, enLabY, enLabW, enLabH)];
    enLab.text = @"AUTOBON";
    enLab.textAlignment = NSTextAlignmentCenter;
    enLab.textColor = [UIColor blackColor];
    enLab.font = [UIFont systemFontOfSize:(14 / 320.0 * kWidth)];
    [self.view addSubview:enLab];
    
    
    // 账号输入框
    CGFloat userNameW = kWidth * 0.768;
    CGFloat userNameH = kHeight * 0.0625;
    CGFloat userNameX = (kWidth - userNameW) / 2.0 - 3 / 320.0 * kWidth;
    CGFloat userNameY = CGRectGetMaxY(enLab.frame) + kHeight * 0.167;
    self.userNameTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"帐号.png"] withFrame:CGRectMake(userNameX, userNameY, userNameW, userNameH)];
    self.userNameTxt.centerTxt.placeholder = @"请输入账号";
    [self.userNameTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.userNameTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.userNameTxt];
    
    
    // 密码输入框
    UIButton *passwordBut = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBut.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [passwordBut setImage:[UIImage imageNamed:@"eye-隐藏.png"] forState:UIControlStateNormal];
    [passwordBut setImage:[UIImage imageNamed:@"eye-open.png"] forState:UIControlStateSelected];
    passwordBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBut addTarget:self action:@selector(passwordButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat passWordTxtW = userNameW;
    CGFloat passWordTxtH = userNameH;
    CGFloat passWordTxtX = userNameX;
    CGFloat passWordTxtY = CGRectGetMaxY(self.userNameTxt.frame) + jianjv2;
    self.passWordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"密码.png"] withRightButton:passwordBut withFrame:CGRectMake(passWordTxtX, passWordTxtY, passWordTxtW, passWordTxtH)];
    self.passWordTxt.centerTxt.placeholder = @"请输入密码";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
//    self.passWordTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.passWordTxt];
    
    
    // 登录按钮
    CGFloat signInButW = kWidth - jianjv1 * 2 + 8;
    CGFloat signInButH = kHeight * 0.073;
    CGFloat signInButX = jianjv1 - 4;
    CGFloat signInButY = CGRectGetMaxY(self.passWordTxt.frame) + jianjv2;
    self.signInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signInBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    [self.signInBut setBackgroundImage:[UIImage imageNamed:@"默认按钮.png"] forState:UIControlStateNormal];
    [self.signInBut setBackgroundImage:[UIImage imageNamed:@"点击按钮.png"] forState:UIControlStateHighlighted];
    [self.signInBut setTitle:@"登录" forState:UIControlStateNormal];
    [self.signInBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signInBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:self.signInBut];
    
    
    // 忘记密码按钮
    CGFloat forgetButW = 100;
    CGFloat forgetButH = languageButH;
    CGFloat forgetButX = jianjv1 + 4;
    CGFloat forgetButY = CGRectGetMaxY(self.signInBut.frame) + jianjv2;
    self.forgetBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetBut.frame = CGRectMake(forgetButX, forgetButY, forgetButW, forgetButH);
    [self.forgetBut setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.forgetBut.titleLabel.font = [UIFont systemFontOfSize:(13 / 320.0 * kWidth)];
    self.forgetBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.forgetBut];
    [self.forgetBut addTarget:self action:@selector(forgetButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 注册
    CGFloat backViewW = kWidth;
    CGFloat backViewH = kHeight * 0.073;
    CGFloat backViewX = 0;
    CGFloat backViewY = kHeight - backViewH;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(backViewX, backViewY, backViewW, backViewH)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    // 上边线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backViewW, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:232 / 255.0 green:233 / 255.0 blue:234 / 255.0 alpha:1];
    [backView addSubview:lineView];
    // 左边lab
    CGFloat leftLabW = backViewW * 0.55;
    CGFloat leftLabH = backViewH;
    CGFloat leftLabX = 0;
    CGFloat leftLabY = 0;
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(leftLabX, leftLabY, leftLabW, leftLabH)];
    leftLab.text = @"还没账号？";
    leftLab.font = [UIFont systemFontOfSize:(13 / 320.0 * kWidth)];
    leftLab.textAlignment = NSTextAlignmentRight;
    leftLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    [backView addSubview:leftLab];
    // 右边按钮
    CGFloat signUpButW = backViewW - leftLabW;
    CGFloat signUpButH = leftLabH;
    CGFloat signUpButX = CGRectGetMaxX(leftLab.frame);
    CGFloat signUpButY = leftLabY;
    UIButton *signUpBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signUpBut.frame = CGRectMake(signUpButX, signUpButY, signUpButW, signUpButH);
    [signUpBut setTitle:@"注册" forState:UIControlStateNormal];
    signUpBut.titleLabel.font = [UIFont systemFontOfSize:(13 / 320.0 * kWidth)];
    [signUpBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    [signUpBut setTitleColor:[UIColor colorWithRed:249 / 255.0 green:103 / 255.0 blue:33 / 255.0 alpha:1] forState:UIControlStateHighlighted];
    signUpBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backView addSubview:signUpBut];
    [signUpBut addTarget:self action:@selector(signInButClick) forControlEvents:UIControlEventTouchUpInside];
    

}


- (void)signInButClick {
    
    GFSignUpViewController *signUpVC = [[GFSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUpVC animated:YES];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)passwordButClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passWordTxt.centerTxt.secureTextEntry = !self.passWordTxt.centerTxt.secureTextEntry;
    
    
}

- (void)forgetButClick {
    
    GFForgetPwdViewController_1 *forgetPwdVC_1 = [[GFForgetPwdViewController_1 alloc] init];
    [self.navigationController pushViewController:forgetPwdVC_1 animated:YES];
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
