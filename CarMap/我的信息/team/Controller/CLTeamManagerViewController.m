//
//  CLTeamManagerViewController.m
//  CarMap
//
//  Created by inCar on 2018/6/19.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLTeamManagerViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "CLTeamModel.h"
#import "CLTeamTableViewCell.h"
#import "CLTeamPeopleViewController.h"


@interface CLTeamManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat kWidth;
    CGFloat kHeight;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}
@property (nonatomic, strong) GFNavigationView *navView;
@end

@implementation CLTeamManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _setBase];
    
    _dataArray = [[NSMutableArray alloc]init];
    [self getMyTeam];
    
    [self setTableViewForDetail];
}

- (void)setTableViewForDetail{
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navView.mas_bottom).offset(5);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[CLTeamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if(_dataArray.count > indexPath.row){
        cell.teamModel = _dataArray[indexPath.row];
    }
    return cell;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    CLTeamPeopleViewController *teamPeopleVC = [[CLTeamPeopleViewController alloc]init];
    teamPeopleVC.teamModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:teamPeopleVC animated:YES];
}




- (void)getMyTeam{
    [GFHttpTool getTechnicianTeamWithDictionary:nil Success:^(id responseObject) {
        ICLog(@"----获取团队列表成功---%@--",responseObject);
        BOOL status = [responseObject[@"status"] boolValue];
        if (status == YES) {
            NSArray *messageArray = responseObject[@"message"];
            [messageArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CLTeamModel *teamModel = [[CLTeamModel alloc]init];
                [teamModel setModelDataWithDictionary:obj];
                [_dataArray addObject:teamModel];
            }];
            [_tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        ICLog(@"获取列表失败----%@-",error);
        
    }];
}






- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"团队管理" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
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
