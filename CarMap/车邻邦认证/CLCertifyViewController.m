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
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "CLCertifyingViewController.h"
#import "UIButton+WebCache.h"
#import "CLAutobonViewController.h"



@interface CLCertifyViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *_chooseView;
    CLTouchScrollView *_scrollView;
    UIButton *_headButton;
    UIButton *_identityButton;
    BOOL _isHeadImage;
    BOOL _isTableView;
    BOOL _isBank;
    BOOL _haveHeadImage;
    BOOL _haveIdentityImage;
    BOOL _isIdNumber;
    BOOL _isBankNumber;
    GFTextField *_userNameTextField;
    GFTextField *_identityTextField;
    NSMutableArray *_skillArray;
    CLTitleView *_identityView;
    NSArray *_bankArray;
    UIButton *_bankButton;
    GFTextField *_bankNumberTextField;
    UITableView *_tableView;
    NSArray *_skillBtnArray;
}
@end






@implementation CLCertifyViewController

- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc]init];
    }
    return _submitButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _skillArray = [[NSMutableArray alloc]init];
    _bankArray = @[@"农业银行",@"招商银行",@"建设银行",@"广发银行",@"中信银行",@"光大银行",@"民生银行",@"普法银行",@"工商银行",@"中国银行",@"交通银行",@"邮政储蓄银行"];
    [self setNavigation];
    
    [self setViewForCertify];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 100, 120, 200)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_scrollView addSubview:_tableView];
    _tableView.hidden = YES;
    
    
    if (_isFail) {
        [GFHttpTool getCertificateSuccess:^(id responseObject) {
            _haveHeadImage = YES;
            _isIdNumber = YES;
            _haveIdentityImage = YES;
            _isBank = YES;
            _isBankNumber = YES;
            if ([responseObject[@"result"]intValue]==1) {
                NSDictionary *dataDic = responseObject[@"data"];
                // 1,2,3,4
                NSArray *array = [dataDic[@"skill"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@--",array);
                [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                    UIButton *button = _skillBtnArray[[obj intValue]-1];
                    [_skillArray addObject:@(button.tag+1)];
                    button.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }];
                
                _userNameTextField.centerTxt.text = dataDic[@"name"];
                _identityTextField.centerTxt.text = dataDic[@"idNo"];
                [_bankButton setTitle:dataDic[@"bank"] forState:UIControlStateNormal];
                [_bankButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                _bankNumberTextField.centerTxt.text = dataDic[@"bankCardNo"];
                
                [_headButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345/%@",dataDic[@"avatar"]]] forState:UIControlStateNormal];
                
                [_identityButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345/%@",dataDic[@"idPhoto"]]] forState:UIControlStateNormal];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (void)setViewForCertify{
    _scrollView = [[CLTouchScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
//    scrollView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:_scrollView];
    
//头像
    _headButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 80, 80)];
    [_headButton setBackgroundImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateNormal];
    _headButton.layer.cornerRadius = 40;
    _headButton.clipsToBounds = YES;
//    headImage.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_headButton];
    _headButton.tag = 1;
    [_headButton addTarget:self action:@selector(cameraHeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cameraHeadBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, 80, 20, 20)];
    [cameraHeadBtn setImage:[UIImage imageNamed:@"cameraHead"] forState:UIControlStateNormal];
    cameraHeadBtn.tag = 1;
    [cameraHeadBtn addTarget:self action:@selector(cameraHeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:cameraHeadBtn];
    
    _userNameTextField = [[GFTextField alloc]initWithPlaceholder:@"姓名" withFrame:CGRectMake(110, 20, self.view.frame.size.width - 140, 50)];
    [_scrollView addSubview:_userNameTextField];
    
    _identityTextField = [[GFTextField alloc]initWithPlaceholder:@"身份证号" withFrame:CGRectMake(110, 80, self.view.frame.size.width - 140, 50)];
    _identityTextField.centerTxt.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _identityTextField.centerTxt.delegate = self;
    _identityTextField.centerTxt.tag = 2;
    [_scrollView addSubview:_identityTextField];
    
// 技能项目
    CLTitleView *skillView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 145, self.view.frame.size.width, 45) Title:@"技能项目"];
    [_scrollView addSubview:skillView];
    
// 隔热层
    UIButton *insulatingButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 200, self.view.frame.size.width/4-10, 40)];
    [insulatingButton setTitle:@"隔热膜" forState:UIControlStateNormal];
    insulatingButton.titleLabel.font = [UIFont systemFontOfSize:16];
    insulatingButton.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    insulatingButton.layer.cornerRadius = 15;
    [insulatingButton setTitleColor:[[UIColor alloc]initWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
    insulatingButton.tag = 0;
    [insulatingButton addTarget:self action:@selector(skillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:insulatingButton];
    
// 隐形车衣
    UIButton *stealthButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4+6, 200,self.view.frame.size.width/4-10, 40)];
    [stealthButton setTitle:@"隐形车衣" forState:UIControlStateNormal];
    stealthButton.titleLabel.font = [UIFont systemFontOfSize:16];
    stealthButton.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    stealthButton.layer.cornerRadius = 15;
    [stealthButton setTitleColor:[[UIColor alloc]initWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
    stealthButton.tag = 1;
    [stealthButton addTarget:self action:@selector(skillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:stealthButton];
    
    
    
    UIButton *colorButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+4, 200,self.view.frame.size.width/4-10, 40)];
    [colorButton setTitle:@"车身改色" forState:UIControlStateNormal];
    colorButton.titleLabel.font = [UIFont systemFontOfSize:16];
    colorButton.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    colorButton.layer.cornerRadius = 15;
    [colorButton setTitleColor:[[UIColor alloc]initWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
    colorButton.tag = 2;
    [colorButton addTarget:self action:@selector(skillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:colorButton];
    
    UIButton *cleanButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4+2, 200,self.view.frame.size.width/4-10, 40)];
    [cleanButton setTitle:@"美容清洁" forState:UIControlStateNormal];
    cleanButton.titleLabel.font = [UIFont systemFontOfSize:16];
    cleanButton.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    cleanButton.layer.cornerRadius = 15;
    [cleanButton setTitleColor:[[UIColor alloc]initWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
    cleanButton.tag = 3;
    [cleanButton addTarget:self action:@selector(skillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:cleanButton];
    
    _skillBtnArray = @[insulatingButton,stealthButton,colorButton,cleanButton];
// 证件照
    _identityView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 45) Title:@"手持身份证正面照"];
    [_scrollView addSubview:_identityView];
    
    _identityButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, 310, self.view.frame.size.width*3/5, self.view.frame.size.width*27/70)];
    [_identityButton setBackgroundImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
    [_identityButton addTarget:self action:@selector(cameraHeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_identityButton];
    
    UIButton *cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*4/5-15, 310+self.view.frame.size.width*27/70-25, 30, 30)];
    [cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(cameraHeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:cameraBtn];
    
// 银行卡信息
    
    CLTitleView *bankView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 310+self.view.frame.size.width*27/70 + 10, self.view.frame.size.width, 45) Title:@"银行卡信息"];
    [_scrollView addSubview:bankView];
    
    _bankButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2-15, 40)];
    _bankButton.center = CGPointMake(self.view.center.x, bankView.frame.origin.y+45+10+20);
    [_bankButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [_bankButton setTitle:@"农业银行" forState:UIControlStateNormal];
    [_bankButton setTitleColor:[UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:1] forState:UIControlStateNormal];
//    bankButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _bankButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _bankButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_bankButton addTarget:self action:@selector(bankBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_bankButton];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    UIButton *whereButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+5, bankView.frame.origin.y+45+10, self.view.frame.size.width/2-15, 40)];
    
//    [whereButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
//    [whereButton setTitle:@"开户地点" forState:UIControlStateNormal];
//    [whereButton setTitleColor:[UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:1] forState:UIControlStateNormal];
////    whereButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    whereButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    whereButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    [whereButton addTarget:self action:@selector(whereBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:whereButton];
    
// 银行卡号
    _bankNumberTextField = [[GFTextField alloc]initWithPlaceholder:@"银行卡号" withFrame:CGRectMake(40, bankView.frame.origin.y+45+15+60, self.view.frame.size.width-80, 40)];
    _bankNumberTextField.centerTxt.keyboardType = UIKeyboardTypeNumberPad;
    _bankNumberTextField.centerTxt.delegate = self;
    _bankNumberTextField.centerTxt.tag = 5;
    [_scrollView addSubview:_bankNumberTextField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _bankNumberTextField.frame.origin.y+40+40, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];
    
    
    
    
    
    
    
    
    
    
    
    
// 提交按钮
    _submitButton.frame = CGRectMake(30, lineView.frame.origin.y+2+10, self.view.frame.size.width-60, 40);
//    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_submitButton];
    
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

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

#pragma mark - 提交按钮事件
- (void)submitBtnClick{
// 判断头像
    if (!_haveHeadImage) {
        [self addAlertView:@"请选择头像"];
    }else{
    // 判断姓名
        if (_userNameTextField.centerTxt.text.length == 0) {
           [self addAlertView:@"请输入姓名"];
        }else{
        // 判断身份证号
            if (!_isIdNumber) {
                [self addAlertView:@"请输入合法身份证号"];
            }else{
            // 判断至少一个技能
                if (_skillArray.count == 0) {
                    [self addAlertView:@"请至少选择一个技能"];
                }else{
                // 证件照
                    if (!_haveIdentityImage) {
                        [self addAlertView:@"请选择证件照"];
                    }else{
                    // 银行类型
                        if (!_isBank) {
                            [self addAlertView:@"请选择银行卡类型"];
                        }else{
                        // 银行卡号
                            if (!_isBankNumber) {
                                [self addAlertView:@"请输入合法银行卡号"];
                            }else{
                               
//                                NSLog(@"---%@----id--%@--",headData,idData);
                                NSString *cardNo = [_bankNumberTextField.centerTxt.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                                NSString *skillString = nil;
                                
                                for (int i = 0; i < _skillArray.count; i++ ) {
                                    if (i == 0) {
                                        skillString = [NSString stringWithFormat:@"%@",_skillArray[i]];
                                    }else{
                                       skillString = [NSString stringWithFormat:@"%@,%@",skillString,_skillArray[i]];
                                    }
                                } 
                                NSDictionary *dic= @{@"name":_userNameTextField.centerTxt.text,@"idNo":_identityTextField.centerTxt.text,@"skills":skillString,@"bank":_bankButton.titleLabel.text,@"bankCardNo":cardNo};
                                NSLog(@"-----dic---%@--",dic);
                                [GFHttpTool certifyPostParameters:dic success:^(NSDictionary *responseObject) {
                                    NSLog(@"----responseObject-%@--%@",responseObject,responseObject[@"message"]);
                                    if ([responseObject[@"result"] intValue] == 1) {
                                        
                                       [self addAlertView:@"提交成功"];
                                        [self performSelector:@selector(success) withObject:nil afterDelay:1.5];
                                        
                                    }else{
                                       [self addAlertView:responseObject[@"message"]];
                                    }
                                    
                                } failure:^(NSError *error) {
                                    NSLog(@"应该不会---%@--",error);
                                }];
                            }
                        }
                     }
                }
            }
        }
    }
}

#pragma mark - 提交成功页面跳转
- (void)success{
//    CLCertifyingViewController *certifying = [[CLCertifyingViewController alloc]init];
//    [self.navigationController pushViewController:certifying animated:YES];
    
    if ([_submitButton.titleLabel.text isEqualToString:@"提交"]) {
        CLAutobonViewController *autobon = (CLAutobonViewController *)self.navigationController.viewControllers[0];
        autobon.certifyButton.userInteractionEnabled = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
    _tableView.hidden = NO;
    _tableView.allowsSelection = YES;
    _tableView.frame = CGRectMake(0, 0, button.frame.size.width , 100);
    _tableView.center = CGPointMake(self.view.center.x, button.frame.origin.y + 40+50);
}
#pragma mark - tableView协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dianjifangfa");
    [_bankButton setTitle:_bankArray[indexPath.row] forState:UIControlStateNormal];
    [_bankButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _isTableView = NO;
    _isBank = YES;
    [tableView removeFromSuperview];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _bankArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        cell.textLabel.textColor = [UIColor whiteColor];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
        [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        cell.textLabel.textColor = [UIColor blackColor];
//        [button setTitle:@"农业银行" forState:UIControlStateNormal];
    }
    cell.textLabel.text = _bankArray[indexPath.row];
    return cell;
}
- (void)btn:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)[button superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSLog(@"btntbn--cell--%@",@(indexPath.row));
    [_bankButton setTitle:_bankArray[indexPath.row] forState:UIControlStateNormal];
    [_bankButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _isBank = YES;
    _tableView.hidden = YES;
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
        if (textField.text.length>0) {
            if ([self checkCardNo:textField.text]) {
                _isBankNumber = YES;
            }else{
                [self addAlertView:@"银行卡号码格式错误"];
                _isBankNumber = NO;
            }
        }else{
            [self addAlertView:@"银行卡号码格式错误"];
            _isBankNumber = NO;
        }
        
    }else{
        if ([self validateIdentityCard:textField.text]) {
            _isIdNumber = YES;
        }else{
            [self addAlertView:@"身份证号码格式错误"];
            _isIdNumber = NO;
        }
    }
    
    
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (textField.tag == 5) {
//        NSLog(@"---range--%@----%@---string--%@--",@(range.location),@(range.length),string);
//        if (range.length == 0) {
//            if (range.location%5 == 4) {
//                textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
//            }
//        }
//    }
//    
//    return YES;
//}


#pragma mark - 技能按钮
- (void)skillBtnClick:(UIButton *)button{
    [self.view endEditing:YES];
    if ([_skillArray containsObject:@(button.tag+1)]) {
        [_skillArray removeObject:@(button.tag+1)];
        button.backgroundColor = [[UIColor alloc]initWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [button setTitleColor:[[UIColor alloc]initWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
    }else{
        [_skillArray addObject:@(button.tag+1)];
        
        button.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
//        imagePickerController.allowsEditing = YES;
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
        
        [_headButton setImage:image forState:UIControlStateNormal];
        NSData *headData = UIImageJPEGRepresentation(image, 0.3);
        [GFHttpTool headImage:headData success:^(NSDictionary *responseObject) {
            NSLog(@"-----responseObject---%@--",responseObject);
            if ([responseObject[@"result"]intValue] == 1) {
                _haveHeadImage = YES;
                [self addAlertView:@"头像上传成功"];
            }else{
                [self addAlertView:@"头像上传失败"];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        [_identityButton setImage:image forState:UIControlStateNormal];
//        _haveIdentityImage = YES;
        _identityButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSData *idPhotoImage = UIImageJPEGRepresentation(image, 0.3);
        [GFHttpTool idPhotoImage:idPhotoImage success:^(NSDictionary *responseObject) {
            NSLog(@"----%@---",responseObject);
            if ([responseObject[@"result"]intValue] == 1) {
                _haveIdentityImage = YES;
                [self addAlertView:@"证件照上传成功"];
            }else{
                [self addAlertView:@"证件照上传失败"];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 添加导航
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"我要认证" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    
}
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
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
