//
//  CLCollectViewController.m
//  CarMap
//
//  Created by inCar on 17/5/18.
//  Copyright © 2017年 mll. All rights reserved.
//

#import "CLCollectViewController.h"
#import "GFNavigationView.h"
#import "MJRefresh.h"
#import "GFHttpTool.h"
#import "CLCooperatorModel.h"
#import "CLCollectTableViewCell.h"
#import "GFTipView.h"

@interface CLCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    UITableView *_tableView;
    
    NSInteger _pageNo;
    NSInteger _pageSize;
    
    NSMutableArray *_dataArray;
    
}

@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation CLCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基础设置
    [self _setBase];
    
    [self setTableViewForFavorite];
    
    [_tableView.header beginRefreshing];
}

- (void)setTableViewForFavorite{
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorColor = [UIColor clearColor];
    
    _tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
}

- (void)headRefresh {
    
    _pageNo = 1;
    _pageSize = 4;
    _dataArray = [[NSMutableArray alloc] init];
    
    [self getFavoriteList];
    
}

- (void)footRefresh {
    
    _pageNo = _pageNo + 1;
    _pageSize = 4;
    
    [self getFavoriteList];
}


- (void)getFavoriteList{
    NSDictionary *dictionary = @{@"page":@(_pageNo),@"pageSize":@(_pageSize)};
    
    [GFHttpTool favoriteCooperatorGetWithParameters:dictionary success:^(id responseObject) {
        ICLog(@"--responseObject--%@--",responseObject);

        NSArray *listArray = responseObject[@"list"];
        [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CLCooperatorModel *model = [[CLCooperatorModel alloc]init];
            [model setModelForData:obj[@"cooperator"]];
            [_dataArray addObject:model];
            
        }];
        
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"--error--%@--",error);
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CLCollectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    cell.backgroundColor = [UIColor cyanColor];
    cell.model = _dataArray[indexPath.row];
    cell.removeButton.tag = indexPath.row;
    [cell.removeButton addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - 移除收藏响应方法
- (void)removeBtnClick:(UIButton *)button{
    if (_dataArray.count > button.tag) {
        CLCooperatorModel *model = _dataArray[button.tag];
        
        [GFHttpTool favoriteCooperatorDeleteWithParameters:@{@"cooperatorId":model.idString} success:^(id responseObject) {
            ICLog(@"删除成功--%@--",responseObject);
            if ([responseObject[@"result"] integerValue] == 1) {
                [self addAlertView:@"操作成功"];
                [_tableView.header beginRefreshing];
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
            
            
        } failure:^(NSError *error) {
            ICLog(@"删除失败--%@--",error);
        }];
    }

}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的收藏" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
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
