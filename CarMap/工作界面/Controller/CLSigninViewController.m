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
#import "GFMyMessageViewController.h"
#import "GFTipView.h"
#import "CLHomeOrderViewController.h"
#import "CLHomeOrderCellModel.h"

#import "GFAlertView.h"
#import "GFFangqiViewController.h"


@interface CLSigninViewController ()
{
    
    GFMapViewController *_mapVC;
    NSTimer *_timer;
    
    GFNavigationView *_navView;
    UIView *_headerView;
    
    
}

@property (nonatomic ,strong) UILabel *distanceLabel;
@property (nonatomic ,strong) UIButton *signinButton;



@end

@implementation CLSigninViewController

- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigation];
    
    [self setDate];
    
    [self addMap];
    _signinButton.userInteractionEnabled = NO;
    
}

// 设置日期和状态
- (void)setDate{
    _headerView = [[UIView alloc]init];
    _headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 20)];
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [_headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 8, 80, 20)];
    stateLabel.text = @"工作模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [_headerView addSubview:stateLabel];
    
//    NSLog(@"设置日期和时间");
//    headerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_headerView];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.height.mas_offset(36);
    }];
    
    
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
//    NSLog(@"---dateString--%@---",dateString);
    
    NSString *timeString = [NSString stringWithFormat:@"%@  %@",dateString,[weekdays objectAtIndex:theComponents.weekday]];
    return timeString;
    
    
    
}

// 添加地图
- (void)addMap{
    _mapVC = [[GFMapViewController alloc] init];
    if ([self.customerLat isKindOfClass:[NSNull class]]) {
        _mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake(30.4,114.4);
    }else{
        _mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake([self.customerLat floatValue],[self.customerLon floatValue]);
    }
    _mapVC.bossPointAnno.iconImgName = @"location";
    _mapVC.bossPointAnno.title = _model.cooperatorFullname;
    __weak CLSigninViewController *signinView = self;
    
    _mapVC.distanceBlock = ^(double distance) {
//        NSLog(@"距离－－%f--",distance);
        
        signinView.distanceLabel.text = [NSString stringWithFormat:@"距离：%0.2fkm",distance/1000.0];
        if (distance < 500) {
            signinView.signinButton.userInteractionEnabled = YES;
            signinView.signinButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//            [signinView.signinButton setTitle:@"可以签到了" forState:UIControlStateNormal];
        }
        
    };
    
    [self.view addSubview:_mapVC.view];
    [self addChildViewController:_mapVC];
    [_mapVC didMoveToParentViewController:self];
//    _mapVC.view.frame = CGRectMake(0, 64+36, self.view.frame.size.width, self.view.frame.size.height/3);
    _mapVC.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3);
    
    [_mapVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom);
        make.height.mas_offset(self.view.frame.size.height/3);
    }];
    
    
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3+64+36+24, self.view.frame.size.width, 60)];
    _distanceLabel.text = @"距离门店   m";
    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_distanceLabel];
    
    _signinButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, 50)];
    _signinButton.center = CGPointMake(self.view.center.x, self.view.center.y+50+36);
    [_signinButton setTitle:@"签到" forState:UIControlStateNormal];
    _signinButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    _signinButton.layer.cornerRadius = 10;
    [_signinButton addTarget:self action:@selector(signinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_signinButton];
    
    
    // 距离提示框
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_signinButton.frame), [UIScreen mainScreen].bounds.size.width, 35)];
    tipLab.text = @"请在距离目标500米范围内进行提示";
    tipLab.font = [UIFont systemFontOfSize:12];
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    [self.view addSubview:tipLab];
    
    // 室外提示框
    UILabel *nothingLab = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 35, [UIScreen mainScreen].bounds.size.width, 35)];
    nothingLab.text = @"为了准确定位你的位置，请在室外无遮挡处定位";
    nothingLab.font = [UIFont systemFontOfSize:10];
    nothingLab.textAlignment = NSTextAlignmentCenter;
    nothingLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    [self.view addSubview:nothingLab];
    
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(UserLocation) userInfo:nil repeats:YES];
    }
    
    
}

#pragma mark - 调用地图的定位方法
- (void)UserLocation{
    [_mapVC startUserLocationService];
}



// 签到按钮的响应方法
- (void)signinBtnClick{
    
    
    NSDictionary *dic = @{@"positionLon":_customerLon,@"positionLat":_customerLat,@"orderId":_orderId};
    [GFHttpTool signinParameters:dic Success:^(NSDictionary *responseObject) {
//        NSLog(@"－－－－－%@---",responseObject);
        if ([responseObject[@"status"]integerValue] == 1) {
            CLWorkBeforeViewController *workBefore = [[CLWorkBeforeViewController alloc]init];
            workBefore.orderId = _orderId;
            workBefore.orderType = _orderType;
            workBefore.startTime = @"未开始";
            workBefore.orderNumber = self.orderNumber;
            workBefore.model = _model;
            [self.navigationController pushViewController:workBefore animated:YES];
//            [_timer invalidate];
//            _timer = nil;
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"--qiandao---%@--",error);
//        [self addAlertView:@"请求失败"];
    }];
    
}


#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

// 添加导航
- (void)setNavigation{
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"person" withRightImgHightName:@"personClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightBut addTarget:_navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *removeOrderButton = [[UIButton alloc]init];
    removeOrderButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //    removeOrderButton.backgroundColor = [UIColor grayColor];
//    removeOrderButton.layer.borderColor = [[UIColor whiteColor] CGColor];
//    removeOrderButton.layer.borderWidth = 1;
//    removeOrderButton.layer.cornerRadius = 20;
    [removeOrderButton setTitle:@"改派" forState:UIControlStateNormal];
    if([_model.status isEqualToString:@"IN_PROGRESS"] || [_model.status isEqualToString:@"SIGNED_IN"] || [_model.status isEqualToString:@"AT_WORK"]) {
        
        [removeOrderButton setTitle:@"改派" forState:UIControlStateNormal];
    }
    [removeOrderButton setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [removeOrderButton addTarget:self action:@selector(removeOrderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:removeOrderButton];
    
    [removeOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_navView).offset(-4);
        make.right.equalTo(_navView).offset(-45);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    [self.view addSubview:_navView];
    
    
}

#pragma mark - 弃单提示和请求
- (void)removeOrderBtnClick{
    GFAlertView *alertView = [[GFAlertView alloc]initWithTitle:@"确认要放弃此单吗？" leftBtn:@"取消" rightBtn:@"确定"];
    [alertView.rightButton addTarget:self action:@selector(removeOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertView];
}
- (void)removeOrder{
    //    NSLog(@"确认放弃订单，订单ID为 －－%@--- ",_orderId);
    
    GFFangqiViewController *vc = [[GFFangqiViewController alloc] init];
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
    
    /*
     [GFHttpTool postCancelOrder:_model.orderId Success:^(id responseObject) {
     
     NSLog(@"--放弃订单--%@", responseObject);
     if ([responseObject[@"status"] integerValue] == 1) {
     
     [GFTipView tipViewWithNormalHeightWithMessage:@"弃单成功" withShowTimw:1.5];
     [self performSelector:@selector(removeOrderSuccess) withObject:nil afterDelay:1.5];
     }else{
     
     [GFTipView tipViewWithNormalHeightWithMessage:responseObject[@"message"] withShowTimw:1.5];
     
     }
     
     } failure:^(NSError *error) {
     
     //       NSLog(@"放弃订单失败----%@---",error);
     
     }];
     */
    
}

- (void)removeOrderSuccess{
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)backBtnClick{
    
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    GFMyMessageViewController *myMessage = [[GFMyMessageViewController alloc]init];
//    [self.navigationController pushViewController:myMessage animated:YES];
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
