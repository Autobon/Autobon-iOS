//
//  CLMoreViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLMoreViewController.h"
#import "GFNavigationView.h"
#import "GFServeViewController.h"
#import "GFQualifieViewController.h"
#import "GFTrainViewController.h"
#import "GFTransformViewController.h"


@interface CLMoreViewController ()

@end

@implementation CLMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    
    [self setViewForMore];
    
    
}

- (void)setViewForMore{
    
    NSArray *titleArray = @[@"资格认证",@"免费培训",@"服务中心",@"消息通知"];
    NSArray *imageNameArray = @[@"centre-1",@"book",@"centre",@"information-2"];
    for (int i = 0 ; i < 4; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0+(self.view.frame.size.width/2)*(i%2) , 84 + 60*(i/2), self.view.frame.size.width/2, 60)];
//        button.backgroundColor = [UIColor cyanColor];
        [button setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 40);
//        button.backgroundColor = [UIColor redColor];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        
        if (i>1) {
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        }else{
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        }
//        button.titleLabel.backgroundColor = [UIColor cyanColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i+1;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0] CGColor];
        
        [self.view addSubview:button];
    }
    
    
    
    
}


- (void)btnClick:(UIButton *)button{
    NSLog(@"-------%ld---",(long)button.tag);
    
    if(button.tag == 1) {
    
        [self.navigationController pushViewController:[[GFQualifieViewController alloc] init] animated:YES];
    }
    
    if(button.tag == 2) {
        
        [self.navigationController pushViewController:[[GFTrainViewController alloc] init] animated:YES];
    }
    
    if(button.tag == 3) {
        
        [self.navigationController pushViewController:[[GFServeViewController alloc] init] animated:YES];
    }
    
    if(button.tag == 4) {
        
        [self.navigationController pushViewController:[[GFTransformViewController alloc] init] animated:YES];
    }
    
}


// 添加导航
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"更多" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    
}

-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:NO];
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
