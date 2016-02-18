//
//  GFSignUpViewController.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/15.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFSignUpViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"

@interface GFSignUpViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    CGFloat jianjv1;
}
@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) GFTextField *userNameTxt;
@property (nonatomic, strong) GFTextField *verifyTxt;
@property (nonatomic, strong) GFTextField *passWordTxt;



@end

@implementation GFSignUpViewController

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

}

- (void)_setView {

    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"返回.png" withLeftImgHightName:@"点击返回.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"注册" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
    
    //账号输入框
    CGFloat userNameTxtW = kWidth * 0.768;
    CGFloat userNameTxtH = kHeight * 0.0625;
    CGFloat userNameTxtX = (kWidth - userNameTxtW) / 2.0 - 3 / 320.0 * kWidth;
    CGFloat userNameTxtY = jiange1 + 64;
    self.userNameTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"手机.png"] withFrame:CGRectMake(userNameTxtX, userNameTxtY, userNameTxtW, userNameTxtH)];
    self.userNameTxt.centerTxt.placeholder = @"请输入手机号";
    [self.userNameTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.userNameTxt];
    
    
    // 验证码输入框
    UIButton *verifyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    verifyBut.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    verifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    verifyBut.layer.borderWidth = 1;
    verifyBut.layer.cornerRadius = 5;
    [verifyBut setTitle:@"验证" forState:UIControlStateNormal];
    [verifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    verifyBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    
    CGFloat verifyTxtW = userNameTxtW;
    CGFloat verifyTxtH = userNameTxtH;
    CGFloat verifyTxtX = userNameTxtX;
    CGFloat verifyTxtY = CGRectGetMaxY(self.userNameTxt.frame) + jiange2;
    self.verifyTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"验证.png"] withRightButton:verifyBut withFrame:CGRectMake(verifyTxtX, verifyTxtY, verifyTxtW, verifyTxtH)];
    self.verifyTxt.centerTxt.placeholder = @"请输入验证码";
    [self.verifyTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.verifyTxt];
    
    
    // 密码输入框
    UIButton *passwordBut = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBut.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [passwordBut setImage:[UIImage imageNamed:@"eye-隐藏.png"] forState:UIControlStateNormal];
    [passwordBut setImage:[UIImage imageNamed:@"eye-open.png"] forState:UIControlStateSelected];
    passwordBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBut addTarget:self action:@selector(passwordButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat passWordTxtW = userNameTxtW;
    CGFloat passWordTxtH = userNameTxtH;
    CGFloat passWordTxtX = userNameTxtX;
    CGFloat passWordTxtY = CGRectGetMaxY(self.verifyTxt.frame) + jiange2;
    self.passWordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"确认密码.png"] withRightButton:passwordBut withFrame:CGRectMake(passWordTxtX, passWordTxtY, passWordTxtW, passWordTxtH)];
    self.passWordTxt.centerTxt.placeholder = @"请输入密码";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
    [self.view addSubview:self.passWordTxt];
    
    
    // 提交按钮
    CGFloat submitButW = kWidth - jianjv1 * 2 + 8;
    CGFloat submitButH = kHeight * 0.073;
    CGFloat submitButX = jianjv1 - 4;
    CGFloat submitButY = CGRectGetMaxY(self.passWordTxt.frame) + jiange3;
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBut.frame = CGRectMake(submitButX, submitButY, submitButW, submitButH);
    [submitBut setBackgroundImage:[UIImage imageNamed:@"默认按钮.png"] forState:UIControlStateNormal];
    [submitBut setBackgroundImage:[UIImage imageNamed:@"点击按钮.png"] forState:UIControlStateHighlighted];
    [submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [submitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:submitBut];
    
    
    // 车邻邦服务协议
    CGFloat leftLabW = kWidth * 0.608;
    CGFloat leftLabH = kHeight * 0.024;
    CGFloat leftLabX = 0;
    CGFloat leftLabY = CGRectGetMaxY(submitBut.frame) + jiange2;
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(leftLabX, leftLabY, leftLabW, leftLabH)];
    leftLab.text = @"点击“提交”代表本人已阅读并同意";
    leftLab.textAlignment = NSTextAlignmentRight;
    leftLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    leftLab.font = [UIFont systemFontOfSize:10.5 / 320.0 * kWidth];
    [self.view addSubview:leftLab];
    
    CGFloat rightButW = kWidth - leftLabW;
    CGFloat rightButH = leftLabH;
    CGFloat rightButX = CGRectGetMaxX(leftLab.frame);
    CGFloat rightButY = leftLabY;
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame = CGRectMake(rightButX, rightButY, rightButW, rightButH);
    [rightBut setTitle:@"《车邻邦服务协议》" forState:UIControlStateNormal];
    [rightBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    rightBut.titleLabel.font = [UIFont systemFontOfSize:10.5 / 320.0 * kWidth];
    rightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:rightBut];

    
    
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
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
