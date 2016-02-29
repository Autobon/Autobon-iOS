//
//  SigninViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLSigninViewController.h"
#import "GFNavigationView.h"
#import "GFMapViewController.h"
#import "CLWorkBeforeViewController.h"
#import "GFHttpTool.h"



@interface CLSigninViewController ()

@end

@implementation CLSigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDate];
    
    [self setNavigation];
    
    [self addMap];
    
}

// 设置日期和状态
- (void)setDate{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 36)];
    headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 20)];
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 8, 80, 20)];
    stateLabel.text = @"工作模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:stateLabel];
    
    NSLog(@"设置日期和时间");
//    headerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:headerView];
}
#pragma mark - 获取周几
- (NSString *)weekdayString{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"zh_CN"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSLog(@"---dateString--%@---",dateString);
    
    NSString *timeString = [NSString stringWithFormat:@"%@  %@",dateString,[weekdays objectAtIndex:theComponents.weekday]];
    return timeString;
    
    
    
}

// 添加地图
- (void)addMap{
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake([self.customerLat floatValue],[self.customerLon floatValue]);
    mapVC.distanceBlock = ^(double distance) {
        NSLog(@"距离－－%f--",distance);
    };
    
    [self.view addSubview:mapVC.view];
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    mapVC.view.frame = CGRectMake(0, 64+36, self.view.frame.size.width, self.view.frame.size.height/3);
    mapVC.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3);
    
    
    UILabel *distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3+64+36, self.view.frame.size.width, 60)];
    distanceLabel.text = @"距离门店 300m";
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:distanceLabel];
    
    UIButton *signinButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, 50)];
    signinButton.center = CGPointMake(self.view.center.x, self.view.center.y+50+36);
    [signinButton setTitle:@"签到" forState:UIControlStateNormal];
    signinButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    signinButton.layer.cornerRadius = 10;
    
    [signinButton addTarget:self action:@selector(signinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signinButton];
    
    
}

// 签到按钮的响应方法
- (void)signinBtnClick{
    
    NSLog(@"---签到按钮-----");
    
    NSDictionary *dic = @{@"rtpositionLon":_customerLon,@"rtpositionLat":_customerLat,@"technicianId":@"1",@"orderId":_orderId};
    [GFHttpTool signinParameters:dic Success:^(NSDictionary *responseObject) {
        if ([responseObject[@"result"]integerValue] == 1) {
            CLWorkBeforeViewController *workBefore = [[CLWorkBeforeViewController alloc]init];
            [self.navigationController pushViewController:workBefore animated:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"--qiandao---%@--",error);
    }];
    
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
//    [self.navigationController popViewControllerAnimated:YES];
    
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
