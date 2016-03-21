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



@interface GFBillDetailsViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    NSInteger page;
    NSInteger pageSize;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation GFBillDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    page = 1;
    pageSize = 1;
    
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
    
    NSLog(@"脑袋刷新");
    
    [self http];
    
    [self.tableview.header endRefreshing];
    
}

- (void)footRefresh {
    
    NSLog(@"大脚刷新");
    
    [self.tableview.footer endRefreshing];
}

- (void)http {

//    NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/bill/order";
    NSString *url = [NSString stringWithFormat:@"http://121.40.157.200:12345/api/mobile/technician/bill/%@/order", self.model.billId];
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    parDic[@"billd"] = self.model.billId;
    parDic[@"page"] = @"1";
    parDic[@"pageSize"] = @"1";
    [GFHttpTool billDetailsGet:url parameters:parDic success:^(id responseObject) {
        
        NSLog(@"\n请求成功！！！！\n%@\n\n", responseObject);
        
    } failure:^(NSError *error) {
        
        
        [self addAlertView:@"请求失败"];
    }];
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return 20;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    GFBillDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFBillDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    return kHeight * 0.464 + kHeight * 0.0183;
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
