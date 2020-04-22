//
//  CLNotificationViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/4/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLNotificationViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "CLNotificationModel.h"
#import "CLNotificationDetailViewController.h"



@interface CLNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *_notificationModelArray;
    UITableView *_tableView;
    
}

@end

@implementation CLNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self _setBase];
    
    _notificationModelArray = [[NSMutableArray alloc]init];
    [self getNotification];
    
}


- (void)getNotification{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    
    [GFHttpTool getMessageDictionary:nil Success:^(id responseObject) {
//        NSLog(@"－－－网络通知列表－－%@----",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSArray *listArray = dataDictionary[@"list"];
//            NSLog(@"listArray-----%@---",listArray);
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
            
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
        
    } failure:^(NSError *error) {
//        [self addAlertView:@"请求失败"];
    }];
}


- (void)_setBase {
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"通知列表" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    
    [self.view addSubview:navView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _notificationModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.tag = 5;
        [cell addSubview:label];
//        label.backgroundColor = [UIColor redColor];
    }
    CLNotificationModel *model = _notificationModelArray[indexPath.row];
//    cell.textLabel.text = model.titleString;
//    cell.detailTextLabel.text = model.timeString;
    
    UILabel *label = (UILabel *)[cell viewWithTag:5];
    
//    label.text = [NSString stringWithFormat:@"%@  %@",[model.timeString componentsSeparatedByString:@" "][0],model.titleString];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  %@",[model.timeString componentsSeparatedByString:@" "][0],model.titleString]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] range:NSMakeRange(0,10)];
//        NSLog(@"---label.text-----%@------array-",str);
    label.attributedText = str;
    CGRect labelRect = [label.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    
    label.frame = CGRectMake(10, 10, self.view.frame.size.width-20, labelRect.size.height);
    model.cellHeight = labelRect.size.height + 20;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLNotificationModel *model = _notificationModelArray[indexPath.row];
    
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLNotificationModel *model = _notificationModelArray[indexPath.row];
    CLNotificationDetailViewController *detailView = [[CLNotificationDetailViewController alloc]init];
    detailView.detailModel = model;
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)leftButClick{
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
