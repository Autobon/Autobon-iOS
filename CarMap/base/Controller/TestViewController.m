//
//  TestViewController.m
//  GFMap_2
//
//  Created by 陈光法 on 16/1/29.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "TestViewController.h"
#import "GFMapViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    

    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    
    [self.view addSubview:mapVC.view];
    
    
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    
//    mapVC.view.frame = CGRectMake(10, 100, width - 20, 200);
    
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
