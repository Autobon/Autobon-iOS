//
//  CLAddPersonViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLAddPersonViewController.h"
#import "GFNavigationView.h"


@interface CLAddPersonViewController ()

@end

@implementation CLAddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    
    [self setViewForAdd];
    
    self.view.backgroundColor = [UIColor cyanColor];
}


- (void)setViewForAdd{
    UISearchBar *searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-80, 40)];
//    searchbar.backgroundColor = [UIColor whiteColor];
    searchbar.barTintColor = [UIColor whiteColor];
//    searchbar.barStyle = UIBarStyleDefault;
    searchbar.layer.cornerRadius = 20;
    searchbar.layer.borderWidth = 1.0;
    searchbar.layer.borderColor = [[UIColor blackColor]CGColor];
    
    [self.view addSubview:searchbar];
    searchbar.clipsToBounds = YES;
    
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
// 更多按钮的响应方法
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
