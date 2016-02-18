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
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"返回.png" withLeftImgHightName:@"点击返回.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"找回密码" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
    
    //账号输入框
    CGFloat userNameTxtW = kWidth * 0.768;
    CGFloat userNameTxtH = kHeight * 0.0625;
    CGFloat userNameTxtX = (kWidth - userNameTxtW) / 2.0 - 3 / 320.0 * kWidth;
    CGFloat userNameTxtY = jiange1 + 64;
    self.userNameTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"手机.png"] withFrame:CGRectMake(userNameTxtX, userNameTxtY, userNameTxtW, userNameTxtH)];
    self.userNameTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    self.userNameTxt.centerTxt.placeholder = @"+86 13868886888";
    [self.userNameTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.userNameTxt.centerTxt setValue:[UIFont boldSystemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.userNameTxt];
    
    
    // 验证码输入框
    self.verifyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.verifyBut.frame = CGRectMake(0, 0, kWidth * 0.2, kHeight * 0.037);
    self.verifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    self.verifyBut.layer.borderWidth = 1;
    self.verifyBut.layer.cornerRadius = 5;
    [self.verifyBut setTitle:@"再次获取" forState:UIControlStateNormal];
    [self.verifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self.verifyBut setTitleColor:[UIColor colorWithRed:249 / 255.0 green:103 / 255.0 blue:33 / 255.0 alpha:1] forState:UIControlStateHighlighted];
    self.verifyBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    [self.verifyBut addTarget:self action:@selector(verifyButClick:) forControlEvents:UIControlEventTouchUpInside];
    self.verifyBut.userInteractionEnabled = NO;
    
    CGFloat verifyTxtW = userNameTxtW;
    CGFloat verifyTxtH = userNameTxtH;
    CGFloat verifyTxtX = userNameTxtX;
    CGFloat verifyTxtY = CGRectGetMaxY(self.userNameTxt.frame) + jiange2;
    self.verifyTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"验证.png"] withRightButton:self.verifyBut withFrame:CGRectMake(verifyTxtX, verifyTxtY, verifyTxtW, verifyTxtH)];
    self.verifyTxt.centerTxt.placeholder = @"请输入验证码";
    [self.verifyTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.verifyTxt];
    
    
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
    // 计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    
    
    // 验证码已发送lab
    CGFloat showLabW = kWidth;
    CGFloat showLabH = kHeight * 0.024;
    CGFloat showLabX = 0;
    CGFloat showLabY = CGRectGetMaxY(self.verifyTxt.frame) + jiange2 + 10;
    UILabel *showLab = [[UILabel alloc] initWithFrame:CGRectMake(showLabX, showLabY, showLabW, showLabH)];
    showLab.text = @"验证码已以短信的形式发送到您的手机中，请注意查收";
    showLab.textAlignment = NSTextAlignmentCenter;
    showLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    showLab.font = [UIFont systemFontOfSize:10.5 / 320.0 * kWidth];
    [self.view addSubview:showLab];
    
    // 下一步按钮
    CGFloat nextButW = kWidth - jianjv1 * 2 + 8;
    CGFloat nextButH = kHeight * 0.073;
    CGFloat nextButX = jianjv1 - 4;
    CGFloat nextButY = CGRectGetMaxY(showLab.frame) + 10;
    UIButton *nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBut.frame = CGRectMake(nextButX, nextButY, nextButW, nextButH);
    [nextBut setBackgroundImage:[UIImage imageNamed:@"默认按钮.png"] forState:UIControlStateNormal];
    [nextBut setBackgroundImage:[UIImage imageNamed:@"点击按钮.png"] forState:UIControlStateHighlighted];
    [nextBut setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:nextBut];
    [nextBut addTarget:self action:@selector(nextButClick) forControlEvents:UIControlEventTouchUpInside];

    
    
}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)verifyButClick:(UIButton *)sender {
    time = 60;
    self.timeLab.text = [NSString stringWithFormat:@"(%ld)秒", time];
    self.timeLab.hidden = NO;
    sender.userInteractionEnabled = NO;
    
    // 计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
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

    GFForgetPwdViewController_2 *forgetPwd_2 = [[GFForgetPwdViewController_2 alloc] init];
    [self.navigationController pushViewController:forgetPwd_2 animated:YES];
    
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
