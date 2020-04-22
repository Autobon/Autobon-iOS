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
    
    self.tableview = [[UITableView alloc] init];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
    }];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableview.mj_header beginRefreshing];
}

- (void)headRefresh {
    
//    NSLog(@"脑袋刷新");
    
    _page = 1;
    _pageSize = 4;
    _billDetailsArray = [[NSMutableArray alloc]init];
    [self http];
    
    
}

- (void)footRefresh {
//    if (_page == 1) {
//        _page = 2;
//    }
//    NSLog(@"大脚刷新");
    _page = _page+1;
    _pageSize = 4;
    [self http];
    
}

- (void)http {

    _tableview.userInteractionEnabled = NO;
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    parDic[@"billd"] = self.model.billId;
    parDic[@"page"] = @(_page);
    parDic[@"pageSize"] = @(_pageSize);
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"WorkItemDic" ofType:@"plist"];
//    NSDictionary *itemDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    [GFHttpTool billDetailsGetWithParameters:parDic success:^(id responseObject) {
        
//        NSLog(@"===----====%@", responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSArray *listArray = dataDictionary[@"list"];
            if (listArray.count == 0 && _billDetailsArray.count > 0) {
                [self addAlertView:@"已加载全部"];
            }
            for(int i=0; i<listArray.count; i++) {
//                NSLog(@"----listDictionary---obj--%@--",obj);
                NSDictionary *obj = listArray[i];
                
                CLBillTableViewCellModel *cellModel = [[CLBillTableViewCellModel alloc]init];
                cellModel.orderNumber = obj[@"orderNum"];
//                cellModel.orderImage = obj[@"photo"];
                
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"createDate"] doubleValue]/1000];
                cellModel.orderTime = [formatter stringFromDate:date];
                cellModel.orderPay = [NSString stringWithFormat:@"￥%@",obj[@"payment"]];
                
                
                NSString *ss = @"";
                if(![obj[@"project1"] isKindOfClass:[NSNull class]]) {
                    
                    ss = [NSString stringWithFormat:@"%@", obj[@"project1"]];
                    if(![obj[@"project2"] isKindOfClass:[NSNull class]]) {
                    
                        ss = [NSString stringWithFormat:@"%@,%@", ss, obj[@"project2"]];
                        if(![obj[@"project3"] isKindOfClass:[NSNull class]]) {
                        
                            ss = [NSString stringWithFormat:@"%@,%@", ss, obj[@"project3"]];
                            if(![obj[@"project4"] isKindOfClass:[NSNull class]]) {
                            
                                ss = [NSString stringWithFormat:@"%@,%@", ss, obj[@"project4"]];
                            }
                        }
                    }
                }
//                NSLog(@"%@", ss);
                NSString *sss = @"";
                if([ss isEqualToString:@""]) {
                
                    sss = @"无";
                    cellModel.orderItem = [NSString stringWithFormat:@"%@", sss];

                }else {
                
                    NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁",@"安全膜",@"其他"];
                    NSString *str = [NSString stringWithFormat:@"%@", ss];
                    NSArray *arr = [str componentsSeparatedByString:@","];
                    
//                    NSLog(@"-------%@", arr);
                    if(arr.count > 0) {
                        
                        for(int i=0; i<arr.count; i++) {
                            NSInteger index = [arr[i] integerValue] - 1;
                            if (index > array.count - 1){
                                index = array.count - 1;
                            }
                            if([sss isEqualToString:@""]) {
//                                NSLog(@"----%ld", index);
                                sss = array[index];
                            }else {
                                
                                sss = [NSString stringWithFormat:@"%@,%@", sss, array[index]];
                            }
                        }
                    }
                    
                    cellModel.orderItem = [NSString stringWithFormat:@"%@", sss];
//                    if([sss isEqualToString:@""]) {
//                        
//                        sss = @"无";
//                        cellModel.orderItem = [NSString stringWithFormat:@"%@", sss];
//                    }else {
//                        
//                        cellModel.orderItem = [NSString stringWithFormat:@"%@", sss];
//                    }
                }
                
                /*
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
                */
                
                
                [_billDetailsArray addObject:cellModel];
//                NSLog(@"-%@--- -%@--%@---%@", ss, cellModel.orderNumber, sss, cellModel.orderItem);
            }
        }
        [_tableview reloadData];
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
        _tableview.userInteractionEnabled = YES;

    } failure:^(NSError *error) {
        
        _tableview.userInteractionEnabled = YES;
        
//        NSLog(@"!!!!!!!!!!!!!!%@", error);
    }];
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    NSLog(@"=====%ld", _billDetailsArray.count);
    return _billDetailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    GFBillDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFBillDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if(_billDetailsArray.count > indexPath.row) {
    
        CLBillTableViewCellModel *model = (CLBillTableViewCellModel *)_billDetailsArray[indexPath.row];
        cell.numberLab.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNumber];
        cell.moneyLab.text = model.orderPay;
        cell.timeLab.text = [NSString stringWithFormat:@"施工时间：%@",model.orderTime];
        cell.placeText = model.orderItem;
//        NSLog(@"------%@", model.orderItem);
//        NSString *beizhuStr = [NSString stringWithFormat:@"%@", model.orderItem];
//        NSMutableDictionary *bezhuDic = [[NSMutableDictionary alloc] init];
//        bezhuDic[NSFontAttributeName] = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//        bezhuDic[NSForegroundColorAttributeName] = [UIColor blackColor];
//        CGRect beizhuRect = [beizhuStr boundingRectWithSize:CGSizeMake(kWidth - kWidth * 0.056 * 2 - kWidth * 0.21, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:bezhuDic context:nil];
//        cell.placeLab.text = beizhuStr;
//        cell.placeLabH = beizhuRect.size.height;
//        cell.placeLab.frame = CGRectMake(cell.placeLabX, cell.placeLabY, cell.placeLabW, cell.placeLabH);
//        _cellhh = CGRectGetMaxY(cell.placeLab.frame) + 10.5 / 568.0 * kHeight;
//        CGFloat baseViewW = kWidth;
//        CGFloat baseViewH = _cellhh;
//        CGFloat baseViewX = 0;
//        CGFloat baseViewY = kHeight * 0.0183;
//        cell.baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH);
//        cell.downLine.frame = CGRectMake(0, baseViewH - 1, kWidth, 1);
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    return 140;
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
