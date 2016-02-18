//
//  CLCertifyViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/16.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLCertifyViewController.h"
#import "GFTextField.h"
#import "GFNavigationView.h"
#import "CLTitleView.h"
#import "CLTouchScrollView.h"
#import "GFAlertView.h"
//#import "CLHomeViewController.h"
//#import "CLOrderViewController.h"
#import "CLHomeOrderViewController.h"


@interface CLCertifyViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *_chooseView;
    CLTouchScrollView *_scrollView;
    UIImageView *_headImage;
    UIImageView *_identityImageView;
    BOOL _isHeadImage;
}
@end

@implementation CLCertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor cyanColor];
    [self setNavigation];
    
    [self setViewForCertify];
}

- (void)setViewForCertify{
    _scrollView = [[CLTouchScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
//    scrollView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:_scrollView];
    
//头像
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 80, 80)];
    _headImage.image = [UIImage imageNamed:@"userHeadImage"];
    _headImage.layer.cornerRadius = 40;
    _headImage.clipsToBounds = YES;
//    headImage.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_headImage];
    
    UIButton *cameraHeadBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, 80, 20, 20)];
    [cameraHeadBtn setImage:[UIImage imageNamed:@"cameraHead"] forState:UIControlStateNormal];
    cameraHeadBtn.tag = 1;
    [cameraHeadBtn addTarget:self action:@selector(cameraHeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:cameraHeadBtn];
    
    GFTextField *userNameTextField = [[GFTextField alloc]initWithPlaceholder:@"姓名" withFrame:CGRectMake(110, 20, self.view.frame.size.width - 140, 50)];
    [_scrollView addSubview:userNameTextField];
    
    GFTextField *identityTextField = [[GFTextField alloc]initWithPlaceholder:@"身份证号" withFrame:CGRectMake(110, 80, self.view.frame.size.width - 140, 50)];
    identityTextField.centerTxt.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    identityTextField.centerTxt.delegate = self;
    identityTextField.centerTxt.tag = 2;
    [_scrollView addSubview:identityTextField];
    
// 技能项目
    CLTitleView *skillView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 145, self.view.frame.size.width, 45) Title:@"技能项目"];
    [_scrollView addSubview:skillView];
    
    UIButton *carButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, self.view.frame.size.width/2-60, 40)];
    [carButton setTitle:@"汽车贴膜" forState:UIControlStateNormal];
    carButton.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    carButton.layer.cornerRadius = 15;
    [carButton setTitleColor:[[UIColor alloc]initWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
    carButton.tag = 1;
    [carButton addTarget:self action:@selector(skillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:carButton];
    
    UIButton *cleanButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+10, 200, self.view.frame.size.width/2-60, 40)];
    [cleanButton setTitle:@"美容清洁" forState:UIControlStateNormal];
    cleanButton.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    cleanButton.layer.cornerRadius = 15;
    [cleanButton setTitleColor:[[UIColor alloc]initWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
    cleanButton.tag = 1;
    [cleanButton addTarget:self action:@selector(skillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:cleanButton];
    
// 证件照
    CLTitleView *identityView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 45) Title:@"手持身份证正面照"];
    [_scrollView addSubview:identityView];
    
    _identityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, 310, self.view.frame.size.width*3/5, self.view.frame.size.width*27/70)];
    _identityImageView.image = [UIImage imageNamed:@"userImage"];
    [_scrollView addSubview:_identityImageView];
    
    UIButton *cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*4/5-15, 310+self.view.frame.size.width*27/70-25, 30, 30)];
    [cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(cameraHeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:cameraBtn];
    
// 银行卡信息
    
    CLTitleView *bankView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 310+self.view.frame.size.width*27/70 + 10, self.view.frame.size.width, 45) Title:@"银行卡信息"];
    [_scrollView addSubview:bankView];
    
    UIButton *bankButton = [[UIButton alloc]initWithFrame:CGRectMake(10, bankView.frame.origin.y+45+10, self.view.frame.size.width/2-15, 40)];
    
    [bankButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [bankButton setTitle:@"农业银行" forState:UIControlStateNormal];
    [bankButton setTitleColor:[UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:1] forState:UIControlStateNormal];
//    bankButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    bankButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    bankButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [bankButton addTarget:self action:@selector(bankBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:bankButton];
    
    UIButton *whereButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+5, bankView.frame.origin.y+45+10, self.view.frame.size.width/2-15, 40)];
    
    [whereButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [whereButton setTitle:@"开户地点" forState:UIControlStateNormal];
    [whereButton setTitleColor:[UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:1] forState:UIControlStateNormal];
//    whereButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    whereButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    whereButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [whereButton addTarget:self action:@selector(whereBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:whereButton];
    
// 银行卡号
    GFTextField *bankNumberTextField = [[GFTextField alloc]initWithPlaceholder:@"银行卡号" withFrame:CGRectMake(60, bankView.frame.origin.y+45+15+60, self.view.frame.size.width-120, 40)];
    bankNumberTextField.centerTxt.keyboardType = UIKeyboardTypeNumberPad;
    bankNumberTextField.centerTxt.delegate = self;
    bankNumberTextField.centerTxt.tag = 5;
    [_scrollView addSubview:bankNumberTextField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, bankNumberTextField.frame.origin.y+40+40, self.view.frame.size.width, 2)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];
    
// 提交按钮
    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake(30, lineView.frame.origin.y+2+10, self.view.frame.size.width-60, 40)];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:submitButton];
    
    UILabel *submitLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-156, lineView.frame.origin.y+2+50, 180, 30)];
    submitLabel.text = @"点击\"提交\"代表本人已阅读并同意";
//    submitLabel.backgroundColor = [UIColor cyanColor];
    submitLabel.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:submitLabel];
    
    UIButton *delegateButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-156+180, lineView.frame.origin.y+2+50, 132, 30)];
//    delegateButton.backgroundColor = [UIColor cyanColor];
    [delegateButton setTitle:@"《车邻邦技师认证协议》" forState:UIControlStateNormal];
    delegateButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [delegateButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    [delegateButton addTarget:self action:@selector(delegateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:delegateButton];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, delegateButton.frame.origin.y + 30 + 60);
    
    
    
}

#pragma mark - 认证协议
- (void)delegateBtnClick{
    NSLog(@"是时候看看协议了");
}

#pragma mark - 提交按钮事件
- (void)submitBtnClick{
    NSLog(@"提交按钮事件");
    GFAlertView *alertView = [[GFAlertView alloc]initWithTipName:@"提交成功" withTipMessage:@"恭喜您资料提交成功，我们将会在一个工作日内审核信息并以短信的形式告知结果，请注意查收！" withButtonNameArray:@[@"OK"]];
    [alertView.okBut addTarget:self action:@selector(alertBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertView];
}

#pragma mark - 警告框 OK
- (void)alertBtnClick{
    CLHomeOrderViewController *homeView = [[CLHomeOrderViewController alloc]init];
    [self.navigationController pushViewController:homeView animated:YES];
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    window.rootViewController = homeView;
//    NSLog(@"----shuohsuokanal--");
    
}
#pragma mark - 银行类型按钮事件
- (void)bankBtnClick:(UIButton *)button{
    NSLog(@"选择银行");
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, button.frame.origin.y + 40, button.frame.size.width , 100) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor cyanColor];
    [_scrollView addSubview:tableView];
    
    
}
#pragma mark - tableView协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"银行卡操作";
    
    return cell;
}

#pragma mark - 开户地点按钮事件
-(void)whereBtnClick:(UIButton *)button{
    NSLog(@"选择开户地点");
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+5, button.frame.origin.y + 40, button.frame.size.width , 100) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor cyanColor];
    [_scrollView addSubview:tableView];
}


#pragma mark - 银行卡号对话框协议
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 5) {
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _scrollView.contentSize.height+200);
        _scrollView.contentOffset = CGPointMake(0, _scrollView.contentSize.height-self.view.frame.size.height);
    }
    
   
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 5) {
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _scrollView.contentSize.height-200);
        if ([self checkCardNo:textField.text]) {
            NSLog(@"银行卡号正确");
        }else{
            NSLog(@"银行卡号码格式错误");
        }
    }else{
        
        if ([self validateIdentityCard:textField.text]) {
            NSLog(@"身份证号正确");
        }else{
            NSLog(@"身份证号码格式错误");
        }
    }
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 5) {
        NSLog(@"---range--%@----%@---string--%@--",@(range.location),@(range.length),string);
        if (range.length == 0) {
            if (range.location%5 == 4) {
                textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
            }
        }
    }
    
    return YES;
}


#pragma mark - 技能按钮
- (void)skillBtnClick:(UIButton *)button{
    [self.view endEditing:YES];
    if (button.tag == 1) {
        button.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 2;
    }else{
        button.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [button setTitleColor:[[UIColor alloc]initWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.tag = 1;
    }
}

#pragma mark - 相机按钮的实现方法
- (void)cameraHeadBtnClick:(UIButton *)button{
    [self.view endEditing:YES];
    _scrollView.userInteractionEnabled = NO;
    if (button.tag == 1) {
        _isHeadImage = YES;
    }else{
        _isHeadImage = NO;
    }
    _chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 80)];
    _chooseView.center = self.view.center;
    _chooseView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    _chooseView.layer.cornerRadius = 15;
    _chooseView.clipsToBounds = YES;
    [self.view addSubview:_chooseView];
    
// 相机和相册按钮
    UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 40)];
    [cameraButton setTitle:@"相册" forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
    cameraButton.tag = 1;
    [_chooseView addSubview:cameraButton];
    
    UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-100, 40)];
    [photoButton setTitle:@"相机" forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
    photoButton.tag = 2;
    [_chooseView addSubview:photoButton];
    
    
}


#pragma mark - 选择照片
- (void)userHeadChoose:(UIButton *)button{
    [_chooseView removeFromSuperview];
    _scrollView.userInteractionEnabled = YES;
    if (button.tag == 1) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate =self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        NSLog(@"打开相机");
        BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (result) {
            NSLog(@"---支持使用相机---");
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            // 编辑模式
//            imagePicker.allowsEditing = YES;
            [self  presentViewController:imagePicker animated:YES completion:^{
            }];
        }else{
            NSLog(@"----不支持使用相机----");
        }
        
    }
    
    
}

#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_isHeadImage) {
        _headImage.image = image;
    }else{
        _identityImageView.image = image;
        _identityImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 添加导航
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"我要认证" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    
}
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"更多");
}

#pragma mark - 身份证号正则表达式
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


#pragma mark - 判断是否是有效的银行卡号
//+ (BOOL) isValidCreditNumber:(NSString*)value {
//    BOOL result = NO;
//    NSInteger length = [value length];
//    if (length >= 13) {
//        result = [WTCreditCard isValidNumber:value];
//        if (result)
//        {
//            NSInteger twoDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 2)] integerValue];
//            //VISA
//            if([WTCreditCard isStartWith:value Str:@"4"]) {
//                if (13 == length||16 == length) {
//                    result = TRUE;
//                }else {
//                    result = NO;
//                }
//            }
//            //MasterCard
//            else if(twoDigitBeginValue >= 51 && twoDigitBeginValue <= 55 && length == 16) {
//                result = TRUE;
//            }
//            //American Express
//            else if(([WTCreditCard isStartWith:value Str:@"34"]||[WTCreditCard isStartWith:value Str:@"37"]) && length == 15){
//                result = TRUE;
//            }
//            //Discover
//            else if([WTCreditCard isStartWith:value Str:@"6011"] && length == 16) {
//                result = TRUE;
//            }else {
//                result = FALSE;
//            }
//        }
//        if (result)
//        {
//            NSInteger digitValue;
//            NSInteger checkSum = 0;
//            NSInteger index = 0;
//            NSInteger leftIndex;
//            //even length, odd index
//            if (0 == length%2) {
//                index = 0;
//                leftIndex = 1;
//            }
//            //odd length, even index
//            else {
//                index = 1;
//                leftIndex = 0;
//            }
//            while (index < length) {
//                digitValue = [[value substringWithRange:NSMakeRange(index, 1)] integerValue];
//                digitValue = digitValue*2;
//                if (digitValue >= 10)
//                {
//                    checkSum += digitValue/10 + digitValue%10;
//                }
//                else
//                {
//                    checkSum += digitValue;
//                }
//                digitValue = [[value substringWithRange:NSMakeRange(leftIndex, 1)] integerValue];
//                checkSum += digitValue;
//                index += 2;
//                leftIndex += 2;
//            }
//            result = (0 == checkSum%10) ? TRUE:FALSE;
//        }
//    }else {
//        result = NO;
//    }
//    return result;
//}

- (BOOL) checkCardNo:(NSString*) cardNo{
    cardNo = [cardNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
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
