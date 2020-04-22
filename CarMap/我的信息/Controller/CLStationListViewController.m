//
//  CLStationListViewController.m
//  CarMap
//
//  Created by inCarL on 2019/12/16.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLStationListViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "CLStationModel.h"
#import "CLStationTableViewCell.h"
#import "GFTipView.h"
#import "MJRefresh.h"

@interface CLStationListViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    CGFloat kWidth;
    CGFloat kHeight;
    
    NSInteger page;
    NSInteger pageSize;
}
@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *stationArray;
@property (nonatomic, strong) CLStationModel *selectStationModel;
@end

@implementation CLStationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _stationArray = [[NSMutableArray alloc]init];
    
    [self _setBase];
    
    [self setViewForDetail];
    
    
}

- (void)setViewForDetail{
    UIView *searchBaseView = [[UIView alloc]init];
    searchBaseView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:searchBaseView];
    [searchBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom);
        make.height.mas_offset(50);
    }];
    
    _searchTextField = [[UITextField alloc]init];
    [_searchTextField setTextFieldPlaceholderString:@"商户名称"];
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    _searchTextField.backgroundColor = [UIColor whiteColor];
    [searchBaseView addSubview:_searchTextField];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchBaseView).offset(10);
        make.centerY.equalTo(searchBaseView).offset(0);
        make.height.mas_offset(30);
        make.right.equalTo(searchBaseView).offset(-80);
    }];
    
    UIButton *searchButton = [[UIButton alloc]init];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    searchButton.layer.cornerRadius = 15;
    [searchBaseView addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_searchTextField);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_offset(30);
        make.width.mas_offset(60);
    }];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(searchBaseView.mas_bottom);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)headRefresh{
    [_stationArray removeAllObjects];
    page = 1;
    pageSize = 20;
    [self getStationList];
}
- (void)footRefresh{
    page = page + 1;
    [self getStationList];
}
- (void)searchBtnClick{
    [_stationArray removeAllObjects];
    [self getStationList];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLStationTableViewCell *stationCell = [tableView dequeueReusableCellWithIdentifier:@"stationCell"];
    if (stationCell == nil){
        stationCell = [[CLStationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stationCell"];
    }
    if (indexPath.row < self.stationArray.count){
        CLStationModel *stationModel = self.stationArray[indexPath.row];
        stationCell.nameLabel.text = [NSString stringWithFormat:@"商户名称：%@", stationModel.coopName];
        stationCell.addressLabel.text = [NSString stringWithFormat:@"商户位置：%@", stationModel.address];
    }
    return stationCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _stationArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否将此商户设置为常驻地商户" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    self.selectStationModel = self.stationArray[indexPath.row];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        ICLog(@"变更常驻地");
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
        dataDictionary[@"id"] = self.selectStationModel.coopId;
        [GFHttpTool postStationCoopWithDictionary:dataDictionary Success:^(id responseObject) {
            ICLog(@"变更常驻地成功----%@---", responseObject);
            UIViewController *VC = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:VC animated:YES];
        } failure:^(NSError *error) {
            ICLog(@"变更常驻地失败----%@---", error);
        }];
    }
}

- (void)getStationList{
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    if (self.searchTextField.text.length > 0){
        dataDictionary[@"fullname"] = self.searchTextField.text;
    }
    dataDictionary[@"page"] = @(page);
    dataDictionary[@"pageSize"] = @(pageSize);
    ICLog(@"dataDictionary-----%@---", dataDictionary);
    [GFHttpTool getCoopListWithDictionary:dataDictionary Success:^(id responseObject) {
        ICLog(@"获取技师常驻地列表成功-----%@---", responseObject);
        NSInteger flage = [responseObject[@"status"] integerValue];
        if (flage == 1){
            NSArray *listArray = responseObject[@"message"][@"list"];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CLStationModel *stationModel = [[CLStationModel alloc]init];
                stationModel.coopName = obj[@"fullname"];
                stationModel.address = [NSString stringWithFormat:@"%@",obj[@"address"]];
                if ([stationModel.address isEqualToString:@"<null>"]){
                    stationModel.address = @"无";
                }
                stationModel.coopId = [NSString stringWithFormat:@"%@", obj[@"id"]];
                stationModel.latitude = [NSString stringWithFormat:@"%@", obj[@"latitude"]];
                stationModel.longitude = [NSString stringWithFormat:@"%@", obj[@"longitude"]];
                [self.stationArray addObject:stationModel];
            }];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        ICLog(@"获取技师常驻地列表失败----%@---", error);
    }];
}


- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"常驻地设置" withFrame:CGRectMake(0, 0, kWidth, 64)];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
