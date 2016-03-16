//
//  GFBillViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFBillViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFHttpTool.h"
#import "GFBillTableViewCell.h"
#import "GFBillDetailsViewController.h"
#import "GFBillModel.h"
#import "MJRefresh.h"

@interface GFBillViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jianjv1;
    
    NSInteger page;
    NSInteger pageSize;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *timeBut;
@property (nonatomic, strong) UIButton *moneyBut;


@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) GFBillModel *billModel;

@property (nonatomic, strong) NSMutableArray *monthArr;
@property (nonatomic, strong) NSMutableArray *yearArr;

@property (nonatomic, strong) NSMutableArray *allArr;

@end

@implementation GFBillViewController

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
    
    jianjv1 = kWidth * 0.046;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"账单" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    page = 1;
    pageSize = 20;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableView.header beginRefreshing];
//    [self.tableView.footer beginRefreshing];
    
}

- (void)headRefresh {

    NSLog(@"脑袋刷新");
    // 数组初始化并清空数组的元素
    self.modelArr = [[NSMutableArray alloc] init];
    
    self.allArr = [[NSMutableArray alloc] init];
    
    self.yearArr = [[NSMutableArray alloc] init];
    
    self.monthArr = [[NSMutableArray alloc] init];
    
    // 网络请求数据
    NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/bill";
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    parDic[@"page"] = [NSString stringWithFormat:@"%ld", page];
    parDic[@"pageSize"] = [NSString stringWithFormat:@"%ld", pageSize];
    [GFHttpTool billGet:url parameters:parDic success:^(id responseObject) {
        
        NSInteger flage = [responseObject[@"result"] integerValue];
        
        if(flage == 1) {
            
            NSLog(@"请求成功##########%@", responseObject);
            
//            NSString *time = @"1435680000000";
//            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//            //                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//            [formatter setDateFormat:@"yyyy-MM"];
//            formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
//            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
//            NSLog(@"^^^^^^^^^^^^^^^^^^^\n%@\n\n", [formatter stringFromDate:date]);
            
            // 获取时间进行分组
            //                    NSString *time = responseObject[@"billMonth"];
//            NSString *time = @"1435680000000";
//            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM"];
//            formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
//            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
//            NSLog(@"^^^^^^^^^^^^^^^^^^^\n%@\n\n", [formatter stringFromDate:date]);
//            NSString *str = [formatter stringFromDate:date];
//             NSLog(@"^^^^^^^^^^^^^^^^^^^\n%@\n\n", str);
//            
//            NSRange rang = NSMakeRange(0, 4);
//            NSString *yearStr = [str substringWithRange:rang];
//            NSLog(@"￥￥￥￥￥￥￥￥￥年\n%@", yearStr);
            
            // 获取data字典
            NSDictionary *dataDic = responseObject[@"data"];
            // 获取data中List数组
            NSArray *listArr = dataDic[@"list"];
            // 遍历数组  获取时间
            for(int i=0; i<listArr.count; i++) {
                
                NSDictionary *dic = listArr[i];
                
                NSString *time = dic[@"billMonth"];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM"];
                formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
                NSLog(@"^^^^^^^^^^^^^^^^^^^\n%@\n\n", [formatter stringFromDate:date]);
                NSString *str = [formatter stringFromDate:date];
                [self.allArr addObject:str];
//                NSRange rang1 = NSMakeRange(0, 4);
//                NSString *yearStr = [str substringWithRange:rang1];
//                NSLog(@"￥￥￥￥￥￥￥￥￥年\n%@\n", yearStr);
//                NSRange rang2 = NSMakeRange(5, 2);
//                NSString *monthStr = [str substringWithRange:rang2];
//                NSLog(@"￥￥￥￥￥￥￥￥￥月\n%@\n", monthStr);
                
//                if(i == 0) {
//                    
//                    NSString *time = dic[@"billMonth"];
//                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//                    [formatter setDateFormat:@"yyyy-MM"];
//                    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
//                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
//                    NSLog(@"^^^^^^^^^^^^^^^^^^^\n%@\n\n", [formatter stringFromDate:date]);
//                    NSString *str = [formatter stringFromDate:date];
//                    NSRange rang1 = NSMakeRange(0, 4);
//                    NSString *yearStr = [str substringWithRange:rang1];
//                    [self.yearArr addObject:yearStr];
//                    NSRange rang2 = NSMakeRange(5, 2);
//                    NSString *monthStr = [str substringWithRange:rang2];
//                    [self.modelArr addObject:monthStr];
//                   
//                    
//                    
//                }else {
//                
//                    // 获取时间进行分组
//                    NSString *time = responseObject[@"billMonth"];
//                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//                    [formatter setDateFormat:@"yyyy-MM"];
//                    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
//                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
//                    NSLog(@"^^^^^^^^^^^^^^^^^^^\n%@\n\n", [formatter stringFromDate:date]);
//                    NSString *str = [formatter stringFromDate:date];
//                    NSRange rang1 = NSMakeRange(0, 4);
//                    NSString *yearStr = [str substringWithRange:rang1];
//                }
                
                
                
                self.billModel = [[GFBillModel alloc] init];
                self.billModel.billId = dic[@"id"];
                self.billModel.techId = dic[@"techId"];
                self.billModel.billMonth = dic[@"billMonth"];
                self.billModel.sum = dic[@"sum"];
                self.billModel.payed = dic[@"payed"];
                
                [self.modelArr addObject:self.billModel];
            }
            // 遍历时间数组
            for(int i=0; i<self.allArr.count; i++) {
                
                NSString *timeStr = self.allArr[i];
                NSRange rang = NSMakeRange(0, 4);
                NSString *yearStr = [timeStr substringWithRange:rang];
                
                if(i == 0) {
                    
                    [self.yearArr addObject:yearStr];
                }else {
                
                    NSString *year1 = self.yearArr[self.yearArr.count - 1];
                    
                    if([yearStr isEqualToString:year1] == NO) {
                        
                        
                    }
                }
                
                
            }
            
            [self.tableView reloadData];
            
            
        }else {
        
            NSLog(@"请求失败");
            
        }
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"网络请求失败=====%@", error);
        
    }];
    
    
    
    [self.tableView.header endRefreshing];
    
}

- (void)footRefresh {

    NSLog(@"大脚刷新");
    
    [self.tableView.footer endRefreshing];
}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.modelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    

    static NSString *ID = @"cell";
    
    GFBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFBillTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    }

    if(indexPath.row == 1) {
        cell.jiesuanBut.selected = YES;
    }

//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    GFBillDetailsViewController *billDeVC = [[GFBillDetailsViewController alloc] init];
    [self.navigationController pushViewController:billDeVC animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kHeight * 0.094;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        
        
        
        return kHeight * 0.053;
    }else {
        
        return kHeight * 0.053 - kHeight * 0.013;
    }

}



- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight * 0.053)];
    headView.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    self.timeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timeBut.frame = CGRectMake(jianjv1, 0, (kWidth - jianjv1 * 2) * 0.5, kHeight * 0.053);
    self.timeBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.timeBut.titleLabel.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [self.timeBut setTitle:@"2016年" forState:UIControlStateNormal];
    [headView addSubview:self.timeBut];
    [self.timeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.moneyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moneyBut.frame = CGRectMake(kWidth / 2.0, 0, (kWidth - jianjv1 * 2) * 0.5, kHeight * 0.053);
    self.moneyBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.moneyBut.titleLabel.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [self.moneyBut setTitle:@"2016年" forState:UIControlStateNormal];
    [headView addSubview:self.moneyBut];
    [self.moneyBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (section != 0) {
        self.timeBut.titleEdgeInsets = UIEdgeInsetsMake(- kHeight * 0.025, 0, 0, 0);
        self.moneyBut.titleEdgeInsets = UIEdgeInsetsMake(- kHeight * 0.025, 0, 0, 0);
    }
    
    return headView;
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
