//
//  CertifyingViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLCertifyingViewController.h"
#import "GFNavigationView.h"


@interface CLCertifyingViewController ()

@end

@implementation CLCertifyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    
    [self setViewForCertify];
    
    
    
    
}



- (void)setViewForCertify{
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 79, 100, 40)];
    stateLabel.text = @"审核状态：";
    stateLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    stateLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:stateLabel];
    
    UILabel *failLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 79, 100, 40)];
    failLabel.text = @"正在审核";
    failLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    failLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:failLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 130, self.view.frame.size.width-20, 1)];
    view.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    
    
    UILabel *certifyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    certifyLabel.center = view.center;
    certifyLabel.text = @"认证信息";
    certifyLabel.textAlignment = NSTextAlignmentCenter;
    certifyLabel.backgroundColor = [UIColor whiteColor];
    certifyLabel.font = [UIFont systemFontOfSize:16];
    certifyLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:certifyLabel];
    
    //头像
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 160, 80, 80)];
    headImage.image = [UIImage imageNamed:@"userHeadImage"];
    headImage.layer.cornerRadius = 40;
    headImage.clipsToBounds = YES;
    [self.view addSubview:headImage];
    
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 160, 100, 40)];
    userNameLabel.text = @"林峰";
    userNameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:userNameLabel];
    
    UILabel *identityLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 200, self.view.frame.size.width - 140, 40)];
    identityLabel.text = @"42000000000000231235";
    identityLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:identityLabel];
    
    
    
    
    
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, 260, self.view.frame.size.width-20, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:lineView2];
    
    // 技能项目
    UILabel *skillLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 260, self.view.frame.size.width-30, 40)];
    skillLabel.text = @"技能项目：隐身车衣，车身改色";
    skillLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:skillLabel];
    
    UILabel *bankNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 300, self.view.frame.size.width-115, 40)];
    bankNumberLabel.text = @"银行卡号：1234 1233 1254 1234";
    bankNumberLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:bankNumberLabel];
    
    UILabel *bankLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 300, 100, 40)];
    bankLabel.text = @"农业银行";
    bankLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:bankLabel];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 310, 1, 20)];
    line.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:line];
    
    
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10, 350, self.view.frame.size.width-20, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:lineView3];
    
    
    UILabel *idImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
    idImageLabel.center = lineView3.center;
    idImageLabel.text = @"手持身份证正面照";
    idImageLabel.textAlignment = NSTextAlignmentCenter;
    idImageLabel.backgroundColor = [UIColor whiteColor];
    idImageLabel.font = [UIFont systemFontOfSize:16];
    idImageLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:idImageLabel];
    
    
    // 证件照
    
    UIImageView *identityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 370, self.view.frame.size.width-120, 150)];
    identityImageView.image = [UIImage imageNamed:@"userImage"];
    [self.view addSubview:identityImageView];
    
    
    
    
}


// 添加导航
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"认证进度" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    
}

-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
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
