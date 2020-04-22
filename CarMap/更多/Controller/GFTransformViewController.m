//
//  GFTransformViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFTransformViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTransformTableViewCell.h"
#import "CLNotificationModel.h"
#import "GFTipView.h"
#import "MJRefresh.h"
#import "GFNothingView.h"



@interface GFTransformViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat cellHeight;
    
    NSMutableArray *_notificationModelArray;
    NSInteger _page;
    NSInteger _pagesize;
    
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GFTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _notificationModelArray = [[NSMutableArray alloc]init];
    
    
    
    // 基础设置
    [self _setBase];
    
    
    // 界面搭建
    [self _setView];
    
    
    [self getNotification];
    
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"消息通知" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)headRefresh{
    _page = 1;
    _pagesize = 4;
    _notificationModelArray = [[NSMutableArray alloc]init];
    [self getNotification];
    
}

- (void)footRefresh{
    if (_page == 1) {
        _page = 2;
        _pagesize = 2;
    }
    _page = _page + 1;
    
    [self getNotification];
}


- (void)getNotification{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    NSDictionary *dictionary = @{@"page":@(_page),@"pageSize":@(_pagesize)};
    
    [GFHttpTool getMessageDictionary:dictionary Success:^(id responseObject) {
//                NSLog(@"－－－网络通知列表－－%@----",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSArray *listArray = dataDictionary[@"list"];
            //            NSLog(@"listArray-----%@---",listArray);
            
            if (_page != 1 && listArray.count == 0) {
                [self addAlertView:@"已加载全部"];
            }else{
                [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                    CLNotificationModel *model = [[CLNotificationModel alloc]init];
                    model.titleString = obj[@"title"];
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"publishTime"] doubleValue]/1000];
                    model.timeString = [formatter stringFromDate:date];
                    //                model.timeString = obj[@"publishTime"];
                    model.contentString = obj[@"content"];
                    [_notificationModelArray addObject:model];
                }];
                
                //            NSLog(@"----notificationArray----%@",_notificationModelArray);
                [_tableView reloadData];
            }

            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            if (_notificationModelArray.count == 0) {
                _tableView.userInteractionEnabled = NO;
                GFNothingView *nothingView = [[GFNothingView alloc] initWithImageName:@"NoOrder" withTipString:@"暂无数据" withSubtipString:nil];
                [self.view addSubview:nothingView];
            }
            
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
        
    } failure:^(NSError *error) {
//        NSLog(@"请求失败了－－－%@--",error);
//         [self addAlertView:@"请求失败"];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _notificationModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    GFTransformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil) {
        
        cell = [[GFTransformTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row < _notificationModelArray.count) {
        CLNotificationModel *model = _notificationModelArray[indexPath.row];
        
        cell.titleLabel.text = model.titleString;
        cell.contentLabel.text = model.contentString;
        cell.timeLab.text = model.timeString;
        [cell cellForMessage];
        cellHeight = cell.cellHeight;
    }
   
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"点击方法");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
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
