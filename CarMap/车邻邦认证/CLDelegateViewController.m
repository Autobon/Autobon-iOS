//
//  DelegateViewController.m
//  obdInterface
//
//  Created by 李孟龙 on 16/1/20.
//  Copyright © 2016年 lubo. All rights reserved.
//

#import "CLDelegateViewController.h"
#import "GFNavigationView.h"



@interface CLDelegateViewController ()

@end

@implementation CLDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 返回按钮
//    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeSystem];
//    backBut.frame = CGRectMake(0, 0, 44, 44);
//    backBut.imageEdgeInsets = UIEdgeInsetsMake(0, -34, 0, 0);
//    [backBut setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [backBut addTarget:self action:@selector(backButClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBut = [[UIBarButtonItem alloc] initWithCustomView:backBut];
//    self.navigationItem.leftBarButtonItem = leftBut;
    
    
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height- 44)];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"servicedelegate" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(20, 20, 40, 40);
    [self.view addSubview:webView];
    
    [self setNavigation];
}
// 添加导航
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦协议" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    
}
-(void)backBtnClick{
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
