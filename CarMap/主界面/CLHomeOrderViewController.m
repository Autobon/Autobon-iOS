//
//  CLHomeOrderViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLHomeOrderViewController.h"
#import "GFNavigationView.h"
#import "CLTitleTableViewCell.h"
#import "CLHomeTableViewCell.h"
#import "SVPullToRefresh.h"
#import "CLOrderDetailViewController.h"
#import "GFMyMessageViewController.h"
#import "CLMoreViewController.h"
#import "GFHttpTool.h"
#import "CLHomeOrderCellModel.h"
#import "CLWorkBeforeViewController.h"

@interface CLHomeOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    UITableView *_tableView;
    NSInteger _rowNumber;
    
}
@property (nonatomic ,strong) NSMutableArray *cellModelArray;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic) NSInteger rowNumber;

@end

@implementation CLHomeOrderViewController

- (void)viewDidLoad {
    _rowNumber = 30;
    _cellModelArray = [[NSMutableArray alloc]init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    
    [GFHttpTool getOrderListSuccess:^(NSDictionary *responseObject) {
        if ([responseObject[@"result"] integerValue] == 1) {
            NSArray *dataArray = responseObject[@"data"];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"---obj---%@--",obj);
                CLHomeOrderCellModel *cellModel = [[CLHomeOrderCellModel alloc]init];
                cellModel.orderId = obj[@"id"];
                cellModel.orderNumber = obj[@"orderNum"];
//                cellModel.orderTime = [obj[@"orderTime"] integerValue];
                cellModel.orderType = obj[@"orderType"];
                cellModel.orderPhotoURL = obj[@"a.jpg"];
                cellModel.customerLat = obj[@"customerLat"];
                cellModel.customerLon = obj[@"customerLon"];
                cellModel.remark = obj[@"remark"];
                [_cellModelArray addObject:cellModel];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:1456398610];
                cellModel.orderTime = [formatter stringFromDate:date];
                NSLog(@"date1:%@",cellModel.orderTime);
                
                
            }];
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    
    [self setNavigation];
    
    [self setTableView];
}

#pragma mark - 订单表格
- (void)setTableView{
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     __weak CLHomeOrderViewController *weakSelf = self;
    [_tableView addInfiniteScrollingWithActionHandler:^{
        NSLog(@"下拉");
        weakSelf.rowNumber = 0;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:weakSelf.cellModelArray.count+1 inSection:0];
        [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf performSelector:@selector(after) withObject:nil afterDelay:5.0];
    }];
    
   
    [_tableView addPullToRefreshWithActionHandler:^{
        NSLog(@"上拉");
        [weakSelf performSelector:@selector(after) withObject:nil afterDelay:3.0];
//        _rowNumber = 4;
//        [_tableView reloadData];
        
    }];
    
    [self.view addSubview:_tableView];
    
    
}

- (void)after{
    [_tableView.infiniteScrollingView stopAnimating];
    [_tableView.pullToRefreshView stopAnimating];
    _rowNumber = 30;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_cellModelArray.count+1 inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cellModelArray.count+2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 38)];
    headerView.backgroundColor = [UIColor whiteColor];
    
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
    if (indexPath.row == 0) {
        return 85;
    }else if(indexPath.row == _cellModelArray.count+1){
        return _rowNumber;
    }else{
        return 80 + [UIScreen mainScreen].bounds.size.width*5/12;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        CLTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
        if (cell == nil) {
            cell = [[CLTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
            [cell initWithTitle];
        }
        return cell;
    }else if(indexPath.row == _cellModelArray.count+1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.text = @"加载更多";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        return cell;
    }else{
        CLHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"order"];
        if (cell == nil) {
            cell = [[CLHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"order"];
            [cell initWithOrder];
        }
        
        CLHomeOrderCellModel *cellModer = _cellModelArray[indexPath.row-1];
        cell.orderButton.tag = indexPath.row + 1;
        cell.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号%@",cellModer.orderNumber];
        cell.timeLabel.text = [NSString stringWithFormat:@"预约时间%@",cellModer.orderTime];
        if ([cellModer.orderType integerValue] == 1) {
            [cell.orderButton setTitle:@"开始工作" forState:UIControlStateNormal];
            
            [cell.orderButton addTarget:self action:@selector(workBegin:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [cell.orderButton setTitle:@"进入订单" forState:UIControlStateNormal];
            [cell.orderButton addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }
     
    
    return nil;
}

#pragma mark - 进入订单的按钮点击方法
- (void)orderBtnClick:(UIButton *)button{
    
    CLWorkBeforeViewController *workBefore = [[CLWorkBeforeViewController alloc]init];
    [self.navigationController pushViewController:workBefore animated:YES];
    
}


#pragma mark - 开始工作的按钮点击方法
- (void)workBegin:(UIButton *)button{
    NSLog(@"点击订单");
    
     CLHomeOrderCellModel *cellModel = _cellModelArray[button.tag-2];
    CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
    orderDetail.orderId = cellModel.orderId;
    orderDetail.customerLat = cellModel.customerLat;
    orderDetail.customerLon = cellModel.customerLon;
    orderDetail.orderPhotoURL = cellModel.orderPhotoURL;
    orderDetail.orderTime = cellModel.orderTime;
    orderDetail.remark = cellModel.remark;
    [self.navigationController pushViewController:orderDetail animated:YES];
    
    
    
    
    
    
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
    
    GFMyMessageViewController *myMsgVC = [[GFMyMessageViewController alloc] init];
    [self.navigationController pushViewController:myMsgVC animated:YES];
    
}

- (void)moreBtnClick{
    NSLog(@"更多--%p--",self.view);
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
