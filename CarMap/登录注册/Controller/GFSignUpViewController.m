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
#import "CLDelegateViewController.h"
#import "GFSignInViewController.h"


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
    UIButton *_submitBut;
}
@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) GFTextField *userNameTxt;
@property (nonatomic, strong) GFTextField *verifyTxt;
@property (nonatomic, strong) GFTextField *passWordTxt;
@property (nonatomic, strong) UIButton *passwordBut;

@property (nonatomic, strong) UIButton *verifyBut;

@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, strong) UIView *tipView;


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
    urlStr = BaseHttp;
    
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
    self.userNameTxt.centerTxt.keyboardType = UIKeyboardTypePhonePad;
    self.userNameTxt.centerTxt.delegate = self;
    self.userNameTxt.centerTxt.tag = 100;
    self.userNameTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    
    
    // 验证码输入框
    NSString *nameStr = @"获取验证";
    NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    attDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    self.verifyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.verifyBut.frame = CGRectMake(0, 0, strRect.size.width + 20 / 320.0 * kWidth, kHeight * 0.037);
    self.verifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    self.verifyBut.layer.borderWidth = 1;
    self.verifyBut.layer.cornerRadius = 5;
    [self.verifyBut setTitle:nameStr forState:UIControlStateNormal];
    self.verifyBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    [self.verifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
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
    self.verifyTxt.centerTxt.keyboardType = UIKeyboardTypePhonePad;
    
    
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
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeNamePhonePad;
    self.passWordTxt.centerTxt.placeholder = @"字母 数字8~18位";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
    [self.view addSubview:self.passWordTxt];
    self.passWordTxt.centerTxt.delegate = self;
    self.passWordTxt.centerTxt.tag = 200;
    
    
    // 提交按钮
    CGFloat submitButW = kWidth - jianjv1 * 2 + 8;
    CGFloat submitButH = kHeight * 0.073;
    CGFloat submitButX = jianjv1 - 4;
    CGFloat submitButY = CGRectGetMaxY(self.passWordTxt.frame) + jiange3;
    _submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBut.frame = CGRectMake(submitButX, submitButY, submitButW, submitButH);
    [_submitBut setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [_submitBut setBackgroundImage:[UIImage imageNamed:@"buttonClick.png"] forState:UIControlStateHighlighted];
    [_submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:_submitBut];
    [_submitBut addTarget:self action:@selector(submitBut) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    // 车邻邦服务协议
    
    CGFloat agreeLabW = kWidth;
    CGFloat agreeLabH = kHeight * 0.024;
    CGFloat agreeLabX = 0 + 18;
    CGFloat agreeLabY = CGRectGetMaxY(_submitBut.frame) + jiange2 + 19;
    UILabel *agreeLab = [[UILabel alloc] initWithFrame:CGRectMake(agreeLabX, agreeLabY, agreeLabW, agreeLabH)];
    [self.view addSubview:agreeLab];
    agreeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    agreeLab.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *MAStr = [[NSMutableAttributedString alloc] initWithString:@"我已详细阅读并同意《共享经济合作伙伴协议》"];
    [MAStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] range:NSMakeRange(9, 12)];
    agreeLab.attributedText = MAStr;
    agreeLab.font = [UIFont systemFontOfSize:10.5 / 320.0 * kWidth];
    agreeLab.userInteractionEnabled = YES;
    
    CGFloat agreeButW = kWidth / 2.0;
    CGFloat agreeButH = agreeLabH;
    CGFloat agreeButX = kWidth / 2.0;
    CGFloat agreeButY = 0;
    UIButton *agreeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBut.frame = CGRectMake(agreeButX, agreeButY, agreeButW, agreeButH);
    [agreeLab addSubview:agreeBut];
    [agreeBut addTarget:self action:@selector(agreeButClick) forControlEvents:UIControlEventTouchUpInside];
    
//    CGFloat leftLabW = kWidth * 0.608;
//    CGFloat leftLabH = kHeight * 0.024;
//    CGFloat leftLabX = 0;
//    CGFloat leftLabY = CGRectGetMaxY(submitBut.frame) + jiange2;
//    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(leftLabX, leftLabY, leftLabW, leftLabH)];
//    leftLab.text = @"点击“提交”代表本人同意";
//    leftLab.textAlignment = NSTextAlignmentRight;
//    leftLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//    leftLab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
//    [self.view addSubview:leftLab];
//    
//    CGFloat rightButW = kWidth - leftLabW;
//    CGFloat rightButH = leftLabH;
//    CGFloat rightButX = CGRectGetMaxX(leftLab.frame);
//    CGFloat rightButY = leftLabY;
//    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBut.frame = CGRectMake(rightButX, rightButY, rightButW, rightButH);
//    [rightBut setTitle:@"《车邻邦技师服务协议》" forState:UIControlStateNormal];
//    [rightBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
//    rightBut.titleLabel.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
//    rightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.view addSubview:rightBut];
    
    
    UIButton *agreeButton = [[UIButton alloc]init];
    [agreeButton setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
    [agreeButton setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateSelected];
    agreeButton.frame = CGRectMake(jianjv1 - 4 - 15, CGRectGetMidY(agreeLab.frame) - 30, 60, 60);
    [self.view addSubview:agreeButton];
    [agreeButton addTarget:self action:@selector(agreeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    agreeButton.selected = YES;
    
}


#pragma mark - 车邻邦技师服务协议按钮
- (void)agreeButClick {

    CLDelegateViewController *delegateView = [[CLDelegateViewController alloc]init];
    delegateView.delegateTitle = @"SharePartnerProtocol";
    [self.navigationController pushViewController:delegateView animated:YES];
    
}

- (void)agreeButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected == false){
        _submitBut.alpha = 0.5;
        _submitBut.userInteractionEnabled = NO;
    }else{
        _submitBut.alpha = 1.0;
        _submitBut.userInteractionEnabled = YES;
    }
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//
//    if(textField.tag == 100) {
//    
////        if(s.length == 11) {
////            statements
////        }
//        
//        
//        if(textField.text.length == 10 && range.length == 0) {
//            
//            textField.text = [NSString stringWithFormat:@"%@%@", textField.text, string];
//            
//            [self.view endEditing:YES];
//            
//        }else if(textField.text.length < 12) {
//            
//            
//            
//            NSLog(@"sf测试&&&&&&&&&&&&&&&&&");
//            self.verifyBut.userInteractionEnabled = NO;
//            [self.verifyBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
//            self.verifyBut.layer.borderColor = [[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] CGColor];
//        }
//        
//    }
//    
//    return YES;
//}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
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
////            self.verifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
//            self.verifyBut.userInteractionEnabled = YES;
//            NSLog(@"开开##################2222222222");
////            [self.verifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
//        }else {
//        
//            // 提示框
//            [UIView animateWithDuration:2 animations:^{
//                
//                [self tipView:kHeight * 0.8 withTipmessage:@"手机号格式有误,请重新输入"];
//                
//            } completion:^(BOOL finished) {
//                
//                [self.tipView removeFromSuperview];
//                
//            }];
//            
//            
//            
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
//            [self tipShow:@"密码格式错误,请输入8~18位由“字母、数字组合"];
//            
//            [self.view endEditing:YES];
//        }
//        
//    }
//    
//}

#pragma mark - 获取验证码
- (void)verifyButClick:(UIButton *)sender {
    
//    NSLog(@"获取验证码");
//    
//    NSLog(@"fasdgasdgasgsagasgsf %@", self.userNameTxt.centerTxt.text);
    
    [self.tipView removeFromSuperview];
    [self.view endEditing:YES];
    
    self.userNameTxt.centerTxt.text =  [self.userNameTxt.centerTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    
    NSPredicate *phonegextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    if(self.userNameTxt.centerTxt.text.length == 0) {
    
        [self tipShow:@"手机号不能为空"];
        
    }else if ([phonegextestct evaluateWithObject:self.userNameTxt.centerTxt.text] == YES) {
        
        
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
        

        
//        NSString *url = @"http://121.40.157.200:12345/api/pub/verifySms";
        NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
        parDic[@"phone"] = self.userNameTxt.centerTxt.text;
        
        [GFHttpTool codeGetWithParameters:parDic success:^(id responseObject) {
            
//            NSLog(@"++++++++=======%@", responseObject);
            
            NSInteger flage = [responseObject[@"status"] integerValue];
            
            if(flage == 1) {
                // 计时器
                if (self.timer == nil) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
                }
//                NSLog(@"获取验证码成功======\n%@", responseObject);
                [self tipShow:@"验证码已发送到您手机"];
            }else {
            
                [self tipShow:@"获取验证码失败"];
                sender.userInteractionEnabled = YES;
            }
            
        } failure:^(NSError *error) {
            sender.userInteractionEnabled = YES;
//            [self tipShow:@"获取验证码失败"];    
        }];
    }else {
    
        [self tipShow:@"请输入正确的手机号"];
        
    }

    
    
}

- (void)showTime {
    
    if(time != 0 && self.userNameTxt.centerTxt.text.length == 11) {
        
        self.verifyBut.userInteractionEnabled = NO;
        
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
//    if(self.userNameTxt.centerTxt.text.length == 0 || self.verifyTxt.centerTxt.text.length == 0 || self.passWordTxt.centerTxt.text.length == 0) {
//        
//        GFAlertView *tipView = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"请输入注册相关信息" withButtonNameArray:@[@"OK"]];
//        [self.view addSubview:tipView];
    
    }else {
        
        
        if ([phonegextestct evaluateWithObject:self.userNameTxt.centerTxt.text] == YES
            ) {

//            NSLog(@"是手机号");
//            NSLog(@"开开##################2222222222");
            
            if(self.verifyTxt.centerTxt.text.length == 6) {
        
            
                NSString * pwdStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
                NSPredicate *regextestPwdStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdStr];
                if([regextestPwdStr evaluateWithObject:self.passWordTxt.centerTxt.text]) {
        
//                    NSLog(@"密码格式输入正确");
                    
                    /**
                     *  提交注册
                     */
//                    NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/register";
                    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
                    parDic[@"phone"] = self.userNameTxt.centerTxt.text;
                    parDic[@"password"] = self.passWordTxt.centerTxt.text;
                    parDic[@"verifySms"] = self.verifyTxt.centerTxt.text;
                    [GFHttpTool verifyPostWithParameters:parDic success:^(id responseObject) {
                        
//                        NSLog(@"注册提交成功======\n%@", responseObject);
                        
                        NSInteger flage = [responseObject[@"status"] integerValue];
                        
                        if(flage == 0) {
                            
                            [self tipShow:responseObject[@"message"]];
                            
                        }else {
                            
                            [UIView animateWithDuration:2 animations:^{
                                
                                [self tipView:kHeight * 0.8 withTipmessage:@"注册成功"];
                                
                            } completion:^(BOOL finished) {
                                
                                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                [userDefaults setObject:self.userNameTxt.centerTxt.text forKey:@"userName"];
                                [userDefaults setObject:self.passWordTxt.centerTxt.text forKey:@"userPassword"];
                                
                                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                                UINavigationController *navVC = (UINavigationController *)window.rootViewController;
                                GFSignInViewController *vc = (GFSignInViewController *)navVC.childViewControllers[0];
                                vc.userNameTxt.centerTxt.text = self.userNameTxt.centerTxt.text;
                                vc.passWordTxt.centerTxt.text = self.passWordTxt.centerTxt.text;
                                
                                // 返回登录界面
                                [self.navigationController popToRootViewControllerAnimated:YES];
                                
                            }];
                            
                        }
                        
                        
                    } failure:^(NSError *error) {
//                        [self tipShow:@"注册失败，请重试"];
                    }];
                    
                }else {
        
                    [UIView animateWithDuration:2 animations:^{
                        [self tipView:CGRectGetMaxY(self.passWordTxt.frame) withTipmessage:@"密码由“8~18位字母、数字组合”"];
                    } completion:^(BOOL finished) {
                        [self.tipView removeFromSuperview];
                    }];
                    
                    
                    
//                    [self tipShow:@"密码由8~18位由“字母、数字组合"];
                }
                
                
            }else {
            
                [self tipShow:@"请输入正确的验证码"];
            }
            
            
            
        }else {

            // 提示框
            [self tipShow:@"请输入正确的手机号"];
        }
    
    }
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)passwordButClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passWordTxt.centerTxt.secureTextEntry = !self.passWordTxt.centerTxt.secureTextEntry;
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeNamePhonePad;
    
}

- (void)endEitd {

    [self.view endEditing:YES];
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
