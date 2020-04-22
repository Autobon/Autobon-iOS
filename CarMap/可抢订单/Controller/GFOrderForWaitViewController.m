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
//#import "GFOrderForWaitTableViewCell.h"
#import "CLOrderForWaitNewTableViewCell.h"
#import "CLAUTouchView.h"

#import "AppDelegate.h"

@interface GFOrderForWaitViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    NSInteger _page;
    
    NSMutableArray *_collectArray;
    
    GFNavigationView *_navView;
    
    NSMutableDictionary *_dataDictionary;
    
    NSMutableArray *_titleButtonArray;
    CLAUTouchView *_chooseTouchView;
    
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
    _dataDictionary = [[NSMutableDictionary alloc]init];
    _dataDictionary[@"order"] = @"1";
    [self setNavigation];
    
    [self selectHeaderView];
    
    [self getCollectList];
    
    
    
    [self _setView];
    
    self.noOrderlabel.hidden = YES;
    self.noOrderImageView.hidden = YES;
    
//    _dataDictionary[@"longitude"] = @"114.414640";
//    _dataDictionary[@"latitude"] = @"30.480380";
//    [1]    (null)    @"longitude" : @"114.414640"
//    [2]    (null)    @"latitude" : @"30.480380"
    [_tableView.mj_header beginRefreshing];
}

- (void)selectHeaderView{
    
    UIView *buttonSelectBaseView = [[UIView alloc]init];
    buttonSelectBaseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonSelectBaseView];
    [buttonSelectBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navView.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view).offset(0);
    }];
    
    
    _titleButtonArray = [[NSMutableArray alloc]init];
    NSArray *titleArray = @[@"全部",@"施工项目",@"距离",@"施工时间",@"排序"];
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger x = i * self.view.frame.size.width/5.0;
        button.frame = CGRectMake(x, 0, self.view.frame.size.width/5.0, 40);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:236/255.0 green:135/255.0 blue:12/255.0 alpha:1.0] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i + 1;
        [buttonSelectBaseView addSubview:button];
        [button addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_titleButtonArray addObject:button];
    }
    
}


- (void)titleBtnClick:(UIButton *)button{
    [_titleButtonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
        obj.titleLabel.font = [UIFont systemFontOfSize:14];
    }];
    button.selected = YES;
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [_chooseTouchView removeFromSuperview];
    switch (button.tag) {
        case 1:     //全部
            ICLog(@"全部");
            [_dataDictionary removeAllObjects];
            _dataDictionary[@"order"] = @"1";
            [_tableView.mj_header beginRefreshing];
            break;
        case 2:     //项目
        {
            ICLog(@"项目项目");
            NSArray *titleArray = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁",@"安全膜",@"其他"];
            [self setSearchViewWithTitleArray:titleArray chooseTouchViewTag:2];
        }
            break;
        case 3:     //距离
        {
            ICLog(@"距离");
             AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            _dataDictionary[@"longitude"] = appDelegate.locationDictionary[@"lng"];
            _dataDictionary[@"latitude"] = appDelegate.locationDictionary[@"lat"];
            _dataDictionary[@"orderType"] = @"2";
            [_tableView.mj_header beginRefreshing];
        }
            
            break;
        case 4:     //时间
        {
            ICLog(@"施工时间");
            _dataDictionary[@"orderType"] = @"1";
            [_tableView.mj_header beginRefreshing];
        }
            
            break;
        case 5:     //排序
        {
            ICLog(@"排序");
            NSArray *titleArray = @[@"倒序",@"正序"];
            [self setSearchViewWithTitleArray:titleArray chooseTouchViewTag:5];
            _dataDictionary[@"order"] = @(button.tag);
        }
            break;
        default:
            break;
    }
    
    
}


- (void)setSearchViewWithTitleArray:(NSArray *)titleArray chooseTouchViewTag:(NSInteger )tag{
    _chooseTouchView = [[CLAUTouchView alloc]init];
    _chooseTouchView.tag = tag;
    [_chooseTouchView setChooseViewWithTitleArray:titleArray];
    [_chooseTouchView.trueButton addTarget:self action:@selector(chooseTouchTrueBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_chooseTouchView];
    [_chooseTouchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navView.mas_bottom).offset(50);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (void)chooseTouchTrueBtnClick:(UIButton *)button{
    ICLog(@"button.tag------%ld--",button.tag);
    if(button.tag != 0){
        if(_chooseTouchView.tag == 2){          //施工项目
            _dataDictionary[@"workType"] = @(button.tag);
        }else if(_chooseTouchView.tag == 5){    //排序
            _dataDictionary[@"order"] = @(button.tag);
        }
        
        [_tableView.mj_header beginRefreshing];
    }
    
    
    
    [_chooseTouchView removeFromSuperview];
}




- (void)getCollectList{
    _collectArray = [[NSMutableArray alloc]init];
    
    [GFHttpTool favoriteCooperatorGetWithParameters:@{@"pageSize":@(200)} success:^(id responseObject) {
        NSArray *listArray = responseObject[@"list"];
        [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *cooperatorDic = obj[@"cooperator"];
            [_collectArray addObject:[NSString stringWithFormat:@"%@",cooperatorDic[@"id"]]];
            [self.tableView.mj_header beginRefreshing];
        }];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)httpWork {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
//    NSDictionary *dictionary = @{@"page":@(_page),@"pageSize":@(5)};
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    _dataDictionary[@"longitude"] = appDelegate.locationDictionary[@"lng"];
    _dataDictionary[@"latitude"] = appDelegate.locationDictionary[@"lat"];
//    _dataDictionary[@"longitude"] = @"115.147885";
//    _dataDictionary[@"latitude"] = @"30.489376";
    _dataDictionary[@"page"] = @(_page);
    _dataDictionary[@"pageSize"] = @(5);
    [GFHttpTool getOrderListNewDictionary:_dataDictionary Success:^(NSDictionary *responseObject) {
        
        ICLog(@"==可抢订单列表==%@", responseObject);
        
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        ICLog(@"-请求失败了－－error--%@---",error);
        //        [self addAlertView:@"请求失败"];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom).offset(45);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    

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
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelArr.count;
}

/*
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
*/


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLHomeOrderCellModel *cellModel = _modelArr[indexPath.row];
    return cellModel.cellHeight + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CLHomeOrderCellModel *model = (CLHomeOrderCellModel *)self.modelArr[indexPath.row];
    if (self.modelArr.count > indexPath.row){
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
//
//    NSLog(@"第几个数据模型；；；；%ld", indexPath.row);
//
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"order";
    CLOrderForWaitNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[CLOrderForWaitNewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.modelArr.count > indexPath.row) {
        
        CLHomeOrderCellModel *model = (CLHomeOrderCellModel *)self.modelArr[indexPath.row];
        cell.model = model;
        
//        if ([_collectArray containsObject:model.cooperatorId]) {
//            cell.collectImageView.image = [UIImage imageNamed:@"detailsStar"];
//        }else{
//            cell.collectImageView.image = [UIImage imageNamed:@"detailsStarDark"];
//        }
        
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
    
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"订单" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    
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
