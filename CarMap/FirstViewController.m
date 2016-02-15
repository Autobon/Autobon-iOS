//
//  FirstViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/1/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "GFMapViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor alloc]initWithWhite:0.2 alpha:0.5];
    
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 120, 40)];
//    button.backgroundColor = [UIColor cyanColor];
//    [button addTarget:[UIApplication sharedApplication].delegate action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-100, self.view.frame.size.height-100)];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view];
//    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, self.view.frame.size.width-200, 40)];
//    titleLabel.text = _labelTitle;
//    [view addSubview:titleLabel];
    
    GFMapViewController *map = [[GFMapViewController alloc]init];
    map.first = self;
    [self presentViewController:map animated:YES completion:nil];
}
- (void)firstBackClick{
    NSLog(@"返回出栈");
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)btnClick:(UIButton *)button{
    NSLog(@"其实这个方法是不会被调用的");
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
