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
#import "GFNothingView.h"
#import "GFTipView.h"



@interface GFBillViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jianjv1;
    
    NSInteger page;
    NSInteger pageSize;
    NSMutableDictionary *_listDictionary;
}

@property (nonatomic, strong) NSMutableDictionary *monthDic;

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *timeBut;
@property (nonatomic, strong) UIButton *moneyBut;
@property (nonatomic, strong) GFBillModel *billModel;
@property (nonatomic, strong) NSMutableArray *yearArr;
@property (nonatomic, strong) GFNothingView *nothingView;



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
    
    self.monthDic = [[NSMutableDictionary alloc] init];
    self.monthDic[@"01"] = @"一月";
    self.monthDic[@"02"] = @"二月";
    self.monthDic[@"03"] = @"三月";
    self.monthDic[@"04"] = @"四月";
    self.monthDic[@"05"] = @"五月";
    self.monthDic[@"06"] = @"六月";
    self.monthDic[@"07"] = @"七月";
    self.monthDic[@"08"] = @"八月";
    self.monthDic[@"09"] = @"九月";
    self.monthDic[@"10"] = @"十月";
    self.monthDic[@"11"] = @"十一月";
    self.monthDic[@"12"] = @"十二月";
    
    // 无数据提示页
    self.nothingView = [[GFNothingView alloc] initWithImageName:@"Nothing.png" withTipString:@"暂无账单" withSubtipString:@"本页为月账单显示页"];
    [self.view addSubview:self.nothingView];
    
    
    page = 1;
    pageSize = 4;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    
    
    [self.tableView.header beginRefreshing];
    [self.tableView.footer beginRefreshing];
    
    
    
    
}

- (void)headRefresh {

//    NSLog(@"脑袋刷新");
    // 数组初始化并清空数组的元素
    self.yearArr = [[NSMutableArray alloc] init];
    _listDictionary = [[NSMutableDictionary alloc]init];
    page = 1;
    pageSize = 4;
    [self tableViewHttp];
    
    [self.tableView.header endRefreshing];
    
}

- (void)footRefresh {

//    NSLog(@"账单大脚刷新");
    if (page == 1) {
        page = 2;
    }
    page = page + 1;
    pageSize = 2;
    [self tableViewHttp];
    
    [self.tableView.footer endRefreshing];
}


- (void)tableViewHttp{
    
    // 网络请求数据
    NSString *url = @"http://121.40.157.200:12345/api/mobile/technician/bill";
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    parDic[@"page"] = [NSString stringWithFormat:@"%ld", page];
    parDic[@"pageSize"] = [NSString stringWithFormat:@"%ld", pageSize];
    [GFHttpTool billGet:url parameters:parDic success:^(id responseObject) {
        
        
        
        NSInteger flage = [responseObject[@"result"] integerValue];
        if(flage == 1) {

            // 获取data字典
            NSDictionary *dataDic = responseObject[@"data"];
            // 获取data中List数组
            NSArray *listArr = dataDic[@"list"];
            if(listArr.count > 0) {
                self.nothingView.hidden = YES;
            }
            if (listArr.count == 0 && _yearArr.count > 0) {
                [self addAlertView:@"已加载全部"];
            }
            

            NSMutableArray *monthArray;
            NSString *yearString;
            // 遍历数组  获取时间
            for(int i=0; i<listArr.count; i++) {
                NSDictionary *dic = listArr[i];
                
                NSString *time = dic[@"billMonth"];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM"];
                [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time floatValue]/1000];
                NSString *str = [formatter stringFromDate:date];

                NSArray *stringArray = [str componentsSeparatedByString:@"-"];
                
                self.billModel = [[GFBillModel alloc] init];
                self.billModel.billId = dic[@"id"];
                self.billModel.techId = dic[@"techId"];
                self.billModel.billMonth = stringArray[1];
                self.billModel.sum = dic[@"sum"];
                self.billModel.payed = dic[@"payed"];
                

                
                if (_listDictionary.allKeys.count == 0) {
                    if (listArr.count == 1) {
                        monthArray = [[NSMutableArray alloc]init];
                        [monthArray addObject:self.billModel];
                        [_listDictionary setObject:@[self.billModel] forKey:stringArray[0]];
                        [_yearArr addObject:stringArray[0]];
                    }else{
                        if (i == 0) {
                            monthArray = [[NSMutableArray alloc]init];
                            [monthArray addObject:self.billModel];
                        }else if (i == listArr.count - 1){
                            
                            
                            
                            if (listArr.count == 1) {
                                
                                [_listDictionary setObject:@[self.billModel] forKey:stringArray[0]];
                                [_yearArr addObject:stringArray[0]];
                                
                            }else{
                                
//                                NSLog(@"---%d--%@--%@--",i,stringArray,yearString);
                                
                                if (i == 0) {
                                    monthArray = [[NSMutableArray alloc]init];
                                    [monthArray addObject:self.billModel];
                                }else if (i == listArr.count - 1){
                                    
                                    if ([yearString isEqualToString:stringArray[0]]) {
                                        [monthArray addObject:self.billModel];
                                        [_listDictionary setObject:monthArray forKey:stringArray[0]];
                                        if ([_yearArr containsObject:stringArray[0]]) {
                                            
                                        }else{
                                            [_yearArr addObject:stringArray[0]];
                                        }
                                    }else{
                                        [_listDictionary setObject:monthArray forKey:yearString];
                                        if ([_yearArr containsObject:stringArray[0]]) {
                                            
                                        }else{
                                            [_yearArr addObject:stringArray[0]];
                                        }
                                        monthArray = [[NSMutableArray alloc]init];
                                        [monthArray addObject:self.billModel];
                                        [_listDictionary setObject:monthArray forKey:stringArray[0]];
                                        [_yearArr addObject:stringArray[0]];
                                        
                                    }
                                    
                                }else{
                                    if ([yearString isEqualToString:stringArray[0]]) {
                                        [monthArray addObject:self.billModel];
                                    }else{
                                        [_listDictionary setObject:monthArray forKey:yearString];
                                        [_yearArr addObject:yearString];
                                        
                                        monthArray = [[NSMutableArray alloc]init];
                                        [monthArray addObject:self.billModel];
                                    }
                                }
                                
                                
                                
                            }
                        }
                        yearString = stringArray[0];
                    }
                    
                    
               
                }else{
                    
//                     NSLog(@"---year--%@--_list--%@--",_yearArr,_listDictionary);
                    
                    if (i == 0) {
                        
                        if ([_yearArr containsObject:stringArray[0]]) {
                           monthArray = [[NSMutableArray alloc]initWithArray:[_listDictionary objectForKey:stringArray[0]]];
                        }else{
                            monthArray = [[NSMutableArray alloc]init];
                        }
                    }
                    if (listArr.count == 1) {
                        [monthArray addObject:self.billModel];
                        [_listDictionary setObject:monthArray forKey:stringArray[0]];
                        if ([_yearArr containsObject:stringArray[0]]) {
                            
                        }else{
                            [_yearArr addObject:stringArray[0]];
                        }
                    }else{
                        
                        if (i == 0) {
                            [monthArray addObject:self.billModel];
                            
                        }else if (i == listArr.count - 1){
                            
                            if ([yearString isEqualToString:stringArray[0]]) {
                                [monthArray addObject:self.billModel];
                                [_listDictionary setObject:monthArray forKey:stringArray[0]];
                                if ([_yearArr containsObject:stringArray[0]]) {
                                    
                                }else{
                                    [_yearArr addObject:stringArray[0]];
                                }
//                                 NSLog(@"---year--%@--_list--%@--",_yearArr,_listDictionary);
                            }else{
                                [_listDictionary setObject:monthArray forKey:yearString];
                                if ([_yearArr containsObject:stringArray[0]]) {
                                    
                                }else{
                                    [_yearArr addObject:stringArray[0]];
                                }
//                                 NSLog(@"---year--%@--_list--%@--",_yearArr,_listDictionary);
                                monthArray = [[NSMutableArray alloc]init];
                                [monthArray addObject:self.billModel];
                                [_listDictionary setObject:monthArray forKey:stringArray[0]];
                                if ([_yearArr containsObject:stringArray[0]]) {
                                    
                                }else{
                                    [_yearArr addObject:stringArray[0]];
                                }
//                                 NSLog(@"---year--%@--_list--%@--",_yearArr,_listDictionary);
                            }
                            
                        }else{
                            if ([yearString isEqualToString:stringArray[0]]) {
                                [monthArray addObject:self.billModel];
                            }else{
                                [_listDictionary setObject:monthArray forKey:yearString];
                                if ([_yearArr containsObject:stringArray[0]]) {
                                    
                                }else{
                                    [_yearArr addObject:stringArray[0]];
                                }
                                
                                monthArray = [[NSMutableArray alloc]init];
                                [monthArray addObject:self.billModel];
                            }
                        }
                        
                        
                    }
                    
                   yearString = stringArray[0];
                }
                
            }
                
//            NSLog(@"---year--%@--_list--%@--",_yearArr,_listDictionary);
            
            [self.tableView reloadData];
        }else {
           
            [self addAlertView:responseObject[@"message"]];
        }
        
    } failure:^(NSError *error) {
   
        
        [self addAlertView:@"请求失败"];
    }];
    
    
    [self.tableView.header endRefreshing];
    
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _yearArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *year = _yearArr[section];
    NSArray *monthArray = _listDictionary[year];
    
    return monthArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    

    static NSString *ID = @"cell";
    
    GFBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFBillTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    }

    

    NSString *year = _yearArr[indexPath.section];
    NSArray *billArray = _listDictionary[year];
    GFBillModel *billModel = billArray[indexPath.row];
//    NSLog(@"-----month---%@--payed---%@--%@-",billModel.month,billModel.payed,indexPath);
    cell.jiesuanBut.selected = [billModel.payed integerValue];
    
    
    cell.monthLab.text = self.monthDic[billModel.billMonth];
    cell.sumMoneyLab.text = [NSString stringWithFormat:@"￥ %@",billModel.sum];
    

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    GFBillDetailsViewController *billDeVC = [[GFBillDetailsViewController alloc] init];
    
    NSString *str1 = _yearArr[indexPath.section];
    NSArray *arr1 = _listDictionary[str1];
    GFBillModel *model = arr1[indexPath.row];
    billDeVC.model = model;
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
    [self.timeBut setTitle:_yearArr[section] forState:UIControlStateNormal];
    [headView addSubview:self.timeBut];
    [self.timeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    NSArray *billArray = _listDictionary[_yearArr[section]];
    __block NSInteger money = 0;
    [billArray enumerateObjectsUsingBlock:^(GFBillModel *obj, NSUInteger idx, BOOL *stop) {
        
        money = [obj.sum integerValue] + money;
        
    }];
    
    
    self.moneyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moneyBut.frame = CGRectMake(kWidth / 2.0, 0, (kWidth - jianjv1 * 2) * 0.5, kHeight * 0.053);
    self.moneyBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.moneyBut.titleLabel.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [self.moneyBut setTitle:[NSString stringWithFormat:@"￥ %ld",(long)money] forState:UIControlStateNormal];
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
