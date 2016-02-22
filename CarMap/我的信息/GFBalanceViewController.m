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


@interface GFBalanceViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UILabel *upMoneyLab;
@property (nonatomic, strong) UILabel *bankLab;
@property (nonatomic, strong) UILabel *cardLab;


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
    self.upMoneyLab.text = @"100.32元";
    self.upMoneyLab.font = [UIFont systemFontOfSize:28 / 320.0 * kWidth];
    [self.view addSubview:self.upMoneyLab];
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upMoneyLab.frame) - 1, kWidth, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.view addSubview:lineView1];
    
    // 银行卡栏
    CGFloat bankViewW = upMoneyLabW;
    CGFloat bankViewH = kHeight * 0.078;
    CGFloat bankViewX = 0;
    CGFloat bankViewY = CGRectGetMaxY(self.upMoneyLab.frame) + kHeight * 0.018;
    UIView *bankView = [[UIView alloc] initWithFrame:CGRectMake(bankViewX, bankViewY, bankViewW, bankViewH)];
    bankView.backgroundColor = [UIColor whiteColor];
//    self.v
    
    
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
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
