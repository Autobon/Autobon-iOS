//
//  GFBalanceViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFBalanceViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFHttpTool.h"
#import "GFBankCardViewController.h"
#import "GFIndentModel.h"
#import "GFTipView.h"

@interface GFBalanceViewController () <GFBankCardViewControllerDelegate,UITextFieldDelegate> {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jianjv1;
    
    GFTextField *_cashTextField;  //提现金额
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UILabel *upMoneyLab;
@property (nonatomic, strong) UILabel *bankLab;
@property (nonatomic, strong) UILabel *cardLab;

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) GFBankCardViewController *bankCardVC;


@end

@implementation GFBalanceViewController 

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
    
    jianjv1  = kWidth * 0.088;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"余额" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
    
}

- (void)_setView {
    
    
    
    // 金额显示Lab
    CGFloat upMoneyLabW = kWidth;
    CGFloat upMoneyLabH = kHeight * 0.162;
    CGFloat upMoneyLabX = 0;
    CGFloat upMoneyLabY = 64;
    self.upMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(upMoneyLabX, upMoneyLabY, upMoneyLabW, upMoneyLabH)];
    self.upMoneyLab.backgroundColor = [UIColor whiteColor];
    self.upMoneyLab.textAlignment = NSTextAlignmentCenter;
    if (self.balance == NULL) {
        self.upMoneyLab.text = @"0元";
    }else{
        self.upMoneyLab.text = [NSString stringWithFormat:@"%@元", self.balance];
    }
    
    self.upMoneyLab.font = [UIFont systemFontOfSize:28 / 320.0 * kWidth];
    [self.view addSubview:self.upMoneyLab];
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upMoneyLab.frame) - 1, kWidth, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.view addSubview:lineView1];
    
    
    // 银行卡栏
    CGFloat bankViewW = upMoneyLabW;
    CGFloat bankViewH = kHeight * 0.09 + 6;
    CGFloat bankViewX = 0;
    CGFloat bankViewY = CGRectGetMaxY(self.upMoneyLab.frame) + kHeight * 0.018;
    UIView *bankView = [[UIView alloc] initWithFrame:CGRectMake(bankViewX, bankViewY, bankViewW, bankViewH)];
    bankView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bankView];
    // 银行Lab
    CGFloat bankLabW = bankViewW - jianjv1;
    CGFloat bankLabH = (bankViewH - 6) / 2.0;
    CGFloat bankLabX = jianjv1;
    CGFloat bankLabY = 3;
    self.bankLab = [[UILabel alloc] initWithFrame:CGRectMake(bankLabX, bankLabY, bankLabW, bankLabH)];
    self.bankLab.text = self.bank;
    self.bankLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [bankView addSubview:self.bankLab];
    // 银行卡号Lab
    CGFloat cardLabW = bankLabW;
    CGFloat cardLabH = bankLabH;
    CGFloat cardLabX = bankLabX;
    CGFloat cardLabY = CGRectGetMaxY(self.bankLab.frame);
    self.cardLab = [[UILabel alloc] initWithFrame:CGRectMake(cardLabX, cardLabY, cardLabW, cardLabH)];
    self.cardLab.text = self.bankCardNo;
    self.cardLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [bankView addSubview:self.cardLab];
    // 边线
    UIView *upLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    upLineView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [bankView addSubview:upLineView];
    UIView *downLineView = [[UIView alloc]  initWithFrame:CGRectMake(0, bankViewH, kWidth, 1)];
    downLineView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [bankView addSubview:downLineView];
    // 银行卡栏按钮
    CGFloat bankButW = bankViewW;
    CGFloat bankButH = bankViewH;
    CGFloat bankButX = 0;
    CGFloat bankButY = 0;
    UIButton *bankBut = [UIButton buttonWithType:UIButtonTypeCustom];
    bankBut.frame = CGRectMake(bankButX, bankButY, bankButW, bankButH);
    [bankView addSubview:bankBut];
    [bankBut addTarget:self action:@selector(bankButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 结算时间Lab
    CGFloat timeLabW = kWidth - jianjv1;
    CGFloat timeLabH = bankViewH;
    CGFloat timeLabX = jianjv1;
    CGFloat timeLabY = CGRectGetMaxY(bankView.frame);
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
    timeLab.text = @"每月底为车邻邦平台结算时间";
    timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    timeLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [self.view addSubview:timeLab];
    
    
    
    
    
    // 提现金额
    _cashTextField = [[GFTextField alloc]initWithPlaceholder:@"请输入提现金额" withFrame:CGRectMake(100, CGRectGetMaxY(timeLab.frame) + 30, self.view.frame.size.width - 120, 40)];
    _cashTextField.centerTxt.keyboardType = UIKeyboardTypeDecimalPad;
    _cashTextField.centerTxt.delegate = self;
//    _cashTextField.centerTxt.tag = 5;
    [self.view addSubview:_cashTextField];
    
    
    UILabel *cashLabel = [[UILabel alloc]init];
    cashLabel.text = @"提现金额:";
    cashLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:cashLabel];
    cashLabel.frame = CGRectMake(20, CGRectGetMaxY(timeLab.frame) + 23, 80, 40);
    
    
    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _cashTextField.frame.origin.y+40+40, self.view.frame.size.width, 1)];
//    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
//    [self.view addSubview:lineView];
    
    
    
    
    
    //提现按钮
    UIButton *cashButton = [[UIButton alloc]init];
    [cashButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [cashButton setBackgroundImage:[UIImage imageNamed:@"buttonClick.png"] forState:UIControlStateHighlighted];
    [cashButton setTitle:@"提现" forState:UIControlStateNormal];
    [cashButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cashButton.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:cashButton];
    [cashButton addTarget:self action:@selector(cashBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    cashButton.frame = CGRectMake(20, CGRectGetMaxY(_cashTextField.frame) + 60, self.view.frame.size.width - 40, 40);
    
    if([_balance floatValue] == 0){
        _cashTextField.userInteractionEnabled = false;
        cashButton.userInteractionEnabled = false;
        cashButton.alpha = 0.5;
    }
    
}

//MARK:体现按钮相应方法
- (void)cashBtnClick{
    if (_cashTextField.centerTxt.text.length == 0) {
        [GFTipView tipViewWithNormalHeightWithMessage:@"请输入提现金额" withShowTimw:1.5];
        return;
    }else if ([_cashTextField.centerTxt.text floatValue] == 0) {
        [GFTipView tipViewWithNormalHeightWithMessage:@"提现金额不能为0" withShowTimw:1.5];
        return;
    }else if ([_cashTextField.centerTxt.text floatValue] > [_balance floatValue]) {
        [GFTipView tipViewWithNormalHeightWithMessage:@"余额不足" withShowTimw:1.5];
        return;
    }
    
    NSDate *date = [NSDate date];
    long time = (long)[date timeIntervalSince1970] * 1000;
    ICLog(@"---time----%ld--",time);
    NSDictionary *dataDictionary = @{@"applyMoney":_cashTextField.centerTxt.text,@"techId":_idString,@"applyDate":@(time)};
    ICLog(@"dataDictionary--%@--",dataDictionary);
    [GFHttpTool cashApplyPostWithParameters:dataDictionary success:^(id responseObject) {
        ICLog(@"请求成功---%@--",responseObject);
        if ([[NSString stringWithFormat:@"%@",responseObject[@"status"]]isEqualToString:@"1"]) {
            [GFTipView tipViewWithNormalHeightWithMessage:@"操作成功" withShowTimw:1.5];
            _cashTextField.centerTxt.text = nil;
        }else{
            [GFTipView tipViewWithNormalHeightWithMessage:responseObject[@"message"] withShowTimw:1.5];
        }
    } failure:^(NSError *error) {
        ICLog(@"请求失败----%@--",error);
        
    }];
    
    
}


- (void)bankButClick {

//    NSLog(@"修改银行卡信息");
    
    self.baseView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.baseView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 blue:0 alpha:0.65];
    [self.view addSubview:self.baseView];
    
    [self _setTapGest];
    
    UIButton *changBut = [UIButton buttonWithType:UIButtonTypeCustom];
    changBut.frame = CGRectMake(kWidth * 0.125, kHeight * 0.4, kWidth - (kWidth * 0.125 * 2), kHeight * 0.09);
    changBut.backgroundColor = [UIColor whiteColor];
    [changBut setTitle:@"修改银行卡信息" forState:UIControlStateNormal];
    [changBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changBut.titleLabel.font = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
    changBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    changBut.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    changBut.layer.cornerRadius = 7.5;
    [self.baseView addSubview:changBut];
    [changBut addTarget:self action:@selector(changeButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length == 1) {
        return YES;
    }
    
    if ([string isEqualToString:@"."]) {
        return [Commom validateInt:textField.text];
    }
    NSString *textString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    return [Commom validateIntAndFloat:textString];
    
}


- (void)_setTapGest {
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] init];
    
    [self.baseView addGestureRecognizer:tapGest];
    
    [tapGest addTarget:self action:@selector(tapGestDone:)];
    
}
- (void)tapGestDone:(UITapGestureRecognizer *)tapGest {
    
    [self.baseView removeFromSuperview];
    

}

- (void)changeButClick {

    [self.baseView removeFromSuperview];
    
    self.bankCardVC = [[GFBankCardViewController alloc] init];
    self.bankCardVC.delegate = self;
    
    self.bankCardVC.bankStr = self.bankLab.text;
    self.bankCardVC.bankCard = self.cardLab.text;
    
    self.bankCardVC.name = self.name;
    
    [self.navigationController pushViewController:self.bankCardVC animated:YES];

}

- (void)changeBankCardViewController:(GFBankCardViewController *)bankCardVC {

    self.bankLab.text = bankCardVC.endBank;
    self.cardLab.text = bankCardVC.bankCard;
    
    
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
