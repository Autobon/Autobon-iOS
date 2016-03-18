//
//  GFBankCardViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/22.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFBankCardViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTextField.h"
#import "GFTipView.h"
#import "GFSignInViewController.h"
#import "GFMyMessageViewController.h"
#import "GFBalanceViewController.h"

@interface GFBankCardViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jianjv1;
    CGFloat jiange1;
    
    
    NSInteger index;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UIButton *bankBut;
@property (nonatomic, strong) UIView *jvtiView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, strong) NSArray *bankArr;



@end

@implementation GFBankCardViewController

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
    
    jianjv1 = kHeight * 0.021;
    jiange1 = kWidth * 0.056;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"银行卡" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    //银行数组
    self.bankArr = @[@"农业银行",@"招商银行",@"建设银行",@"广发银行",@"中信银行",@"光大银行",@"民生银行",@"普发银行",@"工商银行",@"中国银行",@"交通银行",@"邮政储蓄银行"];
    
    
    // 银行卡信息
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = kHeight * 0.0521;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = jianjv1 + 64;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    // 竖条
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5 / 320.0 * kWidth, baseViewH)];
    lineView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView addSubview:lineView];
    // 银行卡信息Lab
    UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(jiange1, 0, 200, baseViewH)];
    msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    msgLab.text = @"银行卡信息";
    [baseView addSubview:msgLab];
    // 边线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
    line1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:line1];
    
    
    // 姓名
    CGFloat nameViewW = kWidth;
    CGFloat nameViewH = kHeight * 0.083;
    CGFloat nameViewX = 0;
    CGFloat nameViewY = CGRectGetMaxY(baseView.frame);
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(nameViewX, nameViewY, nameViewW, nameViewH)];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    // 姓名Lab
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(jiange1, 0, 200, nameViewH)];
    self.nameLab.text = self.name;
    self.nameLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    self.nameLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    [nameView addSubview:self.nameLab];
    // 边线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, nameViewH - 1, kWidth, 1)];
    line2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [nameView addSubview:line2];
    
    
    // 具体信息与更改
    CGFloat jvtiViewW = kWidth;
    CGFloat jvtiViewH = kHeight * 0.248;
    CGFloat jvtiViewX = 0;
    CGFloat jvtiViewY = CGRectGetMaxY(nameView.frame);
    self.jvtiView = [[UIView alloc] initWithFrame:CGRectMake(jvtiViewX, jvtiViewY, jvtiViewW, jvtiViewH)];
    [self.view addSubview:self.jvtiView];
    // 银行按钮
    CGFloat bankButW = (kWidth - 3 * jiange1 - 10) / 2.0;
    CGFloat bankButH = kHeight * 0.052;
    CGFloat bankButX = jiange1;
    CGFloat bankButY = jiange1;
    self.bankBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bankBut.frame = CGRectMake(bankButX, bankButY, bankButW, bankButH);
    [self.bankBut setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
    self.bankBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.bankBut.contentEdgeInsets = UIEdgeInsetsMake(0, 5 / 320.0 * kWidth, 0, 0);
    NSLog(@"\n\n\n%@\n\n\n", self.bankStr);
    [self.bankBut setTitle:self.bankStr forState:UIControlStateNormal];
    [self.bankBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.bankBut.titleLabel.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [self.jvtiView addSubview:self.bankBut];
    [self.bankBut addTarget:self action:@selector(bankButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    // 开户地点
//    CGFloat placeButW = (kWidth - 3 * jiange1 - 10) / 2.0;
//    CGFloat placeButH = kHeight * 0.052;
//    CGFloat placeButX = CGRectGetMaxX(bankBut.frame) + 10;
//    CGFloat placeButY = jiange1;
//    UIButton *placeBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    placeBut.frame = CGRectMake(placeButX, placeButY, placeButW, placeButH);
//    [placeBut setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
//    placeBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    placeBut.contentEdgeInsets = UIEdgeInsetsMake(0, 5 / 320.0 * kWidth, 0, 0);
//    [placeBut setTitle:@"开户地点" forState:UIControlStateNormal];
//    [placeBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
//    placeBut.titleLabel.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//    [jvtiView addSubview:placeBut];
//    [placeBut addTarget:self action:@selector(placeButClick) forControlEvents:UIControlEventTouchDragInside];
    
    // 银行卡号
    CGFloat cardTxtW = kWidth - 0.185 * kWidth * 2;
    CGFloat cardTxtH = kHeight * 0.0625;
    CGFloat cardTxtX = kWidth * 0.185;
    CGFloat cardTxtY = CGRectGetMaxY(self.bankBut.frame) + jiange1 + 10;
    self.cardTxt = [[GFTextField alloc] initWithPlaceholder:self.bankCard withFrame:CGRectMake(cardTxtX, cardTxtY, cardTxtW, cardTxtH)];
    [self.jvtiView addSubview:self.cardTxt];
    self.cardTxt.centerTxt.tag = 5;
    self.cardTxt.centerTxt.delegate = self;
    self.cardTxt.centerTxt.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    // 边线
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, jvtiViewH - 1, kWidth, 1)];
    line3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.jvtiView addSubview:line3];
    
    
    // 银行tableView
    CGFloat tableViewW = self.bankBut.frame.size.width;
    CGFloat tableViewH = 100;
    CGFloat tableViewX = self.bankBut.frame.origin.x;
    CGFloat tableViewY = CGRectGetMaxY(self.bankBut.frame);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.jvtiView addSubview:self.tableView];
    self.tableView.hidden = YES;
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1] CGColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 提交按钮
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBut.frame = CGRectMake(kWidth * 0.116 - 4, CGRectGetMaxY(self.jvtiView.frame) + 25, kWidth - (kWidth * 0.116 - 4) * 2.0, kHeight * 0.073);
    [submitBut setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [submitBut setBackgroundImage:[UIImage imageNamed:@"buttonClick.png"] forState:UIControlStateHighlighted];
    [submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [submitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBut.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 * kWidth];
    [self.view addSubview:submitBut];
    [submitBut addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)submitClick {
    
    
    // 提交修改银行卡信息按钮
    NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/changeBankCard";
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    parDic[@"name"] = self.nameLab.text;
    parDic[@"bank"] = self.bankArr[index];
    parDic[@"bankCardNo"] = self.cardTxt.centerTxt.text;
//    parDic[@"name"] = @"陈光法";
//    parDic[@"bank"] = @"建设";
//    parDic[@"bankCardNo"] = @"621700287000250683";

    
    
    
    
    [GFHttpTool bankCardPost:url parameters:parDic success:^(id responseObject) {

    BOOL cardFlage = [self checkCardNo:self.cardTxt.centerTxt.text];
    if(cardFlage == NO) {
        
        GFTipView *tipView = [[GFTipView alloc] initWithNormalHeightWithMessage:@"请输入正确地银行卡号" withViewController:self withShowTimw:1.5];
        [tipView tipViewShow];
    }else {
    
        // 提交修改银行卡信息按钮
        NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/changeBankCard";
        NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
        parDic[@"bank"] = self.bankArr[index];
        parDic[@"bankCardNo"] = self.cardTxt.centerTxt.text;
        parDic[@"name"] = @"Www";
        
        
        [GFHttpTool bankCardPost:url parameters:parDic success:^(id responseObject) {
            
            NSLog(@"提交成功++++++++++++++");
            
            NSInteger flage = [responseObject[@"result"] integerValue];
            
            if(flage == 1) {
                
                GFTipView *tipView = [[GFTipView alloc] initWithNormalHeightWithMessage:@"修改成功" withViewController:self withShowTimw:1.5];
                [tipView tipViewShow];
                
//                [NSThread sleepForTimeInterval:1.5];
                [self performSelector:@selector(VCpush) withObject:nil afterDelay:1.5];
                
                
                
                NSLog(@"修改成功===========\n%@", responseObject);
                
            }else {
                
                NSLog(@"修改失败===========\n%@", responseObject);
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"提交失败++++++++++++++%@", error);
            
        }];
    
    }
    }failure:^(NSError *error) {
        
    }];
    
    
    
    
    
    self.bankStr = self.bankArr[index];
    self.bankCard = self.cardTxt.centerTxt.text;
    

    
    
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


//- (void)placeButClick {
//
//    NSLog(@"请选择开户地点");
//}
- (void)VCpush {

//    NSLog(@"%@", self.navigationController.viewControllers);
    
    GFMyMessageViewController *myMsgVC = (GFMyMessageViewController *)self.navigationController.viewControllers[(self.navigationController.viewControllers.count - 3)];
//    GFBalanceViewController *balanceVC = (GFBalanceViewController *)self.navigationController.viewControllers[(self.navigationController.viewControllers.count - 2)];
    myMsgVC.bank = self.bankName;
    myMsgVC.bankCardNo = self.cardTxt.centerTxt.text;
    
//    balanceVC.bank = self.bankName;
//    balanceVC.bankCardNo = self.cardTxt.centerTxt.text;
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate changeBankCardViewController:self];

//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:[[GFSignInViewController alloc] init]];
//    navVC.navigationBarHidden = YES;
//    window.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
//    window.rootViewController = navVC;
//    [window makeKeyAndVisible];
}


- (void)bankButClick {

    NSLog(@"请选择开户银行");
    self.tableView.delegate = self;
    self.tableView.hidden = !self.tableView.hidden;
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.bankArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.bankArr[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    index = indexPath.row;
    
    self.bankName = self.bankArr[index];
    
    [self.bankBut setTitle:self.bankName forState:UIControlStateNormal];
    
    self.tableView.hidden = YES;
    
    

}

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

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
    self.tableView.hidden = YES;
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
