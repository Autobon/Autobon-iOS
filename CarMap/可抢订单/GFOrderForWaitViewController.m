//
//  GFOrderForWaitViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/12/14.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFOrderForWaitViewController.h"
#import "GFNavigationView.h"
#import "GFTipView.h"
#import "CLTitleTableViewCell.h"
#import "CLNewOrderTableViewCell.h"
#import "GFHttpTool.h"
#import "GFAlertView.h"
#import "CLAddOrderSuccessViewController.h"
#import "MJRefresh.h"
#import "GFTipView.h"
#import "UIImageView+WebCache.h"
#import "CLListNewModel.h"
#import "CLNewOrderDetailViewController.h"
#import "GFKeqiangDDViewController.h"
#import "CLHomeOrderCellModel.h"
#import "GFOrderForWaitTableViewCell.h"

@interface GFOrderForWaitViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    NSInteger _page;
}

@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) UILabel *noOrderlabel;
@property (nonatomic, strong) UIImageView *noOrderImageView;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GFOrderForWaitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.modelArr = [[NSMutableArray alloc] init];
    
    [self setNavigation];
    
    [self _setView];
    
}

- (void)httpWork {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    NSDictionary *dictionary = @{@"page":@(_page),@"pageSize":@(5)};
    [GFHttpTool getOrderListNewDictionary:dictionary Success:^(NSDictionary *responseObject) {
        
//        NSLog(@"==可抢订单列表==%@", responseObject);
        
        if([responseObject[@"status"] integerValue] == 1) {
        
            NSDictionary *messageDic = responseObject[@"message"];
            NSArray *listArr = messageDic[@"list"];
            for(int i=0; i<listArr.count; i++) {
            
                NSDictionary *dic = listArr[i];
                CLHomeOrderCellModel *model = [[CLHomeOrderCellModel alloc] initWithDictionary:dic];
                [self.modelArr addObject:model];
            }
            
            if(_page >= [messageDic[@"totalPages"] integerValue] && listArr.count <= 5) {
            
                [self addAlertView:@"已加载全部"];
            }
            
            if(self.modelArr.count > 0) {
            
                self.noOrderlabel.hidden = YES;
                self.noOrderImageView.hidden = YES;
            }else {
                
                self.noOrderlabel.hidden = NO;
                self.noOrderImageView.hidden = NO;
            }
        }else {
            
            [self addAlertView:responseObject[@"message"]];
        }
            
        [_tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        //        NSLog(@"-不知道为什么请求失败了－－error--%@---",error);
        //        [self addAlertView:@"请求失败"];
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
    }];
}
- (void)headRefresh {
    
    self.modelArr = [[NSMutableArray alloc] init];
    _page = 1;
    
    [self httpWork];
}
- (void)footRefresh {
    
    _page = _page + 1;
    
    [self httpWork];
}

- (void)_setView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    

    _noOrderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 57, 57)];
    _noOrderImageView.center = _tableView.center;
    _noOrderImageView.image = [UIImage imageNamed:@"NoOrder"];
    [self.view addSubview:_noOrderImageView];
    [self.view bringSubviewToFront:_noOrderImageView];
    
    _noOrderlabel = [[UILabel alloc]initWithFrame:CGRectMake(100, _noOrderImageView.frame.origin.y + 60, self.view.frame.size.width-200, 30)];
    _noOrderlabel.text = @"暂无订单";
    _noOrderlabel.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0];
    _noOrderlabel.font = [UIFont systemFontOfSize:15];
    _noOrderlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_noOrderlabel];
    [self.view bringSubviewToFront:_noOrderImageView];
    
    
    
    [self.tableView.header beginRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelArr.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 38)];
    headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 20)];
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 8, 80, 20)];
    stateLabel.text = @"接单模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:stateLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 37, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [headerView addSubview:view];
    
    //    NSLog(@"当前星期几－－%@--",[self weekdayString]);
    
    return headerView;
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CLHomeOrderCellModel *model = (CLHomeOrderCellModel *)self.modelArr[indexPath.row];
    
//
//    NSLog(@"第几个数据模型；；；；%ld", indexPath.row);
//    
    GFKeqiangDDViewController *orderDetail = [[GFKeqiangDDViewController alloc]init];
    orderDetail.model = model;
    orderDetail.startTime = model.startTime;
    orderDetail.orderId = model.orderId;
    orderDetail.customerLat = model.customerLat;
    orderDetail.customerLon = model.customerLon;
    orderDetail.orderPhotoURL = model.orderPhotoURL;
    orderDetail.orderTime = model.orderTime;
    orderDetail.remark = model.remark;
    orderDetail.action = model.status;
    orderDetail.orderType = model.orderType;
    orderDetail.orderNumber = model.orderNumber;
    orderDetail.cooperatorName = model.cooperatorFullname;
    orderDetail.cooperatorAddress = model.address;
    orderDetail.cooperatorFullname = model.cooperatorFullname;
    
    [self.navigationController pushViewController:orderDetail animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"order";
    GFOrderForWaitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[GFOrderForWaitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.modelArr.count > indexPath.row) {
        
        CLHomeOrderCellModel *model = (CLHomeOrderCellModel *)self.modelArr[indexPath.row];
        cell.model = model;
    }
    
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
    //    NSLog(@"---dateString--%@---",dateString);
    
    NSString *timeString = [NSString stringWithFormat:@"%@  %@",dateString,[weekdays objectAtIndex:theComponents.weekday]];
    return timeString;
    
}


#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

#pragma mark - 设置导航条
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"订单" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    //    navView.hidden = YES;
}

-(void)backBtnClick{
    
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
