//
//  GFNewOrderViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/12/7.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFNewOrderViewController.h"
#import "GFNavigationView.h"
#import "GFNothingView.h"
#import "MJRefresh.h"
#import "GFTipView.h"
#import "GFIndentDetailsViewController.h"
#import "GFIndentTableViewCell.h"
#import "GFHttpTool.h"
#import "GFNewOrderModel.h"
#import "CLSearchOrderViewController.h"

@interface GFNewOrderViewController ()<CLSearchOrderDelegate> {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    NSInteger page;
    NSInteger pageSize;
    NSString *status;
}



@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSMutableArray *workItemArr;
@property (nonatomic, strong) GFNothingView *nothingView;

@property (nonatomic, strong) NSMutableDictionary *mDic;



@end

@implementation GFNewOrderViewController

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
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:@"" withRightImgHightName:nil withCenterTitle:@"我的订单" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView.rightBut setTitle:@"搜索  " forState:UIControlStateNormal];
    self.navView.rightBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.navView.rightBut addTarget:self action:@selector(rightSearchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)rightSearchBtnClick{
    ICLog(@"--right search button click---");
    
    CLSearchOrderViewController *searchOrderVC = [[CLSearchOrderViewController alloc]init];
    searchOrderVC.delegate = self;
    [self.navigationController pushViewController:searchOrderVC animated:YES];
    
}

- (void)searchOrderForDictionary:(NSDictionary *)dataDictionary{
    
    [self.mDic removeObjectForKey:@"license"];
    [self.mDic removeObjectForKey:@"vin"];
    
    [dataDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        self.mDic[key] = obj;
    }];
    
    
    
    [_tableview.mj_header beginRefreshing];
    
}


- (void)_setView {
    page = 1;
    pageSize = 8;
    status = @"3";
    
    self.modelArr = [[NSMutableArray alloc] init];
    self.mDic = [[NSMutableDictionary alloc] init];
    self.mDic[@"url"] = @"/technician/v2/order";
    self.mDic[@"status"] = @"3";
    
    // 负责人横条
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = 50;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = 64;
    UIView *baseView = [[UIView alloc] init];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    // 主负责人
    UIButton *mainBut = [UIButton buttonWithType:UIButtonTypeCustom];
    mainBut.frame = CGRectMake(0, 0, baseViewW / 2.0, baseViewH);
    mainBut.titleLabel.font = [UIFont boldSystemFontOfSize:14 / 320.0 * kWidth];
    [mainBut setTitle:@"主负责人" forState:UIControlStateNormal];
    [mainBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [mainBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    mainBut.selected = YES;
    [baseView addSubview:mainBut];
    [mainBut addTarget:self action:@selector(renButClick:) forControlEvents:UIControlEventTouchUpInside];
    mainBut.tag = 1000;
    mainBut.userInteractionEnabled = NO;
    // 次负责人
    UIButton *otherBut = [UIButton buttonWithType:UIButtonTypeCustom];
    otherBut.frame = CGRectMake(CGRectGetMaxX(mainBut.frame), 0, kWidth / 2.0, baseViewH);
    otherBut.titleLabel.font = [UIFont boldSystemFontOfSize:14 / 320.0 * kWidth];
    [otherBut setTitle:@"次负责人" forState:UIControlStateNormal];
    [otherBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [otherBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    [baseView addSubview:otherBut];
    [otherBut addTarget:self action:@selector(renButClick:) forControlEvents:UIControlEventTouchUpInside];
    otherBut.tag = 2000;
    // 边线
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
    vv.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:vv];
    // 下划线
    NSString *proStr = @"主负责人";
    NSMutableDictionary *proDic = [[NSMutableDictionary alloc] init];
    proDic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    proDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    CGRect proRect = [proStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:proDic context:nil];
    CGFloat lineViewW = proRect.size.width + 20;
    CGFloat lineViewH = 1.5;
    CGFloat lineViewX = (kWidth / 2.0 - lineViewW) / 2.0;
    CGFloat lineViewY = CGRectGetMaxY(baseView.frame) - lineViewH;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
    self.lineView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:self.lineView];
    
    
    
    
    // tableView视图
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + baseViewH, kWidth, kHeight - 64 - baseViewH) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(baseView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
    self.nothingView = [[GFNothingView alloc] initWithImageName:@"NoOrder" withTipString:@"暂无订单" withSubtipString:nil];
    self.nothingView.hidden = YES;
    [self.view addSubview:self.nothingView];

    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableview.mj_header beginRefreshing];
    //    [self.tableview.mj_footer beginRefreshing];
    
    
    
    
}


- (void)renButClick:(UIButton *)sender {
    
    sender.selected = YES;
    
    self.modelArr = [[NSMutableArray alloc] init];
    self.mDic = [[NSMutableDictionary alloc] init];
    
    if(sender.tag == 1000) {
        
        UIButton *but = (UIButton *)[self.view viewWithTag:2000];
        but.selected = NO;
        
        but.userInteractionEnabled = YES;
        sender.userInteractionEnabled = NO;
        self.mDic[@"status"] = @"3";
        self.mDic[@"url"] = @"/technician/v2/order";
    }else {
    
        UIButton *but = (UIButton *)[self.view viewWithTag:1000];
        but.selected = NO;
        
        but.userInteractionEnabled = YES;
        sender.userInteractionEnabled = NO;
        self.mDic[@"url"] = @"/technician/v2/partner/order";
    }
    
    CGFloat centerX = sender.center.x;
    CGPoint oriPoint = self.lineView.center;
    oriPoint.x = centerX;
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.center = oriPoint;
    }];
    
    [self.tableview.mj_header beginRefreshing];
}

- (void)httpWorkForOrder {
    
    
    self.mDic[@"page"] = @(page);
    self.mDic[@"pageSize"] = @(pageSize);
//    NSLog(@"=====%@", self.mDic);
    [GFHttpTool orderGetWithParameters:self.mDic success:^(id responseObject) {
        
        ICLog(@"====我的订单=====%@", responseObject);
        
        if([responseObject[@"status"] integerValue] == 1) {
            
            NSDictionary *messageDic = responseObject[@"message"];
            NSArray *contentArr = messageDic[@"content"];
            
            if(contentArr.count == 0 && page == 1) {
                self.nothingView.hidden = NO;
            }else {
                self.nothingView.hidden = YES;
            }
            
            for(int i=0; i<contentArr.count; i++) {
            
                GFNewOrderModel *model = [[GFNewOrderModel alloc] initWithDictionary:contentArr[i]];
//                NSLog(@"====%@", model.orderNum);
                [self.modelArr addObject:model];
            }
            
            // 判断是否加载完成
            NSInteger totalPages = [messageDic[@"totalPages"] integerValue];
            if(page >= totalPages) {
            
                [self addAlertView:@"已加载完成！"];
            }
        }else {
        
        }
//        NSLog(@"------%@", self.modelArr);
        
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
}


- (void)headRefresh {
    
    self.modelArr = [[NSMutableArray alloc] init];
    page = 1;
    [self httpWorkForOrder];
}

- (void)footRefresh {
    
    page++;
    [self httpWorkForOrder];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.modelArr.count;
//    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    GFIndentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFIndentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if(self.modelArr.count > indexPath.row) {
    
        GFNewOrderModel *model = (GFNewOrderModel *)self.modelArr[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //    return kHeight * 0.464  - kHeight * 0.2344 + kHeight * 0.0183;
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    GFNewOrderModel *model = self.modelArr[indexPath.row];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"id"] = model.orderID;
//    NSLog(@"查询字典===%@", mDic);
    [GFHttpTool orderDDGetWithParameters:mDic success:^(id responseObject) {
        
        ICLog(@"订单详情＝＝＝%@", responseObject);
        
        if([responseObject[@"status"] integerValue]) {
        
            GFNewOrderModel *model1 = [[GFNewOrderModel alloc] initWithDictionary:responseObject[@"message"]];
            GFIndentDetailsViewController *indentDeVC = [[GFIndentDetailsViewController alloc] init];
            indentDeVC.model = model1;
            [self.navigationController pushViewController:indentDeVC animated:YES];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"===%@", error);
    }];
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
