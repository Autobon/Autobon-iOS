//
//  GFMyMessageViewController.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/16.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFMyMessageViewController.h"
#import "GFNavigationView.h"

@interface GFMyMessageViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    
}

@property (nonatomic, strong) GFNavigationView *navView;


@end

@implementation GFMyMessageViewController


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
    
    jiange1 = kHeight * 0.018;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"返回.png" withLeftImgHightName:@"点击返回.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的信息" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}


- (void)_setView {
    
    // 个人基本信息
    CGFloat msgViewW = kWidth;
    CGFloat msgViewH = kHeight * 0.162;
    CGFloat msgViewX = 0;
    CGFloat msgViewY = 64;
    UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(msgViewX, msgViewY, msgViewW, msgViewH)];
    msgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:msgView];
    

    
    // 钱包
    CGFloat moneyViewW = msgViewW;
    CGFloat moneyViewH = kHeight * (0.078 + 0.104);
    CGFloat moneyViewX = msgViewX;
    CGFloat moneyViewY = CGRectGetMaxY(msgView.frame) + jiange1;
    UIView *moneyView = [[UIView alloc] initWithFrame:CGRectMake(moneyViewX, moneyViewY, moneyViewW, moneyViewH)];
    moneyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:moneyView];

    
    // 我的订单
    CGFloat indentViewW = msgViewW;
    CGFloat indentViewH = kHeight * 0.078;
    CGFloat indentViewX = msgViewX;
    CGFloat indentViewY = CGRectGetMaxY(moneyView.frame) + jiange1;
    UIView *indentView = [[UIView alloc] initWithFrame:CGRectMake(indentViewX, indentViewY, indentViewW, indentViewH)];

    
    // 修改密码

    
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
