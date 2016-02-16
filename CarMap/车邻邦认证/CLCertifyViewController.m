//
//  CLCertifyViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/16.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLCertifyViewController.h"
//#import "GFTextField.h"


@interface CLCertifyViewController ()

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
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
//    scrollView.backgroundColor = [UIColor cyanColor];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.25);
    [self.view addSubview:scrollView];
    
//头像
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    headImage.image = [UIImage imageNamed:@"userHeadImage"];
//    headImage.backgroundColor = [UIColor redColor];
    [scrollView addSubview:headImage];
    
//    GFTextField *textField = [[GFTextField alloc]initWithLeftStr:@"用户名"];
//    textField.frame = CGRectMake(80, 10, 200, 40);
////    textField.backgroundColor = [UIColor redColor];
//    [scrollView addSubview:textField];
    
    
    
    
}




// 添加导航
- (void)setNavigation{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [[UIColor alloc]initWithRed:235/255.0 green:96/255.0 blue:1/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    // title
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, self.view.frame.size.width-200, 40)];
    label.text = @"我要认证";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20 weight:3];
    [view addSubview:label];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, 20, 60, 40)];
//    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"moreList"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"moreListClick"] forState:UIControlStateHighlighted];
    [view addSubview:button];
    
// 返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
//    backButton.backgroundColor = [UIColor cyanColor];
    [backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backClick"] forState:UIControlStateHighlighted];
    [view addSubview:backButton];
    
}
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"更多");
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
