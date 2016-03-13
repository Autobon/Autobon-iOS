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



@interface CLHomeOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    UITableView *_tableView;
    NSInteger _rowNumber;
    UILabel *_noOrderlabel;
    UIImageView *_noOrderImageView;
    NSDictionary *_inviteDictionary;
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
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    [userDefalts setObject:@"YES" forKey:@"homeOrder"];
    [userDefalts synchronize];
}

- (void)viewWillDisappear:(BOOL)animated{
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    [userDefalts setObject:@"NO" forKey:@"homeOrder"];
    [userDefalts synchronize];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self headRefresh];
}

- (void)viewDidLoad {
    
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"到这里了--%@--",NSHomeDirectory());
    
    _rowNumber = 30;
    
    

    
    
    
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
    
    [self httpWorkForTableView];
//
//
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
//    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableView.header beginRefreshing];
//    [self.tableView.footer beginRefreshing];
    
    
    [self NSNotificationCenter];
    
}



- (void)httpWorkForTableView{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [GFHttpTool getOrderListSuccess:^(NSDictionary *responseObject) {
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDit = responseObject[@"data"];
            NSArray *dataArray = dataDit[@"list"];
            NSLog(@"---%@--",dataArray);
            _cellModelArray = [[NSMutableArray alloc]init];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"---obj---%@--",obj);
                CLHomeOrderCellModel *cellModel = [[CLHomeOrderCellModel alloc]init];
                cellModel.orderId = obj[@"id"];
                cellModel.orderNumber = obj[@"orderNum"];
                //                cellModel.orderTime = [obj[@"orderTime"] integerValue];
                cellModel.orderType = obj[@"orderType"];
                cellModel.orderPhotoURL = obj[@"photo"];
                cellModel.customerLat = obj[@"positionLat"];
                cellModel.customerLon = obj[@"positionLon"];
                cellModel.remark = obj[@"remark"];
                cellModel.status = obj[@"status"];
                NSDictionary *mainTechDictionary = obj[@"mainTech"];
                cellModel.mainTechId = mainTechDictionary[@"id"];
                if ([[userDefaults objectForKey:@"userId"] integerValue] == [cellModel.mainTechId integerValue]) {
                    NSLog(@"我是主技师");
                    if (![obj[@"mainConstruct"] isKindOfClass:[NSNull class]]) {
                        NSDictionary *mainDictionary = obj[@"mainConstruct"];
                        cellModel.startTime = mainDictionary[@"startTime"];
                        cellModel.signinTime = mainDictionary[@"signinTime"];
                        cellModel.beforePhotos = mainDictionary[@"beforePhotos"];
                        cellModel.afterPhotos = mainDictionary[@"afterPhotos"];
                        
                    }
                    if (![obj[@"secondTech"] isKindOfClass:[NSNull class]]) {
                        NSLog(@"有小伙伴");
                        NSDictionary *secondDictionary = obj[@"secondTech"];
                        cellModel.mateName = secondDictionary[@"name"];
                    }
                    
                }else{
                    NSLog(@"我是次技师");
                    NSDictionary *secondDictionary = obj[@"mainTech"];
                    cellModel.mateName = secondDictionary[@"name"];
                    if (![obj[@"secondConstruct"] isKindOfClass:[NSNull class]]) {
                        NSDictionary *mainDictionary = obj[@"secondConstruct"];
                        cellModel.startTime = mainDictionary[@"startTime"];
                        cellModel.signinTime = mainDictionary[@"signinTime"];
                        cellModel.beforePhotos = mainDictionary[@"beforePhotos"];
                        cellModel.afterPhotos = mainDictionary[@"afterPhotos"];
                    }
                }
                
//                cellModel.secondTechId = obj[@"secondTechId"];
                [_cellModelArray addObject:cellModel];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"orderTime"] integerValue]/1000];
                cellModel.orderTime = [formatter stringFromDate:date];
                NSLog(@"date1:%@",cellModel.orderTime);
                
                
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
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 注册通知中心
- (void)NSNotificationCenter{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"NEW_ORDER" object:nil];
}
#pragma mark - 接受通知消息
-(void)receiveNotification:(NSNotification *)Notification
{
    NSLog(@"receiveNotification---%@--",Notification.userInfo);
    
    
   
//    CLKnockOrderViewController *knockOrder = [[CLKnockOrderViewController alloc]init];
//    [self.view addSubview:knockOrder.view];
//    [self addChildViewController:knockOrder];
//    [knockOrder didMoveToParentViewController:self];
    
    if ([Notification.userInfo[@"action"] isEqualToString:@"NEW_ORDER"]) {
        CLKnockOrderViewController *knockOrder = [[CLKnockOrderViewController alloc]init];
        knockOrder.orderDictionary = Notification.userInfo;
        //    [self.navigationController pushViewController:knockOrder animated:YES];
        
        [self.view addSubview:knockOrder.view];
        
        [self addChildViewController:knockOrder];
        [knockOrder didMoveToParentViewController:self];
        
        NSDictionary *orderDic = Notification.userInfo[@"order"];
        knockOrder.certifyButton.tag = [orderDic[@"id"] integerValue];
        [knockOrder.certifyButton addTarget:self action:@selector(knockBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([Notification.userInfo[@"action"] isEqualToString:@"INVITE_PARTNER"]){
        NSLog(@"有人邀请");
        NSDictionary *dictionary = Notification.userInfo[@"owner"];
        NSDictionary *orderDictionary = Notification.userInfo[@"order"];
        NSArray *skillArray = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
        NSString *orderDetail = [NSString stringWithFormat:@"邀请你参与%@的订单，订单号%@",skillArray[[orderDictionary[@"orderType"] integerValue] - 1],orderDictionary[@"orderNum"]];
        GFAlertView *alertView = [[GFAlertView alloc]initWithHeadImageURL:dictionary[@"avatar"] name:dictionary[@"name"] mark:1.2 orderNumber:2 goodNumber:1.0 order:orderDetail];
        [alertView.okBut addTarget:self action:@selector(OrderDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:alertView];
        _inviteDictionary = [[NSDictionary alloc]initWithDictionary:Notification.userInfo];

    }
    
    
    
   
}


#pragma mark - 收到推送消息查看邀请订单详情
- (void)OrderDetailBtnClick{

    CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
    NSDictionary *orderDic = _inviteDictionary[@"order"];
    orderDetail.orderId = orderDic[@"id"];
    orderDetail.customerLat = orderDic[@"positionLat"];
    orderDetail.customerLon = orderDic[@"positionLon"];
    orderDetail.orderPhotoURL = orderDic[@"photo"];
    orderDetail.remark = orderDic[@"remark"];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDic[@"orderTime"] integerValue]/1000];
    orderDetail.orderTime = [formatter stringFromDate:date];
    
    orderDetail.action = _inviteDictionary[@"action"];
    
    NSLog(@"---orderDetail.remark%@---%@--",orderDetail.customerLat,orderDetail.customerLon);
    [self.navigationController pushViewController:orderDetail animated:YES];
}


#pragma mark - 立即抢单
- (void)knockBtnClick:(UIButton *)button{

    
//    CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
//    addSuccess.addBlock = ^{
//        _noOrderImageView.hidden = YES;
//        _noOrderlabel.hidden = YES;
//        
//        [self headRefresh];
//    };
//    [self.navigationController pushViewController:addSuccess animated:NO];

    
    
    [GFHttpTool postOrderId:button.tag Success:^(NSDictionary *responseObject) {
        
        NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"result"]integerValue] == 1) {
            
            [[[button superview] superview]removeFromSuperview];
            
            CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
            NSDictionary *dataDictionary = responseObject[@"data"];
            addSuccess.orderNum = dataDictionary[@"orderNum"];
            addSuccess.dataDictionary = dataDictionary;
            
            
            
            addSuccess.addBlock = ^{
                _noOrderImageView.hidden = YES;
                _noOrderlabel.hidden = YES;

//                [self headRefresh];
            };
            [self.navigationController pushViewController:addSuccess animated:NO];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"----抢单结果-222-%@--",error);
    }];
    
    
    
}



- (void)headRefresh {
    
    NSLog(@"脑袋刷新");
    
    
    [self httpWorkForTableView];
}

- (void)footRefresh {
    
    NSLog(@"大脚刷新");
    
    [self.tableView.footer endRefreshing];
}



#pragma mark - 订单表格
- (void)setTableView{
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
   
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     __weak CLHomeOrderViewController *weakSelf = self;
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
        return 85;
    }else{
        return 75 + [UIScreen mainScreen].bounds.size.width*5/12;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dianjifangfa");
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
        if ([cellModer.status isEqualToString:@"IN_PROGRESS"]) {
            [cell.orderButton setTitle:@"进入订单" forState:UIControlStateNormal];
            [cell.orderButton addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [cell.orderButton setTitle:@"开始工作" forState:UIControlStateNormal];
            [cell.orderButton addTarget:self action:@selector(workBegin:) forControlEvents:UIControlEventTouchUpInside];

        }
//        cell.contentView.userInteractionEnabled = YES;
//        [cell.orderButton addTarget:self action:@selector(workBegin:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    };
     
    
    return nil;
}

#pragma mark - 进入订单的按钮点击方法
- (void)orderBtnClick:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"进入订单"]) {
        if (button.tag - 2 < _cellModelArray.count) {
            CLHomeOrderCellModel *cellModel = _cellModelArray[button.tag-2];
            
            
            if (cellModel.startTime) {
                // 已经开始
                if ([cellModel.signinTime isKindOfClass:[NSNull class]]) {
                    NSLog(@"未签到");
                    CLSigninViewController *signinView = [[CLSigninViewController alloc]init];
                    signinView.customerLat = cellModel.customerLat;
                    signinView.customerLon = cellModel.customerLon;
                    signinView.orderId = cellModel.orderId;
                    signinView.orderType = cellModel.orderType;
                    signinView.startTime = cellModel.startTime;
                    [self.navigationController pushViewController:signinView animated:YES];
                    
                    
                    
                }else if ([cellModel.beforePhotos isKindOfClass:[NSNull class]]){
                    CLWorkBeforeViewController *workBefore = [[CLWorkBeforeViewController alloc]init];
                    workBefore.orderId = cellModel.orderId;
                    workBefore.orderType = cellModel.orderType;
                    workBefore.startTime = cellModel.startTime;
                    [self.navigationController pushViewController:workBefore animated:YES];
                    
                    NSLog(@"未上传开始前照片");
                }else if ([cellModel.afterPhotos isKindOfClass:[NSNull class]]){
                    if ([cellModel.orderType integerValue] == 4) {
                        
                        CLCleanWorkViewController *cleanWork = [[CLCleanWorkViewController alloc]init];
                        cleanWork.orderId = cellModel.orderId;
                        cleanWork.startTime = cellModel.startTime;
                        [self.navigationController pushViewController:cleanWork animated:YES];
                        
                    }else{
                        CLWorkOverViewController *workOver = [[CLWorkOverViewController alloc]init];
                        workOver.startTime = cellModel.startTime;
                        NSLog(@"---workOver---%@--",workOver.startTime);
                        workOver.orderId = cellModel.orderId;
                        workOver.orderType = cellModel.orderType;
                        
                        [self.navigationController pushViewController:workOver animated:YES];
                    }
                    NSLog(@"未上传结束时照片");
                }else{
                    [self addAlertView:@"等待小伙伴提交"];
                }
                
            }else{
                // 未开始，判断有无小伙伴
                
                CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
                orderDetail.orderId = cellModel.orderId;
                orderDetail.customerLat = cellModel.customerLat;
                orderDetail.customerLon = cellModel.customerLon;
                orderDetail.orderPhotoURL = cellModel.orderPhotoURL;
                orderDetail.orderTime = cellModel.orderTime;
                orderDetail.remark = cellModel.remark;
                orderDetail.orderType = cellModel.orderType;
                
                NSLog(@"我还没有开始啊--%@--",cellModel.mateName);
                if (cellModel.mateName) {
                    // 小伙伴存在
                    orderDetail.action = @"INVITATION_ACCEPTED";
                    orderDetail.secondId = cellModel.mateName;
                    [self.navigationController pushViewController:orderDetail animated:YES];
                    
                }else{
                    // 小伙伴不存在，可以随便邀请
                    NSLog(@"---xiaohuoban-");
                }
                
            }
        }else{
            [self headRefresh];
        }
    }
        
        
        
        
        
        
//        CLOrderDetailViewController *orderDetail = [[CLOrderDetailViewController alloc]init];
//        orderDetail.orderId = cellModel.orderId;
//        
//        [GFHttpTool getOrderDetailOrderId:[cellModel.orderId integerValue] success:^(NSDictionary *responseObject) {
//            NSLog(@"responseObject--%@--",responseObject);
//            NSDictionary *dataDictionary = responseObject[@"data"];
//            NSDictionary *constructionDict = dataDictionary[@"construction"];
//            NSLog(@"---constructionDict--%@",constructionDict);
//            if ([constructionDict isKindOfClass:[NSNull class]]) {
//                NSLog(@"小伙伴已开始工作");
//                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                NSString *userId = [userDefaults objectForKey:@"userId"];
//                NSDictionary *mainTechDictionary = dataDictionary[@"mainTech"];
//                NSDictionary *secondTechDictionary = dataDictionary[@"secondTech"];
//                orderDetail.customerLat = cellModel.customerLat;
//                orderDetail.customerLon = cellModel.customerLon;
//                orderDetail.orderPhotoURL = cellModel.orderPhotoURL;
//                orderDetail.orderTime = cellModel.orderTime;
//                orderDetail.remark = cellModel.remark;
//                orderDetail.orderType = cellModel.orderType;
//                orderDetail.action = @"INVITATION_ACCEPTED";
//                if ([userId integerValue] == [mainTechDictionary[@"id"] integerValue]) {
//                    NSLog(@"我是主技师，小伙伴已开始");
//                    orderDetail.secondId = secondTechDictionary[@"name"];
//                    
//                    
//                }else{
//                    NSLog(@"我是副机师，小伙伴已开始");
//                    
//                    orderDetail.secondId = mainTechDictionary[@"name"];
//                }
//                [self.navigationController pushViewController:orderDetail animated:YES];
//                
//            }else{
//                NSLog(@"已开始工作，签到，上传照片");
//                
//                NSDictionary *orderDictionary = dataDictionary[@"order"];
//               
//                
//                if ([constructionDict[@"signinTime"] isKindOfClass:[NSNull class]]) {
//                    NSLog(@"未签到");
//                    CLSigninViewController *signinView = [[CLSigninViewController alloc]init];
//                    signinView.customerLat = orderDictionary[@"positionLat"];
//                    signinView.customerLon = orderDictionary[@"positionLon"];
//                    signinView.orderId = orderDictionary[@"id"];
//                    signinView.orderType = orderDictionary[@"orderType"];
//                    signinView.startTime = constructionDict[@"startTime"];
//                    [self.navigationController pushViewController:signinView animated:YES];
//                    
//                    
//                    
//                }else if ([constructionDict[@"beforePhotos"] isKindOfClass:[NSNull class]]){
//                    CLWorkBeforeViewController *workBefore = [[CLWorkBeforeViewController alloc]init];
//                    workBefore.orderId = orderDictionary[@"id"];
//                    workBefore.orderType = orderDictionary[@"orderType"];
//                    workBefore.startTime = constructionDict[@"startTime"];
//                    [self.navigationController pushViewController:workBefore animated:YES];
//                    
//                    NSLog(@"未上传开始前照片");
//                }else if ([constructionDict[@"afterPhotos"] isKindOfClass:[NSNull class]]){
//                    if ([orderDictionary[@"orderType"] integerValue] == 4) {
//                        
//                        CLCleanWorkViewController *cleanWork = [[CLCleanWorkViewController alloc]init];
//                        cleanWork.orderId = orderDictionary[@"id"];
//                        cleanWork.startTime = constructionDict[@"startTime"];
//                        [self.navigationController pushViewController:cleanWork animated:YES];
//                        
//                    }else{
//                        CLWorkOverViewController *workOver = [[CLWorkOverViewController alloc]init];
//                        workOver.startTime = constructionDict[@"startTime"];
//                        NSLog(@"---workOver---%@--",workOver.startTime);
//                        workOver.orderId = orderDictionary[@"id"];
//                        workOver.orderType = orderDictionary[@"orderType"];
//                        
//                        [self.navigationController pushViewController:workOver animated:YES];
//                    }
//                    
//                    
//                    
//                    
//                    
//                    NSLog(@"未上传结束时照片");
//                }
//                
//                
//                
//            }
//            
//        } failure:^(NSError *error) {
//            
//        }];
//    }
    
    
//        CLWorkBeforeViewController *workBefore = [[CLWorkBeforeViewController alloc]init];
//        [self.navigationController pushViewController:workBefore animated:YES];

    
}


#pragma mark - 开始工作的按钮点击方法
- (void)workBegin:(UIButton *)button{
    NSLog(@"点击订单");
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
    orderDetail.mainTechId = cellModel.mainTechId;
    orderDetail.secondId = cellModel.secondTechId;
    orderDetail.orderType = cellModel.orderType;
    NSLog(@"---orderDetail.remark%@---%@--",orderDetail.customerLat,orderDetail.customerLon);
    [self.navigationController pushViewController:orderDetail animated:YES];
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
    NSLog(@"---dateString--%@---",dateString);
    
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
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
 
//    navView.hidden = YES;
}

-(void)backBtnClick{
    NSLog(@"个人信息界面");
    GFMyMessageViewController *myMsgVC = [[GFMyMessageViewController alloc] init];
    [self.navigationController pushViewController:myMsgVC animated:YES];
    
   
//    [self receiveNotification:nil];
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
