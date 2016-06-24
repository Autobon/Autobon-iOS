//
//  CLHomeOrderViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLOrderForWaitViewController.h"
#import "GFNavigationView.h"
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







@interface CLOrderForWaitViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //    UITableView *_tableView;
    NSInteger _rowNumber;
    UILabel *_noOrderlabel;
    UIImageView *_noOrderImageView;
    NSDictionary *_inviteDictionary;
    
    NSInteger _page;
    NSInteger _pageSize;
    
}
@property (nonatomic ,strong) NSMutableArray *cellModelArray;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic) NSInteger rowNumber;

@end

@implementation CLOrderForWaitViewController









- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rowNumber = 30;
    _page = 1;
    _pageSize = 4;

    
    [self setNavigation];
    
    [self setTableView];
    
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

    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableView.header beginRefreshing];
    
    
}



- (void)httpWorkForTableView{
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = @{@"page":@(_page),@"pageSize":@(_pageSize)};
    [GFHttpTool getOrderListNewDictionary:dictionary Success:^(NSDictionary *responseObject) {
        if ([responseObject[@"result"] integerValue] == 1) {
            //            NSLog(@"wangluoqingqiu");
            NSDictionary *dataDit = responseObject[@"data"];
            NSArray *dataArray = dataDit[@"list"];
            if (_page == 1) {
                _cellModelArray = [[NSMutableArray alloc]init];
            }
            if (dataArray.count == 0 && _cellModelArray.count > 0) {
                [self addAlertView:@"已加载全部"];
            }
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
//                NSLog(@"---obj---%@--",obj);
                CLListNewModel *model = [[CLListNewModel alloc]init];
                
                NSDictionary *cooperatorDictionary = obj[@"cooperator"];
                model.cooperatorName = cooperatorDictionary[@"corporationName"];
                model.cooperatorAddress = cooperatorDictionary[@"address"];
                model.cooperatorFullname = cooperatorDictionary[@"fullname"];
                
                model.orderId = obj[@"id"];
                model.orderNumber = obj[@"orderNum"];
                model.orderType = obj[@"orderType"];
                extern NSString* const URLHOST;
                model.orderPhoto = [NSString stringWithFormat:@"%@%@",URLHOST,obj[@"photo"]];
                model.orderLat = obj[@"positionLat"];
                model.orderLon = obj[@"positionLon"];
                model.dataDictionary = obj;
                if ([obj[@"remark"] isKindOfClass:[NSNull class]]) {
                    model.orderRemark = @" ";
                }else{
                    model.orderRemark = obj[@"remark"];
                }
                
            
                
                //                cellModel.secondTechId = obj[@"secondTechId"];
                [_cellModelArray addObject:model];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"orderTime"] floatValue]/1000];
                model.orderTime = [formatter stringFromDate:date];
                //                NSLog(@"cellModel.orderNumber:%@",cellModel.orderNumber);
                
                
            }];
            
            if (_cellModelArray.count != 0) {
                _noOrderImageView.hidden = YES;
                _noOrderlabel.hidden = YES;
                
            }else{
                _noOrderImageView.hidden = NO;
                _noOrderlabel.hidden = NO;
            }
            
            [_tableView reloadData];
            
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"-不知道为什么请求失败了－－error--%@---",error);
//        [self addAlertView:@"请求失败"];
    }];
}






#pragma mark - 立即抢单
- (void)knockBtnClick:(UIButton *)button{
    
    CLListNewModel *model = _cellModelArray[button.tag-1];
    
    [GFHttpTool postOrderId:[model.orderId integerValue] Success:^(NSDictionary *responseObject) {
        
//        NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"result"]integerValue] == 1) {
            
            
            
            CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
            
            addSuccess.orderNum = model.orderNumber;
            addSuccess.dataDictionary = model.dataDictionary;
            
            
            
//            addSuccess.addBlock = ^{
//                _noOrderImageView.hidden = YES;
//                _noOrderlabel.hidden = YES;
//                
//                //                [self headRefresh];
//            };
            [self.navigationController pushViewController:addSuccess animated:NO];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"----抢单结果-222-%@--",error);
//        [self addAlertView:@"请求失败"];
    }];
    
    
    
}



- (void)headRefresh {
    
    _page = 1;
    _pageSize = 4;
    
    
    [self httpWorkForTableView];
    
}

- (void)footRefresh {
    if (_page == 1) {
        _page = 2;
    }
    _page = _page + 1;
    _pageSize = 2;
    
    [self httpWorkForTableView];
}



#pragma mark - 订单表格
- (void)setTableView{
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cellModelArray.count+1;
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
    if (indexPath.row == 0) {
        return 0;
    }else{
        return 75 + [UIScreen mainScreen].bounds.size.width*5/12;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CLNewOrderDetailViewController *newOrderDetail = [[CLNewOrderDetailViewController alloc]init];
    newOrderDetail.model = _cellModelArray[indexPath.row - 1];
//    NSLog(@"-----model -%@---cell--%@-",newOrderDetail.model,_cellModelArray[indexPath.row-1]);
    [self.navigationController pushViewController:newOrderDetail animated:YES];
//    NSLog(@"--------model.dictionary-----%@---",newOrderDetail.model.dataDictionary);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
            //            [cell initWithTitle];
        }
        return cell;
    }else{
        CLNewOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"order"];
        if (cell == nil) {
            cell = [[CLNewOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"order"];
            [cell initWithOrder];
        }
        if (indexPath.row <= _cellModelArray.count) {
            CLListNewModel *cellModer = _cellModelArray[indexPath.row-1];
            cell.orderButton.tag = indexPath.row + 1;
            NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
            cell.typeLabel.text = array[[cellModer.orderType integerValue]-1];
//            cell.typeLabel.text = cellModer.orderType;
            cell.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号%@",cellModer.orderNumber];
            cell.timeLabel.text = [NSString stringWithFormat:@"预约时间%@",cellModer.orderTime];
            [cell.orderImageView sd_setImageWithURL:[NSURL URLWithString:cellModer.orderPhoto] placeholderImage:[UIImage imageNamed:@"orderImage"]];
            [cell.orderButton setTitle:@"抢单" forState:UIControlStateNormal];
            cell.orderButton.tag = indexPath.row;
            [cell.orderButton addTarget:self action:@selector(knockBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    };
    
    
    return nil;
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
