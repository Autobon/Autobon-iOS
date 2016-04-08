//
//  CLAddOrderSuccessViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/3/3.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLAddOrderSuccessViewController.h"
#import "GFNavigationView.h"
#import "GFMyMessageViewController.h"
#import "CLOrderDetailViewController.h"
#import "CLHomeOrderViewController.h"




@interface CLAddOrderSuccessViewController ()
{
    UIButton *_submitButton;
    NSTimer *_timer;
    NSInteger _a;
    
}
@end

@implementation CLAddOrderSuccessViewController


- (NSDictionary *)dataDictionary{
    if (_dataDictionary) {
        _dataDictionary = [[NSDictionary alloc]init];
    }
    return _dataDictionary;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigation];
    
    [self setDate];
    
    [self setViewForSuccess];
    
    _a = 5;
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(workBegin) userInfo:nil repeats:YES];
    }
    
    
}

- (void)workBegin{
    
    
    _a--;
    [_submitButton setTitle:[NSString stringWithFormat:@"开始工作(%ld)",(long)_a] forState:UIControlStateNormal];
    if (_a < 0) {
        
        [self backBtnClick];
        [_timer invalidate];
        _timer = nil;
        if (_addBlock) {
            _addBlock();
        }
    }
}


// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
    
    
    
    
}




#pragma mark - 设置日期和状态
- (void)setDate{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 36)];
    headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 20)];
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 8, 80, 20)];
    stateLabel.text = @"抢单模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:stateLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 36, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [headerView addSubview:view];
    
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






#pragma mark - 设置界面

- (void)setViewForSuccess{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, self.view.frame.size.width-60, 30)];
    label.text = @"抢单成功";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, self.view.frame.size.width-20, 30)];
    label2.text = [NSString stringWithFormat:@"订单编号：%@",_orderNum];
    label2.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label2];
    
    // 提交按钮
    _submitButton = [[UIButton alloc]init];
    _submitButton.frame = CGRectMake(30, 250, self.view.frame.size.width-60, 40);
    [_submitButton setTitle:@"开始工作(5)" forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage imageNamed:@"buttonClick"] forState:UIControlStateHighlighted];
    [_submitButton addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitButton];
    
}

#pragma mark - 开始工作的按钮响应方法
- (void)submitBtnClick{
   
    NSLog(@"----%@---",_dataDictionary);
    [_timer invalidate];
    _timer = nil;
    
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    
    CLOrderDetailViewController *detailView = [[CLOrderDetailViewController alloc]init];
    detailView.customerLat = _dataDictionary[@"positionLat"];
    detailView.customerLon = _dataDictionary[@"positionLon"];
    detailView.orderPhotoURL = [NSString stringWithFormat:@"http://121.40.157.200:12345%@",_dataDictionary[@"photo"]];
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_dataDictionary[@"orderTime"] floatValue]/1000];
    NSLog(@"---date-- %@---",[formatter stringFromDate:date]);
    
    detailView.orderTime = [formatter stringFromDate:date];
    
    
    
    if (![_dataDictionary[@"remark"] isKindOfClass:[NSNull class]]) {
        detailView.remark = _dataDictionary[@"remark"];
    }else{
        detailView.remark = @"";
    }
    detailView.orderId = _dataDictionary[@"id"];
    detailView.orderType = _dataDictionary[@"orderType"];
    detailView.action = _dataDictionary[@"status"];
    detailView.orderNumber = _dataDictionary[@"orderNum"];
    
    [self.navigationController pushViewController:detailView animated:YES];
    
    
    
}





- (void)backBtnClick{
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    [self.navigationController popViewControllerAnimated:YES];
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
