//
//  GFForgetPwdViewController_2.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/16.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFForgetPwdViewController_2.h"
#import "GFNavigationView.h"
#import "GFTextField.h"

@interface GFForgetPwdViewController_2 () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    
    CGFloat jianjv1;
    
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) GFTextField *passWordTxt;



@end

@implementation GFForgetPwdViewController_2

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
    
    jianjv1 = kWidth * 0.116;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    

}

- (void)_setView {

    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"返回.png" withLeftImgHightName:@"点击返回.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"重置密码" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
    // 重置密码输入框
    UIButton *passwordBut = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBut.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [passwordBut setImage:[UIImage imageNamed:@"eye-隐藏.png"] forState:UIControlStateNormal];
    [passwordBut setImage:[UIImage imageNamed:@"eye-open.png"] forState:UIControlStateSelected];
    passwordBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBut addTarget:self action:@selector(passwordButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat passWordTxtW = kWidth * 0.768;
    CGFloat passWordTxtH = kHeight * 0.0625;
    CGFloat passWordTxtX = (kWidth - passWordTxtW) / 2.0 - 3 / 320.0 * kWidth;
    CGFloat passWordTxtY = jiange1 + 64;
    self.passWordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"确认密码.png"] withRightButton:passwordBut withFrame:CGRectMake(passWordTxtX, passWordTxtY, passWordTxtW, passWordTxtH)];
    self.passWordTxt.centerTxt.placeholder = @"需要数字 字母或符号";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
    [self.view addSubview:self.passWordTxt];
    
    
    // 提交按钮
    CGFloat submitButW = kWidth - jianjv1 * 2 + 8;
    CGFloat submitButH = kHeight * 0.073;
    CGFloat submitButX = jianjv1 - 4;
    CGFloat submitButY = CGRectGetMaxY(self.passWordTxt.frame) + passWordTxtH;
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBut.frame = CGRectMake(submitButX, submitButY, submitButW, submitButH);
    [submitBut setBackgroundImage:[UIImage imageNamed:@"默认按钮.png"] forState:UIControlStateNormal];
    [submitBut setBackgroundImage:[UIImage imageNamed:@"点击按钮.png"] forState:UIControlStateHighlighted];
    [submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [submitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:submitBut];

    


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
