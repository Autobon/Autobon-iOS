//
//  CLOrderDetailViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLOrderDetailViewController.h"
#import "GFMapViewController.h"
#import "GFNavigationView.h"
#import "CLSigninViewController.h"
#import "CLAddPersonViewController.h"
#import "GFHttpTool.h"




@interface CLOrderDetailViewController ()
{
    UILabel *_distanceLabel;
    
}
@end

@implementation CLOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc]initWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    [self setNavigation];
    
    [self addMap];
    
    [self setViewForAutobon];
}

// 添加地图
- (void)addMap{
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    if ([self.customerLat isKindOfClass:[NSNull class]]) {
        mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake(30.4,114.4);
    }else{
        mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake([self.customerLat floatValue],[self.customerLon floatValue]);
    }
    
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
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height/3+2+64, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    distanceLabel.backgroundColor = [UIColor cyanColor];
    _distanceLabel.text = @"距离：  1.3km";
    _distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [self.view addSubview:_distanceLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _distanceLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView];
    
    // 订单图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, lineView.frame.origin.y + 7, self.view.frame.size.width - 20, self.view.frame.size.height/4)];
    //    imageView.backgroundColor = [UIColor darkGrayColor];
    imageView.image = [UIImage imageNamed:@"orderImage"];
    [self.view addSubview:imageView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+self.view.frame.size.height/4+5, self.view.frame.size.width, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView2];
    
    // 施工时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView2.frame.origin.y+4, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = [NSString stringWithFormat:@"施工时间：%@",self.orderTime];
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [self.view addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView3];

    // 备注
    UILabel *otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView3.frame.origin.y+4, self.view.frame.size.width-20, self.view.frame.size.height/9)];
    //    otherLabel.backgroundColor = [UIColor cyanColor];
    otherLabel.text = [NSString stringWithFormat:@"下单备注：%@",self.remark];
    otherLabel.numberOfLines = 0;
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [self.view addSubview:otherLabel];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/18-1, self.view.frame.size.width, 1)];
    lineView4.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView4];
    
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-0.5, self.view.frame.size.height-self.view.frame.size.height/18, 1, self.view.frame.size.height/18)];
    lineView5.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView5];
    
    
// 添加小伙伴
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/18, self.view.frame.size.width/2, self.view.frame.size.height/18)];
    
    [addButton setTitleColor:[[UIColor alloc]initWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.view addSubview:addButton];
    
    
// 开始工作
    UIButton *workButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-self.view.frame.size.height/18, self.view.frame.size.width/2, self.view.frame.size.height/18)];
    
    //    [workButton setTitleColor:[[UIColor alloc]initWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1.0] forState:UIControlStateNormal];
    [workButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    workButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:workButton];
    
    if ([_action isEqualToString:@"INVITE_PARTNER"]) {
        [addButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(orderDisagree) forControlEvents:UIControlEventTouchUpInside];
        [workButton addTarget:self action:@selector(orderAgree) forControlEvents:UIControlEventTouchUpInside];
        [workButton setTitle:@"接受" forState:UIControlStateNormal];
    }else if ([_action isEqualToString:@"TAKEN_UP"] || [_action isEqualToString:@"INVITATION_REJECTED"]){
        [addButton setTitle:@"+合作人" forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [workButton addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [workButton setTitle:@"开始工作" forState:UIControlStateNormal];

    }else if ([_action isEqualToString:@"SEND_INVITATION"]){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([[userDefaults objectForKey:@"userId"] integerValue] == [_mainTechId integerValue]) {
            [addButton setTitle:@"+合作人" forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [workButton addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [workButton setTitle:@"开始工作" forState:UIControlStateNormal];
        }else{
            [addButton setTitle:@"拒绝" forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(orderDisagree) forControlEvents:UIControlEventTouchUpInside];
            [workButton addTarget:self action:@selector(orderAgree) forControlEvents:UIControlEventTouchUpInside];
            [workButton setTitle:@"接受" forState:UIControlStateNormal];
        }
    }
    
}

#pragma mark - 添加合作小伙伴的响应方法
- (void)addBtnClick{
    NSLog(@"是时候添加一个小伙伴啦");
    CLAddPersonViewController *addPerson = [[CLAddPersonViewController alloc]init];
    addPerson.orderId = _orderId;
    [self.navigationController pushViewController:addPerson animated:YES];
}

#pragma mark - 开始工作按钮的响应方法
- (void)workBtnClick{
    NSLog(@"开始工作按钮");
    
    [GFHttpTool postOrderStart:[_orderId integerValue] Success:^(NSDictionary *responseObject) {
        NSLog(@"----responseObject--%@",responseObject);
        if ([responseObject[@"result"]integerValue] == 1) {
            CLSigninViewController *signinView = [[CLSigninViewController alloc]init];
            signinView.customerLat = self.customerLat;
            signinView.customerLon = self.customerLon;
            signinView.orderId = self.orderId;
            [self.navigationController pushViewController:signinView animated:YES];
        }else{
            NSLog(@"-----%@---",responseObject[@"message"]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"----失败原因－－%@--",error);
    }];
    
}


#pragma mark - 接受订单邀请的响应方法
- (void)orderAgree{
    [GFHttpTool PostAcceptOrderId:[_orderId integerValue] accept:@"true" success:^(id responseObject) {
        NSLog(@"----response--%@--",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"---error---%@--",error);
    }];
}

#pragma mark - 不接受订单邀请的响应方法
- (void)orderDisagree{
    [GFHttpTool PostAcceptOrderId:[_orderId integerValue] accept:@"false" success:^(id responseObject) {
        NSLog(@"----response--%@--",responseObject[@"message"]);
    } failure:^(NSError *error) {
        NSLog(@"---error---%@--",error);
    }];

}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
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
