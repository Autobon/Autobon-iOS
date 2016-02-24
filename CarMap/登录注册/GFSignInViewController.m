//
//  GFSignInViewController.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/15.
//  Copyright © 2016年 陈光法. All rights reserved.
//autoken="technician:1LqHwEYUIKA840yKThS7lg=="

#import "GFSignInViewController.h"
#import "GFTextField.h"
#import "GFSignUpViewController.h"
#import "GFForgetPwdViewController_1.h"
#import "GFHttpTool.h"
#import "GFAlertView.h"

#import "CLHomeOrderViewController.h"

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


@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) UIView *jiazaiBaseView;
@property (nonatomic, strong) UIImageView *imgView;

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
//    [self.view addSubview:self.languageBut];
    
    
//    // 中间标题“车邻邦”
//    CGFloat centerLabW = kWidth;
//    CGFloat centerLabH = kHeight * 0.042;
//    CGFloat centerLabX = 0;
//    CGFloat centerLabY = kHeight * 0.172;
//    self.centerLab = [[UILabel alloc] initWithFrame:CGRectMake(centerLabX, centerLabY, centerLabW, centerLabH)];
//    self.centerLab.font = [UIFont boldSystemFontOfSize:(25 / 320.0 * kWidth)];
//    self.centerLab.textAlignment = NSTextAlignmentCenter;
//    self.centerLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//    self.centerLab.text = @"车邻邦";
//    [self.view addSubview:self.centerLab];
//    
//    
//    // 英文lab
//    CGFloat enLabW = centerLabW;
//    CGFloat enLabH = kHeight * 0.022;
//    CGFloat enLabX = centerLabX;
//    CGFloat enLabY = CGRectGetMaxY(self.centerLab.frame) + 3;
//    UILabel *enLab = [[UILabel alloc] initWithFrame:CGRectMake(enLabX, enLabY, enLabW, enLabH)];
//    enLab.text = @"AUTOBON";
//    enLab.textAlignment = NSTextAlignmentCenter;
//    enLab.textColor = [UIColor blackColor];
//    enLab.font = [UIFont systemFontOfSize:(14 / 320.0 * kWidth)];
//    [self.view addSubview:enLab];
    
    CGFloat logoImgViewW = kWidth * 0.23;
    CGFloat logoImgViewH = kHeight * 0.068;
    CGFloat logoImgViewX = (kWidth - logoImgViewW) * 0.5;
    CGFloat logoImgViewY = kHeight * 0.172;
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(logoImgViewX, logoImgViewY, logoImgViewW, logoImgViewH)];
    [self.view addSubview:logoImgView];
    logoImgView.image = [UIImage imageNamed:@"LOGO"];
    
    
    // 账号输入框
    CGFloat userNameW = kWidth * 0.768;
    CGFloat userNameH = kHeight * 0.0625;
    CGFloat userNameX = (kWidth - userNameW) / 2.0 - 3 / 320.0 * kWidth;
    CGFloat userNameY = CGRectGetMaxY(logoImgView.frame) + kHeight * 0.167 * 2 / 3.0;
    self.userNameTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"user.png"] withFrame:CGRectMake(userNameX, userNameY, userNameW, userNameH)];
    self.userNameTxt.centerTxt.placeholder = @"请输入账号";
    [self.userNameTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.userNameTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.userNameTxt];
    self.userNameTxt.centerTxt.delegate = self;
    self.userNameTxt.centerTxt.tag = 100;
    self.userNameTxt.centerTxt.keyboardType = UIKeyboardTypeNumberPad;
    
    
    // 密码输入框
    UIButton *passwordBut = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBut.frame = CGRectMake(0, 0, kWidth * 0.139, kHeight * 0.037);
    [passwordBut setImage:[UIImage imageNamed:@"eyeClose.png"] forState:UIControlStateNormal];
    [passwordBut setImage:[UIImage imageNamed:@"eyeOpen.png"] forState:UIControlStateSelected];
    passwordBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBut addTarget:self action:@selector(passwordButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat passWordTxtW = userNameW;
    CGFloat passWordTxtH = userNameH;
    CGFloat passWordTxtX = userNameX;
    CGFloat passWordTxtY = CGRectGetMaxY(self.userNameTxt.frame) + jianjv2;
    self.passWordTxt = [[GFTextField alloc] initWithImage:[UIImage imageNamed:@"password.png"] withRightButton:passwordBut withFrame:CGRectMake(passWordTxtX, passWordTxtY, passWordTxtW, passWordTxtH)];
    self.passWordTxt.centerTxt.placeholder = @"请输入密码";
    [self.passWordTxt.centerTxt setValue:[UIFont systemFontOfSize:(15 / 320.0 * kWidth)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordTxt.centerTxt.secureTextEntry = YES;
//    self.passWordTxt.centerTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.passWordTxt];
    self.passWordTxt.centerTxt.delegate = self;
    self.passWordTxt.centerTxt.tag = 200;
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeDefault;
    
    
    // 登录按钮
    CGFloat signInButW = kWidth - jianjv1 * 2 + 8;
    CGFloat signInButH = kHeight * 0.073;
    CGFloat signInButX = jianjv1 - 4;
    CGFloat signInButY = CGRectGetMaxY(self.passWordTxt.frame) + jianjv2;
    self.signInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signInBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    [self.signInBut setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [self.signInBut setBackgroundImage:[UIImage imageNamed:@"buttonClick.png"] forState:UIControlStateHighlighted];
    [self.signInBut setTitle:@"登录" forState:UIControlStateNormal];
    [self.signInBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signInBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:self.signInBut];
    [self.signInBut addTarget:self action:@selector(signInButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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
    [signUpBut addTarget:self action:@selector(signUpButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 监听键盘
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)signInButClick {
    
    [self.view endEditing:YES];
    [self.tipView removeFromSuperview];
    
    self.userNameTxt.centerTxt.text =  [self.userNameTxt.centerTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];  // 小灵通
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];  // 移动
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];  // 灵通
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];  // 电信
    
    if(self.userNameTxt.centerTxt.text.length == 0) {
        
        [self tipShow:@"手机号不能为空"];
        
    }else if(([regextestmobile evaluateWithObject:self.userNameTxt.centerTxt.text] == NO)
             && ([regextestcm evaluateWithObject:self.userNameTxt.centerTxt.text] == NO)
             && ([regextestct evaluateWithObject:self.userNameTxt.centerTxt.text] == NO)
             && ([regextestcu evaluateWithObject:self.userNameTxt.centerTxt.text] == NO)) {
        
        [self tipShow:@"请输入正确的手机号"];
        
    }else if(self.passWordTxt.centerTxt.text.length == 0) {
        
        [self tipShow:@"密码不能为空"];
        
    }else {
        NSString *url = @"http://121.40.157.200:51234/api/mobile/technician/login";
        NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
        parDic[@"phone"] = self.userNameTxt.centerTxt.text;
        parDic[@"password"] = self.passWordTxt.centerTxt.text;
        
        [GFHttpTool signInPost:url parameters:parDic success:^(id responseObject) {
            
            // 判断是否登录成功
            if([responseObject[@"result"] isEqual:@1]) {
                NSLog(@"登录成功==========%@", responseObject);
                
                // 获取token 针对个人的操作要加
                NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage]; // 获得响应头
                NSLog(@"####################################\n---%@--",[cookieJar cookies]); // 获取响应头的数组
                NSUserDefaults *autokenValue = [NSUserDefaults standardUserDefaults];
                for (int i = 0; i < [cookieJar cookies].count; i++) {
                    NSHTTPCookie *cookie = [cookieJar cookies][i]; // 实例化响应头数组对象
                    
                    if ([cookie.name isEqualToString:@"autoken"]) { // 获取响应头数组对象里地名字为autoken的对象
                        
                        // 提示语
                        [UIView animateWithDuration:1.2 animations:^{
                            
                            [self tipView:CGRectGetMinY(self.userNameTxt.frame) + kHeight * 0.4 withTipmessage:responseObject[@"message"]];
                            self.signInBut.userInteractionEnabled = NO;
                            
                        } completion:^(BOOL finished) {
                            
                            [self.tipView removeFromSuperview];
                            self.signInBut.userInteractionEnabled = YES;
                            
                        }];
                        
                        
                        
                        
                        NSLog(@"############%@", [NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]); //获取响应头数组对象里地名字为autoken的对象的数据，这个数据是用来验证用户身份相当于“key”
                        
                        
                        
                        
                        [autokenValue setObject:[NSString stringWithFormat:@"%@=%@", cookie.name, cookie.value] forKey:@"autoken"];
                        break;
                    }
                }
                
                CLHomeOrderViewController *homeVC = [[CLHomeOrderViewController alloc] init];
                [self.navigationController pushViewController:homeVC animated:YES];
                
            }else if([responseObject[@"result"] isEqual:@0]) {
                
                NSLog(@"登录失败==========%@", responseObject);
                
                [UIView animateWithDuration:1.2 animations:^{
                    
                    [self tipView:CGRectGetMinY(self.userNameTxt.frame) + kHeight * 0.4 withTipmessage:responseObject[@"message"]];
                    self.signInBut.userInteractionEnabled = NO;
                    
                } completion:^(BOOL finished) {
                    
                    [self.tipView removeFromSuperview];
                    
                    self.signInBut.userInteractionEnabled = YES;
                    
                }];
                
            }
            
            
            
        } failure:^(NSError *error) {
            
            
            NSLog(@"请求失败==========%@", error);
            
            
            
        }];
    
    }
    
    
    
}

- (void)jiazaiWithStr:(NSString *)strText {
    
    
    NSString *str = strText;
    NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    CGRect strRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];

    self.jiazaiBaseView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.jiazaiBaseView];
    self.jiazaiBaseView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    

    
    
    
    
    CGFloat strLabW = strRect.size.width + 20;
    CGFloat strLabH = 40 / 320.0 * kWidth;
    CGFloat strLabX = 45;
    CGFloat strLabY = 5;
    UILabel *strLab = [[UILabel alloc] initWithFrame:CGRectMake(strLabX, strLabY, strLabW, strLabH)];
    strLab.text = strText;
    strLab.textAlignment = NSTextAlignmentCenter;
    
    
    CGFloat imgViewW = 40 / 320.0 * kWidth;
    CGFloat imgViewH = imgViewW;
    CGFloat imgViewX = 5;
    CGFloat imgViewY = 5;
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
    
    
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    for(int i=1; i<=8; i++) {
    
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
        
        [imgArr addObject:img];
    }
    
    self.imgView.animationImages = imgArr;
    self.imgView.animationDuration = 0.8;
    
    [self.imgView startAnimating];
//    [self.imgView stopAnimating];
    
    
    
    CGFloat baseViewW = imgViewW + strLabW + 10;
    CGFloat baseViewH = imgViewH + 10;
    CGFloat baseViewX = (kWidth - baseViewW) / 2.0;
    CGFloat baseViewY = kHeight * 2 / 5.0;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    [self.jiazaiBaseView addSubview:baseView];
    baseView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    baseView.layer.cornerRadius = 5;
    
    [baseView addSubview:self.imgView];
    [baseView addSubview:strLab];
    
    
}

- (void)signUpButClick {
    
    GFSignUpViewController *signUpVC = [[GFSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUpVC animated:YES];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
//    self.view.frame = CGRectMake(0, 0, kWidth, kHeight);
}

- (void)passwordButClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passWordTxt.centerTxt.secureTextEntry = !self.passWordTxt.centerTxt.secureTextEntry;
    self.passWordTxt.centerTxt.keyboardType = UIKeyboardTypeDefault;
    
}

- (void)forgetButClick {
    
    GFForgetPwdViewController_1 *forgetPwdVC_1 = [[GFForgetPwdViewController_1 alloc] init];
    [self.navigationController pushViewController:forgetPwdVC_1 animated:YES];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

//    self.view.frame = CGRectMake(0, -80, kWidth, kHeight);

    return YES;
}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    
//    if(textField.tag == 200) {
//        self.view.frame = CGRectMake(0, 0, kWidth, kHeight);
//    }
//    return YES;
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    
//    if(textField.tag == 200) {
//        self.view.frame = CGRectMake(0, 0, kWidth, kHeight);
//    }
//    
//}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//
//    self.view.frame = CGRectMake(0, 0, kWidth, kHeight);
//    
//    return YES;
//}








//kWidth * 0.768;
//kHeight * 0.0625;
//(kWidth - userNameW) / 2.0 - 3 / 320.0 * kWidth;
//CGRectGetMaxY(enLab.frame) + kHeight * 0.167 * 2 / 3.0;

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

//- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
//
//    self.view.frame = CGRectMake(0, 0, kWidth, kHeight);
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
