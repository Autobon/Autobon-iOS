//
//  GFBillDetailsViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFBillDetailsViewController.h"
#import "GFBillDetailsTableViewCell.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFHttpTool.h"

#import "MJRefresh.h"

#import "GFBillModel.h"
#import "GFTipView.h"
#import "CLBillTableViewCellModel.h"
#import "UIImageView+WebCache.h"


@interface GFBillDetailsViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    

    NSInteger _page;
    NSInteger _pageSize;
    
    NSMutableArray *_billDetailsArray;
    
    
    CGFloat _cellhh;

}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSString *userId;

@end

@implementation GFBillDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _billDetailsArray = [[NSMutableArray alloc]init];
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"账单" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    _page = 1;
    _pageSize = 4;
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableview.header beginRefreshing];
//    [self.tableview.footer beginRefreshing];
    
    
   
    
    
}

- (void)headRefresh {
    
//    NSLog(@"脑袋刷新");
    
    _page = 1;
    _pageSize = 4;
    _billDetailsArray = [[NSMutableArray alloc]init];
    [self http];
    
    
}

- (void)footRefresh {
    if (_page == 1) {
        _page = 2;
    }
//    NSLog(@"大脚刷新");
    _page = _page+1;
    _pageSize = 2;
    [self http];
    
}

- (void)http {

    _tableview.userInteractionEnabled = NO;
//    NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/bill/order";
//    NSString *url = [NSString stringWithFormat:@"http://121.40.157.200:12345/api/mobile/technician/bill/%@/order", self.model.billId];
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    parDic[@"billd"] = self.model.billId;
    parDic[@"page"] = @(_page);
    parDic[@"pageSize"] = @(_pageSize);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WorkItemDic" ofType:@"plist"];
    NSDictionary *itemDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    [GFHttpTool billDetailsGetWithParameters:parDic success:^(id responseObject) {
        
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSArray *listArray = dataDictionary[@"list"];
            if (listArray.count == 0 && _billDetailsArray.count > 0) {
                [self addAlertView:@"已加载全部"];
            }
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSLog(@"----listDictionary---obj--%@--",obj);
                CLBillTableViewCellModel *cellModel = [[CLBillTableViewCellModel alloc]init];
                cellModel.orderNumber = obj[@"orderNum"];
                cellModel.orderImage = obj[@"photo"];
                
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"finishTime"] floatValue]/1000];
                cellModel.orderTime = [formatter stringFromDate:date];
                if ([obj[@"secondTech"]isKindOfClass:[NSNull class]]) {
                    NSDictionary *mainConstructDictionary = obj[@"mainConstruct"];
                    cellModel.orderPay = [NSString stringWithFormat:@"￥%@",mainConstructDictionary[@"payment"]];
                    if ([mainConstructDictionary[@"workItems"]isKindOfClass:[NSNull class]]) {
                        cellModel.orderItem = @"美容清洁";
                    }else{
                        cellModel.orderItem = mainConstructDictionary[@"workItems"];
                        
                        NSArray *strArr = [cellModel.orderItem componentsSeparatedByString:@","];
                        NSString *workItemsStr = @"";
                        for(NSString *str in strArr) {
                            if(workItemsStr.length == 0) {
                                workItemsStr = [NSString stringWithFormat:@"%@", itemDic[str]];
                            }else {
                                workItemsStr = [NSString stringWithFormat:@"%@,%@", workItemsStr, itemDic[str]];
                            }
                        }
                        cellModel.orderItem = workItemsStr;
                    }
                }else{
                    NSDictionary *secondTechDictionary = obj[@"secondTech"];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    NSString *userId = [userDefaults objectForKey:@"userId"];
                    if ([userId integerValue] == [secondTechDictionary[@"id"] integerValue]) {
                        NSDictionary *secondConstructDictionary = obj[@"secondConstruct"];
                        cellModel.orderPay = [NSString stringWithFormat:@"￥%@",secondConstructDictionary[@"payment"]];
                        if ([secondConstructDictionary[@"workItems"]isKindOfClass:[NSNull class]]) {
                            cellModel.orderItem = @"美容清洁";
                        }else{
                            cellModel.orderItem = secondConstructDictionary[@"workItems"];
                            
                            NSArray *strArr = [cellModel.orderItem componentsSeparatedByString:@","];
                            NSString *workItemsStr = @"";
                            for(NSString *str in strArr) {
                                if(workItemsStr.length == 0) {
                                    workItemsStr = [NSString stringWithFormat:@"%@", itemDic[str]];
                                }else {
                                    workItemsStr = [NSString stringWithFormat:@"%@,%@", workItemsStr, itemDic[str]];
                                }
                            }
                            cellModel.orderItem = workItemsStr;
                        }
                    }else{
                        NSDictionary *mainConstructDictionary = obj[@"mainConstruct"];
                        cellModel.orderPay = [NSString stringWithFormat:@"￥%@",mainConstructDictionary[@"payment"]];
                        if ([mainConstructDictionary[@"workItems"]isKindOfClass:[NSNull class]]) {
                            cellModel.orderItem = @"美容清洁";
                        }else{
                            cellModel.orderItem = mainConstructDictionary[@"workItems"];
                            
                            NSArray *strArr = [cellModel.orderItem componentsSeparatedByString:@","];
                            NSString *workItemsStr = @"";
                            for(NSString *str in strArr) {
                                if(workItemsStr.length == 0) {
                                    workItemsStr = [NSString stringWithFormat:@"%@", itemDic[str]];
                                }else {
                                    workItemsStr = [NSString stringWithFormat:@"%@,%@", workItemsStr, itemDic[str]];
                                }
                            }
                            cellModel.orderItem = workItemsStr;
                        }
                    }
                }
                
                
                
                [_billDetailsArray addObject:cellModel];
            }];
        }
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        [_tableview reloadData];
        _tableview.userInteractionEnabled = YES;
//>>>>>>> CLmaster
    } failure:^(NSError *error) {
        
        _tableview.userInteractionEnabled = YES;
//        [self addAlertView:@"请求失败"];
    }];
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return _billDetailsArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    GFBillDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFBillDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CLBillTableViewCellModel *model = _billDetailsArray[indexPath.row];
    cell.numberLab.text = [NSString stringWithFormat:@"订单编号%@",model.orderNumber];
    cell.moneyLab.text = model.orderPay;
    extern NSString* const URLHOST;
    [cell.photoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLHOST,model.orderImage]] placeholderImage:[UIImage imageNamed:@"orderImage"]];
    cell.timeLab.text = [NSString stringWithFormat:@"施工时间：%@",model.orderTime];
    NSString *beizhuStr = [NSString stringWithFormat:@"%@", model.orderItem];
    NSMutableDictionary *bezhuDic = [[NSMutableDictionary alloc] init];
    bezhuDic[NSFontAttributeName] = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    bezhuDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect beizhuRect = [beizhuStr boundingRectWithSize:CGSizeMake(kWidth - kWidth * 0.056 * 2 - kWidth * 0.21, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:bezhuDic context:nil];
    cell.placeLab.text = beizhuStr;
    cell.placeLabH = beizhuRect.size.height;
    cell.placeLab.frame = CGRectMake(cell.placeLabX, cell.placeLabY, cell.placeLabW, cell.placeLabH);
    _cellhh = CGRectGetMaxY(cell.placeLab.frame) + 10.5 / 568.0 * kHeight;
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = _cellhh;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = kHeight * 0.0183;
    cell.baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH);
    cell.downLine.frame = CGRectMake(0, baseViewH - 1, kWidth, 1);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    return _cellhh + kHeight * 0.0183;
}
#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}
- (void)leftButClick {
    
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
