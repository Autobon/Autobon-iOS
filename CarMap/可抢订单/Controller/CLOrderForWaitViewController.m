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

#import "GFKeqiangDDViewController.h"

#import "CLHomeOrderCellModel.h"





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

@property (nonatomic, strong) NSMutableArray *newsModelArr;

@end

@implementation CLOrderForWaitViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rowNumber = 30;
    _page = 1;
    _pageSize = 4;

    
    [self setNavigation];
    
    [self setTableView];
    
    self.newsModelArr = [[NSMutableArray alloc] init];
    
    _noOrderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 57, 57)];
    _noOrderImageView.center = self.view.center;
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

    
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)httpWorkForTableView{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    //    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = @{@"page":@(_page),@"pageSize":@(_pageSize)};
    [GFHttpTool getOrderListNewDictionary:dictionary Success:^(NSDictionary *responseObject) {
        
        ICLog(@"==可抢订单列表==%@", responseObject);
        
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *dataDit = responseObject[@"message"];
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
                
                //                NSDictionary *cooperatorDictionary = obj[@"cooperator"];
                
                CLHomeOrderCellModel *model1 = [[CLHomeOrderCellModel alloc] initWithDictionary:obj];
                [self.newsModelArr addObject:model1];
                
                model.cooperatorName = obj[@"coopName"];
                model.cooperatorAddress = obj[@"address"];
                model.cooperatorFullname = obj[@"coopName"];
                
                model.orderId = obj[@"id"];
                model.orderNumber = obj[@"orderNum"];
                
                NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁",@"安全膜",@"其他"];
                NSString *str = obj[@"type"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                NSString *ss = @"";
                for(int i=0; i<arr.count; i++) {
                    
                    NSInteger index = [arr[i] integerValue] - 1;
                    if (index > array.count - 1){
                        index = array.count - 1;
                    }
                    if([ss isEqualToString:@""]) {
                        
                        ss = array[index];
                    }else {
                        
                        ss = [NSString stringWithFormat:@"%@,%@", ss, array[index]];
                    }
                }
                
                model.orderType = ss;
                model.orderPhoto = obj[@"photo"];
                model.orderLat = obj[@"latitude"];
                model.orderLon = obj[@"longitude"];
                model.dataDictionary = obj;
                if ([obj[@"remark"] isKindOfClass:[NSNull class]]) {
                    model.orderRemark = @" ";
                }else{
                    model.orderRemark = obj[@"remark"];
                }
                
                
                
                //                cellModel.secondTechId = obj[@"secondTechId"];
                [_cellModelArray addObject:model];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"agreedEndTime"] doubleValue]/1000];
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
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"-不知道为什么请求失败了－－error--%@---",error);
        //        [self addAlertView:@"请求失败"];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

#pragma mark - 立即抢单
- (void)knockBtnClick:(UIButton *)button{
    
    CLHomeOrderCellModel *_model = (CLHomeOrderCellModel *)_newsModelArr[button.tag-1];
    
    [GFHttpTool postOrderId:[_model.orderId integerValue] Success:^(NSDictionary *responseObject) {
        
//        NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"status"]integerValue] == 1) {
            
            CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
            addSuccess.model = _model;
            
            [self.navigationController pushViewController:addSuccess animated:NO];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"----抢单结果-222-%@--",error);
        //        [self addAlertView:@"请求失败"];
    }];
    
    
    /*
    [GFHttpTool postOrderId:[model.orderId integerValue] Success:^(NSDictionary *responseObject) {
        
//        NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"status"]integerValue] == 1) {
            
            
            
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
    */
    
    
}

- (void)headRefresh {
    
    _page = 1;
    _pageSize = 4;
    self.cellModelArray = [[NSMutableArray alloc] init];
    
    [self httpWorkForTableView];
    
}

- (void)footRefresh {

    _page = _page + 1;
    _pageSize = 4;
    
    [self httpWorkForTableView];
}



#pragma mark - 订单表格
- (void)setTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return _cellModelArray.count+1;
//    return _cellModelArray.count;
    return self.newsModelArr.count;
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
    
    return 190;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.newsModelArr.count > indexPath.row){
        CLHomeOrderCellModel *cellModel = (CLHomeOrderCellModel *)self.newsModelArr[indexPath.row];
        
        //    NSLog(@"第几个数据模型；；；；%ld", indexPath.row);
        
        GFKeqiangDDViewController *orderDetail = [[GFKeqiangDDViewController alloc]init];
        orderDetail.model = cellModel;
        orderDetail.startTime = cellModel.startTime;
        orderDetail.orderId = cellModel.orderId;
        orderDetail.customerLat = cellModel.customerLat;
        orderDetail.customerLon = cellModel.customerLon;
        orderDetail.orderPhotoURL = cellModel.orderPhotoURL;
        orderDetail.orderTime = cellModel.orderTime;
        orderDetail.remark = cellModel.remark;
        orderDetail.action = cellModel.status;
        orderDetail.orderType = cellModel.orderType;
        orderDetail.orderNumber = cellModel.orderNumber;
        orderDetail.cooperatorName = cellModel.cooperatorFullname;
        orderDetail.cooperatorAddress = cellModel.address;
        orderDetail.cooperatorFullname = cellModel.cooperatorFullname;
        
        //    CLNewOrderDetailViewController *newOrderDetail = [[CLNewOrderDetailViewController alloc]init];
        //    newOrderDetail.model = _cellModelArray[indexPath.row - 1];
        //    NSLog(@"-----model -%@---cell--%@-",newOrderDetail.model,_cellModelArray[indexPath.row-1]);
        [self.navigationController pushViewController:orderDetail animated:YES];
        //    NSLog(@"--------model.dictionary-----%@---",newOrderDetail.model.dataDictionary);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        static NSString *ID = @"order";
        CLNewOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            
            cell = [[CLNewOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//            [cell initWithOrder];
        }
    
        if (_cellModelArray.count > indexPath.row) {
            
//            CLHomeOrderCellModel *model = (CLHomeOrderCellModel *)self.newsModelArr[indexPath.row];
//            cell.orderButton.tag = indexPath.row + 1;
            
            
            CLListNewModel *cellModer = _cellModelArray[indexPath.row];
            cell.orderButton.tag = indexPath.row + 1;
            
            cell.typeLabel.text = cellModer.orderType;
            cell.orderTypeLabelText = cellModer.orderType;
//            cell.typeLabel.text = cellModer.orderType;
            cell.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@",cellModer.orderNumber];
            cell.timeLabel.text = [NSString stringWithFormat:@"预约时间：%@",cellModer.orderTime];
            [cell.orderImageView sd_setImageWithURL:[NSURL URLWithString:cellModer.orderPhoto] placeholderImage:[UIImage imageNamed:@"orderImage"]];
            [cell.orderButton setTitle:@"抢单" forState:UIControlStateNormal];
            cell.orderButton.tag = indexPath.row;
            [cell.orderButton addTarget:self action:@selector(knockBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    
        return cell;
//    };
//    
//    
//    return nil;
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
