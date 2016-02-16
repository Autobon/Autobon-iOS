//
//  CLAutobonViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/16.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLAutobonViewController.h"
#import "GFMapViewController.h"
#import "CLCertifyViewController.h"


@interface CLAutobonViewController ()

@end

@implementation CLAutobonViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [[UIColor alloc]initWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    [self setNavigation];
    
    [self addMap];
    
    [self setViewForAutobon];
}

// 添加地图
- (void)addMap{
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake(30.4,114.4);
    mapVC.distanceBlock = ^(double distance) {
        NSLog(@"距离－－%f--",distance);
    };
    
    [self.view addSubview:mapVC.view];
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    mapVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/3);
    mapVC.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3);
}

- (void)setViewForAutobon{
    
// 距离label
    UILabel *distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height/3+2+64, self.view.frame.size.width, self.view.frame.size.height/18)];
//    distanceLabel.backgroundColor = [UIColor cyanColor];
    distanceLabel.text = @"距离：  1.3km";
    distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [self.view addSubview:distanceLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, distanceLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 2)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView];
    
// 订单图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, lineView.frame.origin.y + 7, self.view.frame.size.width - 20, self.view.frame.size.height/4)];
    imageView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:imageView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+self.view.frame.size.height/4+5, self.view.frame.size.width, 2)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView2];
    
// 施工时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView2.frame.origin.y+4, self.view.frame.size.width, self.view.frame.size.height/18)];
//    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = @"施工时间： 今天14:30";
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [self.view addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 2)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView3];
    
    
// 备注
    UILabel *otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView3.frame.origin.y+4, self.view.frame.size.width, self.view.frame.size.height/18)];
//    otherLabel.backgroundColor = [UIColor cyanColor];
    otherLabel.text = @"备注： 今天天气不错，适合工作";
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [self.view addSubview:otherLabel];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/18-2, self.view.frame.size.width, 2)];
    lineView4.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView4];

// 我要接单
    UILabel *orderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/18, self.view.frame.size.width/2, self.view.frame.size.height/18)];
    orderLabel.text = @"我要接单";
    orderLabel.textColor = [[UIColor alloc]initWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];
    orderLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:orderLabel];
    
// 我要认证
    UIButton *certifyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-self.view.frame.size.height/18, self.view.frame.size.width/2, self.view.frame.size.height/18)];
    
    [certifyButton addTarget:self action:@selector(certifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [certifyButton setTitle:@"我要认证" forState:UIControlStateNormal];
    [certifyButton setTitleColor:[[UIColor alloc]initWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:certifyButton];
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-1, self.view.frame.size.height-self.view.frame.size.height/18, 2, self.view.frame.size.height/18)];
    lineView5.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView5];
    
}


- (void)certifyBtnClick{
    NSLog(@"认证按钮的响应方法");
    CLCertifyViewController *certify = [[CLCertifyViewController alloc]init];
    [self.navigationController pushViewController:certify animated:YES];
    
    
}



// 添加导航
- (void)setNavigation{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [[UIColor alloc]initWithRed:235/255.0 green:96/255.0 blue:1/255.0 alpha:1.0];
    [self.view addSubview:view];
    
// title
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, self.view.frame.size.width-200, 40)];
    label.text = @"车邻邦";
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
