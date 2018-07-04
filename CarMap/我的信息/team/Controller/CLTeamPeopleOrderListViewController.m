//
//  CLTeamPeopleOrderListViewController.m
//  CarMap
//
//  Created by inCar on 2018/7/4.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLTeamPeopleOrderListViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "CLHomeTableViewCell.h"
#import "CLHomeOrderCellModel.h"


@interface CLTeamPeopleOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat kWidth;
    CGFloat kHeight;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}
@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation CLTeamPeopleOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _setBase];
    
    [self setTableView];
    
    [self getOrderList];
    
}



- (void)getOrderList{
    NSDictionary *dataDictionary = @{@"techId":_teamPeopleModel.idString};
    _dataArray = [[NSMutableArray alloc]init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [GFHttpTool getTechnicianTeamPeopleOrderWithDictionary:dataDictionary Success:^(id responseObject) {
        ICLog(@"-----获取订单列表成功----%@---",responseObject);
        if([responseObject[@"status"] integerValue] == 1) {
            
            NSDictionary *messageDic = responseObject[@"message"];
            NSArray *contentArr = messageDic[@"content"];
            
            for(int i = 0; i < contentArr.count; i++) {
                
                NSDictionary *dic = contentArr[i];
                CLHomeOrderCellModel *cellModel = [[CLHomeOrderCellModel alloc] initWithDictionary:dic];
                [_dataArray addObject:cellModel];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dic[@"agreedStartTime"] doubleValue]/1000];
                cellModel.orderTime = [formatter stringFromDate:date];
            }
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        ICLog(@"---error----%@--",error);
        
    }];
}

#pragma mark - 订单表格
- (void)setTableView{
    
    
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 /255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取消选择状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    
    
    if (indexPath.row < _dataArray.count) {
        CLHomeOrderCellModel *cellModer = _dataArray[indexPath.row];
        
        CLHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[CLHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [cell initWithOrder];
        }
        cell.orderButton.tag = indexPath.row + 1;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        NSDate *yuyueDate = [formatter dateFromString:cellModer.orderTime];
        NSInteger timeCha = (NSInteger)[yuyueDate timeIntervalSince1970] - (NSInteger)[[NSDate date] timeIntervalSince1970];
        if(timeCha < 3600 && timeCha > 0) {
            
            [cell.orderNumberLabel setTitle:[NSString stringWithFormat:@"  订单编号：%@",cellModer.orderNumber] forState:UIControlStateNormal];
            [cell.orderNumberLabel setImage:[UIImage imageNamed:@"jingbao"] forState:UIControlStateNormal];
        }else {
            
            [cell.orderNumberLabel setTitle:[NSString stringWithFormat:@"订单编号：%@",cellModer.orderNumber] forState:UIControlStateNormal];
            [cell.orderNumberLabel setImage:nil forState:UIControlStateNormal];
        }
        cell.timeLabel.text = [NSString stringWithFormat:@"预约施工时间：%@",cellModer.orderTime];
        cell.orderTypeLabel.text = cellModer.orderType;
        cell.orderTypeLabelText = cellModer.orderType;
        
        cell.orderButton.layer.borderWidth = 0;
        
        if([cellModer.status isEqualToString:@"FINISH"]){
            
        }
        
        
        
        if([cellModer.status isEqualToString:@"CREATED_TO_APPOINT"]) {
            [cell.orderButton setTitle:@"待指派" forState:UIControlStateNormal];
        }else if([cellModer.status isEqualToString:@"NEWLY_CREATED"]) {
            [cell.orderButton setTitle:@"未接单" forState:UIControlStateNormal];
        }else if([cellModer.status isEqualToString:@"TAKEN_UP"]) {
            [cell.orderButton setTitle:@"已接单" forState:UIControlStateNormal];
        }else if([cellModer.status isEqualToString:@"IN_PROGRESS"]) {
            [cell.orderButton setTitle:@"已出发" forState:UIControlStateNormal];
        }else if([cellModer.status isEqualToString:@"SIGNED_IN"]) {
            [cell.orderButton setTitle:@"已签到" forState:UIControlStateNormal];
        }else if([cellModer.status isEqualToString:@"AT_WORK"]) {
            [cell.orderButton setTitle:@"施工中" forState:UIControlStateNormal];
        }else if([cellModer.status isEqualToString:@"FINISHED"]) {
            [cell.orderButton setTitle:@"去评价" forState:UIControlStateNormal];
        }else if([cellModer.status isEqualToString:@"COMMENTED"]) {
            [cell.orderButton setTitle:@"已评价" forState:UIControlStateNormal];
        }else {
            [cell.orderButton setTitle:@"已撤消" forState:UIControlStateNormal];
        }
        
        
        
        return cell;
    }
    
    return nil;
}



- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"团队技师" withFrame:CGRectMake(0, 0, kWidth, 64)];
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
