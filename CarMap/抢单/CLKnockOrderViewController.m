//
//  CLKnockOrderViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLKnockOrderViewController.h"
#import "GFMapViewController.h"
#import "CLCertifyViewController.h"
#import "GFNavigationView.h"


@interface CLKnockOrderViewController ()
{
    UIView *_orderView;
}
@end

@implementation CLKnockOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc]initWithWhite:0.2 alpha:0.2];
    _orderView = [[UIView alloc]initWithFrame:CGRectMake(10, 90, self.view.frame.size.width-20, self.view.frame.size.height-100)];
    _orderView.backgroundColor = [UIColor whiteColor];
    _orderView.layer.borderWidth = 1.0f;
    _orderView.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1]CGColor];
    _orderView.layer.cornerRadius = 10;
    
    
    [self.view addSubview:_orderView];
    
    
    [self addMap];
    
    [self setViewForAutobon];
    
    
    
}

// 添加地图
- (void)addMap{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 150, 30)];
    titleLabel.text = @"汽车贴膜";
    [_orderView addSubview:titleLabel];
    
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake(30.4,114.4);
    mapVC.distanceBlock = ^(double distance) {
        NSLog(@"距离－－%f--",distance);
    };
    
    [_orderView addSubview:mapVC.view];
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    mapVC.view.frame = CGRectMake(0, 44, _orderView.frame.size.width, _orderView.frame.size.height/3);
    mapVC.mapView.frame = CGRectMake(0, 0, _orderView.frame.size.width, _orderView.frame.size.height/3);
}

- (void)setViewForAutobon{
    
    // 距离label
    UILabel *distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _orderView.frame.size.height/3+2+44, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    distanceLabel.backgroundColor = [UIColor cyanColor];
    distanceLabel.text = @"距离：  1.3km";
    distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_orderView addSubview:distanceLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, distanceLabel.frame.origin.y+self.view.frame.size.height/18, _orderView.frame.size.width, 2)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_orderView addSubview:lineView];
    
    // 订单图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, lineView.frame.origin.y + 7, _orderView.frame.size.width - 20, _orderView.frame.size.height/4)];
    //    imageView.backgroundColor = [UIColor darkGrayColor];
    imageView.image = [UIImage imageNamed:@"orderImage"];
    [_orderView addSubview:imageView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+_orderView.frame.size.height/4+5, _orderView.frame.size.width, 2)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_orderView addSubview:lineView2];
    
    // 施工时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView2.frame.origin.y+4, _orderView.frame.size.width, _orderView.frame.size.height/18)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = @"工作时间： 今天14:30";
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_orderView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 2)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_orderView addSubview:lineView3];
    
    
    // 备注
    UILabel *otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView3.frame.origin.y+4, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    otherLabel.backgroundColor = [UIColor cyanColor];
    otherLabel.text = @"工作备注：今天天气不错，适合工作";
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_orderView addSubview:otherLabel];
    
    
    // 我要认证
    UIButton *certifyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, _orderView.frame.size.height-_orderView.frame.size.height/9+10, self.view.frame.size.width/2, self.view.frame.size.height/18)];
    [certifyButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [certifyButton setBackgroundImage:[UIImage imageNamed:@"buttonClick"] forState:UIControlStateHighlighted];
    [certifyButton addTarget:self action:@selector(certifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [certifyButton setTitle:@"立即抢单(5)" forState:UIControlStateNormal];
    [certifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_orderView addSubview:certifyButton];
    
    
// 取消按钮
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, _orderView.frame.origin.y-5, 30, 30)];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"deleteOrder"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateHighlighted];
    [self.view addSubview:cancelButton];
    
    
}


- (void)certifyBtnClick{
    NSLog(@"认证按钮的响应方法");
//    CLCertifyViewController *certify = [[CLCertifyViewController alloc]init];
//    [self.navigationController pushViewController:certify animated:YES];
    
    
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
