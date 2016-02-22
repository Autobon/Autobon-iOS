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
#import "GFHttpTool.h"
#import "GFAlertView.h"

@interface GFSignUpViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    CGFloat jianjv1;
    
    NSString *urlStr;
    
    NSInteger time;
    
    
    CGFloat verifyButOriW;
    CGFloat verifyButNewW;
}
@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) GFTextField *userNameTxt;
@property (nonatomic, strong) GFTextField *verifyTxt;
@property (nonatomic, strong) GFTextField *passWordTxt;
@property (nonatomic, strong) UIButton *passwordBut;

@property (nonatomic, strong) UIButton *verifyBut;

@property (nonatomic, strong) NSTimer *timer;



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
    
    time = 60;
    
    urlStr = @"http://121.40.157.200:51234";
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];

}

- (void)_setView {

    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"注册" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
    
    //账号输入框
    CGFloat userNameTxtW = kWidth * 0.768;
    CGFloat userNameTxtH = kHeight * 0.0625;
    CGFloat userNameTxtX = (kWidth - userNameTxtW) / 2.0 - 3 / 320.0 * kWidth;
    CGFloat userNameTxtY = jiange1 + 64;
    self.userNameTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"phone.png"] withFrame:CGRectMake(userNameTxtX, userNameTxtY, userNameTxtW, userNameTxtH)];
    self.userNameTxt.centerTxt.placeholder = @"请输入手机号";
    [self.userNameTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.userNameTxt];
    self.userNameTxt.centerTxt.keyboardType = UIKeyboardTypeNumberPad;
    self.userNameTxt.centerTxt.delegate = self;
    self.userNameTxt.centerTxt.tag = 100;
    self.userNameTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    
    
    // 验证码输入框
    NSString *nameStr = @"获取";
    NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    attDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    self.verifyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.verifyBut.frame = CGRectMake(0, 0, strRect.size.width + 20 / 320.0 * kWidth, kHeight * 0.037);
    self.verifyBut.layer.borderColor = [[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] CGColor];
    self.verifyBut.layer.borderWidth = 1;
    self.verifyBut.layer.cornerRadius = 5;
    [self.verifyBut setTitle:nameStr forState:UIControlStateNormal];
    self.verifyBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    self.verifyBut.userInteractionEnabled = NO;
    [self.verifyBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self.verifyBut addTarget:self action:@selector(verifyButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    verifyButOriW = strRect.size.width + 20 / 320.0 * kWidth;
    
    CGFloat verifyTxtW = userNameTxtW;
    CGFloat verifyTxtH = userNameTxtH;
    CGFloat verifyTxtX = userNameTxtX;
    CGFloat verifyTxtY = CGRectGetMaxY(self.userNameTxt.frame) + jiange2;
    self.verifyTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"code.png"] withRightButton:self.verifyBut withFrame:CGRectMake(verifyTxtX, verifyTxtY, verifyTxtW, verifyTxtH)];
    self.verifyTxt.centerTxt.placeholder = @"请输入验证码";
    [self.verifyTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.verifyTxt];
    self.verifyTxt.centerTxt.keyboardType = UIKeyboardTypeNumberPad;
    
    
    // 密码输入框
    self.passwordBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.passwordBut.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [self.passwordBut setImage:[UIImage imageNamed:@"eyeClose.png"] forState:UIControlStateNormal];
    [self.passwordBut setImage:[UIImage imageNamed:@"eyeOpen.png"] forState:UIControlStateSelected];
    self.passwordBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.passwordBut addTarget:self action:@selector(passwordButClick:) forControlEvents:UIControlEventTouchUpInside];

    
    CGFloat passWordTxtW = userNameTxtW;
    CGFloat passWordTxtH = userNameTxtH;
    CGFloat passWordTxtX = userNameTxtX;
    CGFloat passWordTxtY = CGRectGetMaxY(self.verifyTxt.frame) + jiange2;
    self.passWordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"passwordAgain.png"] withRightButton:self.passwordBut withFrame:CGRectMake(passWordTxtX, passWordTxtY, passWordTxtW, passWordTxtH)];
    self.passWordTxt.centerTxt.placeholder = @"请输入密码";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
    [self.view addSubview:self.passWordTxt];
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeDefault;
    self.passWordTxt.centerTxt.delegate = self;
    self.passWordTxt.centerTxt.tag = 200;
    
    
    // 提交按钮
    CGFloat submitButW = kWidth - jianjv1 * 2 + 8;
    CGFloat submitButH = kHeight * 0.073;
    CGFloat submitButX = jianjv1 - 4;
    CGFloat submitButY = CGRectGetMaxY(self.passWordTxt.frame) + jiange3;
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBut.frame = CGRectMake(submitButX, submitButY, submitButW, submitButH);
    [submitBut setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [submitBut setBackgroundImage:[UIImage imageNamed:@"buttonClick.png"] forState:UIControlStateHighlighted];
    [submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [submitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:submitBut];
    [submitBut addTarget:self action:@selector(submitBut) forControlEvents:UIControlEventTouchUpInside];
    
    
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

// 获取验证码
- (void)verifyButClick:(UIButton *)sender {
    
    
    
    NSLog(@"fasdgasdgasgsagasgsf %@", self.userNameTxt.centerTxt.text);
    
    time = 60;
    
    // 倒计时
    NSString *nameStr = @"(60)秒";
    NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    attDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    
    verifyButNewW = strRect.size.width + 20 / 320.0 * kWidth;
    
    sender.frame = CGRectMake(verifyButOriW - verifyButNewW, 0, strRect.size.width + 20 / 320.0 * kWidth, kHeight * 0.037);
    [sender setTitle:nameStr forState:UIControlStateNormal];
    sender.userInteractionEnabled = NO;
    // 计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    
    
    
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
        
        if(self.userNameTxt.centerTxt.text != nil) {
            
            NSString *url = @"http://121.40.157.200:51234/api/mobile/verifySms";
            NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
            parDic[@"phone"] = self.userNameTxt.centerTxt.text;
            
            [GFHttpTool codeGet:url parameters:parDic success:^(id responseObject) {
                
                NSLog(@"获取验证码成功======\n%@", responseObject);
                
            } failure:^(NSError *error) {
                
                NSLog(@"获取验证码失败  %@", error);
                
            }];
            
        }
        
    }

    
    
}

- (void)showTime {
    
    if(time != 0) {
        
        [self.verifyBut setTitle:[NSString stringWithFormat:@"(%ld)秒", --time] forState:UIControlStateNormal];
        
    }else {
    
        [self.verifyBut setTitle:@"再次获取" forState:UIControlStateNormal];
        self.verifyBut.userInteractionEnabled = YES;
        [self.timer invalidate];
        self.timer = nil;
    }
    
    
}

// 注册
- (void)submitBut {

    [self.view endEditing:YES];
    
    
    if(self.userNameTxt.centerTxt.text.length == 0) {
        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"手机号不能为空" withButtonNameArray:@[@"OK"]];
        [self.view addSubview:tipView];
    }else if(self.verifyTxt.centerTxt.text.length == 0) {
        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"请输入验证码" withButtonNameArray:@[@"OK"]];
        [self.view addSubview:tipView];
    }else if(self.passWordTxt.centerTxt.text.length == 0) {
        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"密码不能为空" withButtonNameArray:@[@"OK"]];
        [self.view addSubview:tipView];
//    if(self.userNameTxt.centerTxt.text.length == 0 || self.verifyTxt.centerTxt.text.length == 0 || self.passWordTxt.centerTxt.text.length == 0) {
//        
//        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"请输入注册相关信息" withButtonNameArray:@[@"OK"]];
//        [self.view addSubview:tipView];
    
    }else {
    
        NSString *url = @"http://121.40.157.200:51234/api/mobile/technician/register";
        NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
        parDic[@"phone"] = self.userNameTxt.centerTxt.text;
        parDic[@"password"] = self.passWordTxt.centerTxt.text;
        parDic[@"verifySms"] = @"123456";
        [GFHttpTool verifyPost:url parameters:parDic success:^(id responseObject) {
            
            NSLog(@"注册提交成功======\n%@", responseObject);
            
            // 返回登录界面
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        } failure:^(NSError *error) {
            NSLog(@"注册提交失败=======%@", error);
        }];
    
    }
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)passwordButClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passWordTxt.centerTxt.secureTextEntry = !self.passWordTxt.centerTxt.secureTextEntry;
    
    
}

- (void)endEitd {

    [self.view endEditing:YES];
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
