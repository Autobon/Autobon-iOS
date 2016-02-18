//
//  CLHomeOrderViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLHomeOrderViewController.h"
#import "GFNavigationView.h"


@interface CLHomeOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CLHomeOrderViewController

- (void)viewDidLoad {

    [self setNavigation];
    
    [self setTableView];
}

#pragma mark - 订单表格
- (void)setTableView{
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 72, 200, 20)];
    timeLabel.text = @"2015-01-05 星期二";
    timeLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 72, 80, 20)];
    stateLabel.text = @"接单模式";
    stateLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:stateLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 2)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    NSLog(@"当前星期几－－%@--",[self weekdayString]);
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 102, self.view.frame.size.width, self.view.frame.size.height-102)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = @"123546";
    
    return cell;
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
    
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
    
    
    
    
    
    
}



#pragma mark - 设置导航条
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    
}
-(void)backBtnClick{
//    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"个人信息界面");
    
    
}

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
