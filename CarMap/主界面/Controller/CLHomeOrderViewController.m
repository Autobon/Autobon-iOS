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
#import "CLOrderDetailViewController.h"
#import "GFMyMessageViewController.h"
#import "CLMoreViewController.h"
#import "GFHttpTool.h"
#import "CLHomeOrderCellModel.h"
#import "CLWorkBeforeViewController.h"
#import "GFAlertView.h"
#import "CLKnockOrderViewController.h"
#import "CLAddOrderSuccessViewController.h"
#import "MJRefresh.h"
#import "GFTipView.h"
#import "CLSigninViewController.h"
#import "CLWorkOverViewController.h"
#import "CLCleanWorkViewController.h"
#import "UIImageView+WebCache.h"
#import <Google/Analytics.h>
#import "CLOrderForWaitViewController.h"
#import "GFNewOrderModel.h"
#import "GFHomeTableViewCell.h"
#import "GFOrderForWaitViewController.h"



@interface CLHomeOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    UITableView *_tableView;
    NSInteger _rowNumber;
    UILabel *_noOrderlabel;
    UIImageView *_noOrderImageView;
    NSDictionary *_inviteDictionary;
    
    NSInteger _page;
    NSInteger _pageSize;
//    CLKnockOrderViewController *_knockOrder;
    
    GFNavigationView *_navView;
    
}
@property (nonatomic ,strong) NSMutableArray *cellModelArray;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic) NSInteger rowNumber;


@end

@implementation CLHomeOrderViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    [userDefalts setObject:@"YES" forKey:@"homeOrder"];
    [userDefalts synchronize];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"home"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [self.tableView.header beginRefreshing]; 
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    [userDefalts setObject:@"NO" forKey:@"homeOrder"];
    [userDefalts synchronize];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:YES];
//    [self headRefresh];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"到这里了--%@--",NSHomeDirectory());
    
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
    
    _noOrderlabel.hidden = YES;
    _noOrderImageView.hidden = YES;
    
    
//    [self httpWorkForTableView];
//
//
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableView.header beginRefreshing];
//    [self.tableView.footer beginRefreshing];
    
    
    [self NSNotificationCenter];
    
}


#pragma mark - 网络请求
- (void)httpWorkForTableView{
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = @{@"page":@(_page),@"pageSize":@(_pageSize), @"status":@"2"};
    [GFHttpTool getOrderListDictionary:dictionary Success:^(NSDictionary *responseObject) {
        
        ICLog(@"===++==%@", responseObject);
        
        
        
        if([responseObject[@"status"] integerValue] == 1) {
            
            NSDictionary *messageDic = responseObject[@"message"];
            NSArray *contentArr = messageDic[@"content"];
            
            if(_page == 1) {
            
                _cellModelArray = [[NSMutableArray alloc] init];
            }
            if(contentArr.count == 0 && _cellModelArray.count > 0) {
                
                [self addAlertView:@"已加载全部"];
            }
            
            for(int i=0; i<contentArr.count; i++) {
                
                NSDictionary *dic = contentArr[i];
                CLHomeOrderCellModel *cellModel = [[CLHomeOrderCellModel alloc] initWithDictionary:dic];
//                GFNewOrderModel *cellModel = [[GFNewOrderModel alloc] initWithDictionary:dic];
                [_cellModelArray addObject:cellModel];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dic[@"agreedStartTime"] doubleValue]/1000];
                cellModel.orderTime = [formatter stringFromDate:date];
            }
            
            
            if (_cellModelArray.count != 0) {
                _noOrderImageView.hidden = YES;
                _noOrderlabel.hidden = YES;
                
            }else{
                _noOrderImageView.hidden = NO;
                _noOrderlabel.hidden = NO;
            }
            
            [_tableView reloadData];
            
            
        }else{
            [self addAlertView:responseObject[@"message"]];
            
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        /*
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
                CLHomeOrderCellModel *cellModel = [[CLHomeOrderCellModel alloc]init];
                NSDictionary *cooperatorDictionary = obj[@"cooperator"];
                cellModel.cooperatorName = cooperatorDictionary[@"corporationName"];
                cellModel.cooperatorAddress = cooperatorDictionary[@"address"];
                cellModel.cooperatorFullname = cooperatorDictionary[@"fullname"];
                cellModel.orderId = obj[@"id"];
                cellModel.orderNumber = obj[@"orderNum"];
                cellModel.orderType = obj[@"orderType"];
                extern NSString* const URLHOST;
                cellModel.orderPhotoURL = [NSString stringWithFormat:@"%@%@",URLHOST,obj[@"photo"]];
                cellModel.customerLat = obj[@"positionLat"];
                cellModel.customerLon = obj[@"positionLon"];
                if ([obj[@"remark"] isKindOfClass:[NSNull class]]) {
                    cellModel.remark = @" ";
                }else{
                    cellModel.remark = obj[@"remark"];
                }
                cellModel.status = obj[@"status"];
                NSDictionary *mainTechDictionary = obj[@"mainTech"];
                
                if ([mainTechDictionary[@"id"] integerValue] == [[userDefaults objectForKey:@"userId"] integerValue]) {
                    cellModel.mainTechId = mainTechDictionary[@"id"];
                }
                if ([[userDefaults objectForKey:@"userId"] integerValue] == [cellModel.mainTechId integerValue]) {
//                    NSLog(@"我是主技师");
                    if (![obj[@"mainConstruct"] isKindOfClass:[NSNull class]]) {
                        NSDictionary *mainDictionary = obj[@"mainConstruct"];
                        cellModel.startTime = mainDictionary[@"startTime"];
                        cellModel.signinTime = mainDictionary[@"signinTime"];
                        cellModel.beforePhotos = mainDictionary[@"beforePhotos"];
                        cellModel.afterPhotos = mainDictionary[@"afterPhotos"];
                        
                    }
                    if (![obj[@"secondTech"] isKindOfClass:[NSNull class]]) {
//                        NSLog(@"有小伙伴");
                        NSDictionary *secondDictionary = obj[@"secondTech"];
                        cellModel.secondTechId = secondDictionary[@"name"];
                        cellModel.mateName = secondDictionary[@"name"];
                    }
                    
                }else{
//                    NSLog(@"我是次技师");
                    NSDictionary *secondDictionary = obj[@"mainTech"];
                    cellModel.mateName = secondDictionary[@"name"];
                    if (![obj[@"secondConstruct"] isKindOfClass:[NSNull class]]) {
                        NSDictionary *mainDictionary = obj[@"secondConstruct"];
                        cellModel.startTime = mainDictionary[@"startTime"];
                        cellModel.signinTime = mainDictionary[@"signinTime"];
                        cellModel.beforePhotos = mainDictionary[@"beforePhotos"];
                        cellModel.afterPhotos = mainDictionary[@"afterPhotos"];
                    }
                    
                    cellModel.secondTechId = secondDictionary[@"name"];
                }
                
//                cellModel.secondTechId = obj[@"secondTechId"];
                [_cellModelArray addObject:cellModel];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"orderTime"] floatValue]/1000];
                cellModel.orderTime = [formatter stringFromDate:date];
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
         
         */
    } failure:^(NSError *error) {
//        NSLog(@"-不知道为什么请求失败了－－error--%@---",error);
//        [self addAlertView:@"请求失败"];
    }];
}


#pragma mark - 注册通知中心
- (void)NSNotificationCenter{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"NEW_ORDER" object:nil];
}
#pragma mark - 接受通知消息
-(void)receiveNotification:(NSNotification *)Notification {
    
    _inviteDictionary = [[NSDictionary alloc]initWithDictionary:Notification.userInfo];
    if ([Notification.userInfo[@"action"] isEqualToString:@"NEW_ORDER"]) {
        
        NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
        [userDefalts setObject:@"NO" forKey:@"homeOrder"];
        [userDefalts synchronize];
        
        if (self.knockOrder == nil || !self.knockOrder) {
            self.knockOrder = [[CLKnockOrderViewController alloc]init];
            self.knockOrder.orderDictionary = Notification.userInfo;
            [self.view addSubview:self.knockOrder.view];
            self.knockOrder.view.tag = 10;
            [self.view bringSubviewToFront:self.knockOrder.view];
            
            [self addChildViewController:self.knockOrder];
            [self.knockOrder didMoveToParentViewController:self];
            
            NSDictionary *orderDic = Notification.userInfo[@"order"];
            self.knockOrder.certifyButton.tag = [orderDic[@"id"] integerValue];
            [self.knockOrder.certifyButton addTarget:self action:@selector(knockBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.knockOrder.cancelButton addTarget:self action:@selector(knockCancelClick) forControlEvents:UIControlEventTouchUpInside];
        }else{
//            NSLog(@"没有显示订单");
        }
        
    }
//    else if ([Notification.userInfo[@"action"] isEqualToString:@"INVITE_PARTNER"]){
////        NSLog(@"有人邀请");
//        [GFHttpTool getOrderDetailOrderId:[Notification.userInfo[@"order"] integerValue] success:^(id responseObject) {
//            
////            NSLog(@"--拉取订单详情--responseObject----%@---",responseObject); 
//            
//            
//            
//            
//            NSDictionary *dictionary = Notification.userInfo[@"owner"];
//            NSDictionary *orderDictionary = responseObject[@"data"];
//            NSArray *skillArray = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
//            NSString *orderDetail = [NSString stringWithFormat:@"邀请你参与%@的订单，订单号%@",skillArray[[orderDictionary[@"orderType"] integerValue] - 1],orderDictionary[@"orderNum"]];
//            GFAlertView *alertView = [[GFAlertView alloc]initWithHeadImageURL:dictionary[@"avatar"] name:dictionary[@"name"] mark:[dictionary[@"starRate"] floatValue] orderNumber:[dictionary[@"unpaidOrders"] integerValue] goodNumber:1.0 order:orderDetail];
//            [alertView.okBut addTarget:self action:@selector(OrderDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:alertView];
//            
//            _inviteDictionary = [[NSDictionary alloc]initWithDictionary:orderDictionary];
//            
//        } failure:^(NSError *error) {
//            
////            NSLog(@"----拉取失败－－－%@--",error);
//            
//        }];
//        
////        NSLog(@"-----Notification.userInfo----%@--",Notification.userInfo);
//        
//    
//    }
    else{
        
        [self headRefresh];
    }
}


#pragma mark - 收到推送消息查看邀请订单详情
- (void)OrderDetailBtnClick{

//    NSLog(@"----orderDic--%@--",_inviteDictionary);
    CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
    NSDictionary *orderDic = _inviteDictionary;
    orderDetail.orderId = orderDic[@"id"];
//    orderDetail.orderNumber = orderDic[@"orderNum"];
    orderDetail.customerLat = orderDic[@"positionLat"];
    orderDetail.customerLon = orderDic[@"positionLon"];
    orderDetail.orderPhotoURL = [NSString stringWithFormat:@"%@%@",BaseHttp,orderDic[@"photo"]];
    if (![orderDic[@"remark"]isKindOfClass:[NSNull class]]) {
        orderDetail.remark = orderDic[@"remark"];
    }else{
        orderDetail.remark = @"";
    }
    
    orderDetail.mainTechId = @"2";
    NSDictionary *mainTechDictionary = _inviteDictionary[@"mainTech"];
    orderDetail.secondId = mainTechDictionary[@"name"];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDic[@"orderTime"] doubleValue]/1000];
    orderDetail.orderTime = [formatter stringFromDate:date];
    
    orderDetail.action = @"SEND_INVITATION";
    orderDetail.orderType = orderDic[@"orderType"];
    
    NSDictionary *cooperatorDictionary = orderDic[@"cooperator"];
    orderDetail.cooperatorName = cooperatorDictionary[@"corporationName"];
    orderDetail.cooperatorAddress = cooperatorDictionary[@"address"];
    orderDetail.cooperatorFullname = cooperatorDictionary[@"fullname"];
    
//    NSLog(@"---orderDetail.remark----%@---%@--",_inviteDictionary[@"action"],orderDetail.customerLon);
    [self.navigationController pushViewController:orderDetail animated:YES];
}


#pragma mark - 移走推送订单
- (void)knockCancelClick{
     self.knockOrder = nil;
}

#pragma mark - 立即抢单
- (void)knockBtnClick:(UIButton *)button{
    
    [GFHttpTool postOrderId:button.tag Success:^(NSDictionary *responseObject) {
        
//        NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"status"]integerValue] == 1) {
            
            [[[button superview] superview]removeFromSuperview];
            self.knockOrder = nil;
            CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
            NSDictionary *dataDictionary = responseObject[@"data"];
            addSuccess.orderNum = dataDictionary[@"orderNum"];
            addSuccess.dataDictionary = _inviteDictionary;
            addSuccess.isHome = YES;
            
            addSuccess.addBlock = ^{
                _noOrderImageView.hidden = YES;
                _noOrderlabel.hidden = YES;
            };
            [self.navigationController pushViewController:addSuccess animated:NO];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
    
    }];
}



- (void)headRefresh {
    
//    _page = 1;
//    _pageSize = 4;
    
    _page = 1;
    _pageSize = 8;

    
    
    [self httpWorkForTableView];

}

- (void)footRefresh {
    if (_page == 1) {
        _page = 2;
    }
    _page = _page + 1;
    _pageSize = 4;
    
    [self httpWorkForTableView];
}



#pragma mark - 订单表格
- (void)setTableView{
    
    
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
   
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 /255.0 alpha:1];
//     __weak CLHomeOrderViewController *weakSelf = self;
//    [_tableView addInfiniteScrollingWithActionHandler:^{
//        NSLog(@"下拉");
//        weakSelf.rowNumber = 0;
//        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:weakSelf.cellModelArray.count+1 inSection:0];
//        [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        [weakSelf performSelector:@selector(after) withObject:nil afterDelay:5.0];
//    }];
//    
//   
//    [_tableView addPullToRefreshWithActionHandler:^{
//        NSLog(@"上拉");
//        [weakSelf performSelector:@selector(after) withObject:nil afterDelay:3.0];
////        _rowNumber = 4;
////        [_tableView reloadData];
//        
//    }];
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}

- (void)after{
//    [_tableView.infiniteScrollingView stopAnimating];
//    [_tableView.pullToRefreshView stopAnimating];
    _rowNumber = 30;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_cellModelArray.count+1 inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
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

        return 140;
    }
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取消选择状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CLHomeTableViewCell *cell = (CLHomeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    NSString *cellID = cell.reuseIdentifier;
//    NSLog(@"单元格ID＝＝＝＝＝%@", cellID);
    
    CLHomeOrderCellModel *cellModel = _cellModelArray[indexPath.row - 1];
    
    CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
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
    [self.navigationController pushViewController:orderDetail animated:YES];
    /*
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"orderId"] = cellModel.orderId;
    [GFHttpTool oederDDGetWithParameters:mDic success:^(id responseObject) {
        
        NSLog(@"+++++++++%@", responseObject);
        
        if([responseObject[@"status"] integerValue] == 1){
            
            NSDictionary *messageDic = responseObject[@"message"];
            
            CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
            // 开始时间
            if([messageDic[@"startTime"] isKindOfClass:[NSNull class]]) {
                
                orderDetail.startTime = @"未开始";
            }else {
                
                orderDetail.startTime = messageDic[@"startTime"];
            }
            
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
            orderDetail.cooperatorAddress = messageDic[@"address"];
            orderDetail.cooperatorFullname = cellModel.cooperatorFullname;
            orderDetail.model = cellModel;
            
            [self.navigationController pushViewController:orderDetail animated:YES];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"-----%@", error);
    }];
     */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
        }
        return cell;
    }else{
        if (indexPath.row <= _cellModelArray.count) {
            CLHomeOrderCellModel *cellModer = _cellModelArray[indexPath.row-1];
            
            static NSString *kaishigongzuoCell = @"kaishigongzuo";
            static NSString *jinrudingdanCell = @"jinrudingdan";
            
            if ([cellModer.status isEqualToString:@"IN_PROGRESS"] || [cellModer.status isEqualToString:@"SIGNED_IN"] || [cellModer.status isEqualToString:@"AT_WORK"]) {
                
                CLHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jinrudingdanCell];
                if (cell == nil) {
                    cell = [[CLHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jinrudingdanCell];
                    [cell initWithOrder];
                }
                
                
                
                
                cell.orderButton.tag = indexPath.row + 1;
//                cell.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号%@",cellModer.orderNumber];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
                NSDate *yuyueDate = [formatter dateFromString:cellModer.orderTime];
                NSInteger timeCha = (NSInteger)[yuyueDate timeIntervalSince1970] - (NSInteger)[[NSDate date] timeIntervalSince1970];
//                NSLog(@"-----+++%ld", timeCha);
//                [cell.orderNumberLabel setTitle:[NSString stringWithFormat:@"订单编号%@",cellModer.orderNumber] forState:UIControlStateNormal];
//                [cell.orderNumberLabel setImage:nil forState:UIControlStateNormal];
                if(timeCha < 3600 && timeCha > 0) {
                
                    [cell.orderNumberLabel setTitle:[NSString stringWithFormat:@"  订单编号：%@",cellModer.orderNumber] forState:UIControlStateNormal];
                    [cell.orderNumberLabel setImage:[UIImage imageNamed:@"jingbao"] forState:UIControlStateNormal];
                }else {
                    
                    [cell.orderNumberLabel setTitle:[NSString stringWithFormat:@"订单编号：%@",cellModer.orderNumber] forState:UIControlStateNormal];
                    [cell.orderNumberLabel setImage:nil forState:UIControlStateNormal];
                }
                cell.timeLabel.text = [NSString stringWithFormat:@"预约施工时间：%@",cellModer.orderTime];
                cell.orderTypeLabel.text = cellModer.orderType;
                cell.orderTypeLabelText = cellModer.orderType;
                [cell.orderButton setTitle:@"进入订单" forState:UIControlStateNormal];
                [cell.orderButton addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
            }else {
            
                CLHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kaishigongzuoCell];
                if (cell == nil) {
                    cell = [[CLHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kaishigongzuoCell];
                    [cell initWithOrder];
                }
                
                cell.orderButton.tag = indexPath.row + 1;
//                cell.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号%@",cellModer.orderNumber];
//                [cell.orderNumberLabel setTitle:[NSString stringWithFormat:@"订单编号%@",cellModer.orderNumber] forState:UIControlStateNormal];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
                NSDate *yuyueDate = [formatter dateFromString:cellModer.orderTime];
                NSInteger timeCha = (NSInteger)[yuyueDate timeIntervalSince1970] - (NSInteger)[[NSDate date] timeIntervalSince1970];
//                NSLog(@"-----+++%ld", timeCha);
                if(timeCha < 3600 && timeCha > 0) {
                    
                    [cell.orderNumberLabel setTitle:[NSString stringWithFormat:@"  订单编号：%@",cellModer.orderNumber] forState:UIControlStateNormal];
                    [cell.orderNumberLabel setImage:[UIImage imageNamed:@"jingbao"] forState:UIControlStateNormal];
                }else {
                    
                    [cell.orderNumberLabel setTitle:[NSString stringWithFormat:@"订单编号：%@",cellModer.orderNumber] forState:UIControlStateNormal];
                    [cell.orderNumberLabel setImage:nil forState:UIControlStateNormal];
                }
                cell.timeLabel.text = [NSString stringWithFormat:@"预约施工时间：%@",cellModer.orderTime];
                cell.orderTypeLabel.text = cellModer.orderType;
                cell.orderTypeLabelText = cellModer.orderType;
                [cell.orderButton setTitle:@"开始工作" forState:UIControlStateNormal];
                [cell.orderButton addTarget:self action:@selector(workBegin:) forControlEvents:UIControlEventTouchUpInside];
                
                
                return cell;
            }
        }
    };
     
    
    return nil;
}

#pragma mark - 进入订单的按钮点击方法
- (void)orderBtnClick:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"进入订单"]) {
        if (button.tag - 2 < _cellModelArray.count) {
            CLHomeOrderCellModel *cellModel = _cellModelArray[button.tag-2];
            NSString *statusStr = cellModel.status;
            
            if([statusStr isEqualToString:@"IN_PROGRESS"]) {
                // 订单已进入施工环节 跳转到“签到页面”
                CLSigninViewController *signinView = [[CLSigninViewController alloc]init];
                signinView.customerLat = cellModel.customerLat;
                signinView.customerLon = cellModel.customerLon;
                signinView.orderId = cellModel.orderId;
                signinView.orderType = cellModel.orderType;
                signinView.startTime = cellModel.startTime;
                signinView.orderNumber = cellModel.orderNumber;
                signinView.model = cellModel;
                [self.navigationController pushViewController:signinView animated:YES];
            }else if([statusStr isEqualToString:@"SIGNED_IN"]) {
                // 已经签到  跳转到“上传施工前照片页面”
                CLWorkBeforeViewController *workBefore = [[CLWorkBeforeViewController alloc]init];
                workBefore.orderId = cellModel.orderId;
                workBefore.orderType = cellModel.orderType;
                workBefore.startTime = cellModel.startTime;
                workBefore.orderNumber = cellModel.orderNumber;
                workBefore.model = cellModel;
                [self.navigationController pushViewController:workBefore animated:YES];
            }else if([statusStr isEqualToString:@"AT_WORK"]) {
                // 签到后  跳转到“完成工作页面”
                CLWorkOverViewController *workOver = [[CLWorkOverViewController alloc]init];
                workOver.startTime = cellModel.startTime;
                //                        NSLog(@"---workOver---%@--",self.navigationController);
                workOver.orderId = cellModel.orderId;
                workOver.orderType = cellModel.orderType;
                workOver.orderNumber = cellModel.orderNumber;
                workOver.model = cellModel;
                [self.navigationController pushViewController:workOver animated:YES];
            }
        }else{
            [self headRefresh];
        }
    }
}


#pragma mark - 开始工作的按钮点击方法
- (void)workBegin:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"开始工作"]) {
        
        CLHomeOrderCellModel *cellModel = _cellModelArray[button.tag-2];
        
        CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
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
        orderDetail.model = cellModel;
        
        [self.navigationController pushViewController:orderDetail animated:YES];
        /*
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        mDic[@"orderId"] = cellModel.orderId;
        [GFHttpTool oederDDGetWithParameters:mDic success:^(id responseObject) {
            
            NSLog(@"+++++++++%@", responseObject);
            
            if([responseObject[@"status"] integerValue] == 1){
            
                NSDictionary *messageDic = responseObject[@"message"];
                
//                CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
                // 开始时间
                if([messageDic[@"startTime"] isKindOfClass:[NSNull class]]) {
                    
                    orderDetail.startTime = @"未开始";
                }else {
                    
                    orderDetail.startTime = messageDic[@"startTime"];
                }
                
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
                orderDetail.cooperatorAddress = messageDic[@"address"];
                orderDetail.cooperatorFullname = cellModel.cooperatorFullname;
                orderDetail.model = cellModel;
                
                
                [self.navigationController pushViewController:orderDetail animated:YES];
            }
            
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"-----%@", error);
        }];
         
         */
    }

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
    
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"waitOrder" withLeftImgHightName:@"waitOrder" withRightImgName:@"person" withRightImgHightName:@"personClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightBut addTarget:_navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
 
//    navView.hidden = YES;
}

-(void)backBtnClick{
    
//    [self receiveNotification:nil];

    GFOrderForWaitViewController *orderForWait = [[GFOrderForWaitViewController alloc]init];
    [self.navigationController pushViewController:orderForWait animated:YES];

//    [self knockBtnClick:nil];
    
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
