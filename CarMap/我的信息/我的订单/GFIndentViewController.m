//
//  GFIndentViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFIndentViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFHttpTool.h"

#import "GFIndentTableViewCell.h"
#import "GFIndentDetailsViewController.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
//#import "GFTipView.h"

#import "GFIndentModel.h"

#import "GFNothingView.h"

@interface GFIndentViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    NSInteger page;
    NSInteger pageSize;
    
    
    NSInteger upSuo;
    
    NSString *mainUrl;
    NSString *seconderUrl;
    NSString *curUrl;
}



@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableArray *workItemArr;

@property (nonatomic, strong) GFNothingView *nothingView;

@end

@implementation GFIndentViewController

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
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的订单" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    self.workItemArr = [[NSMutableArray alloc] init];
    
    mainUrl = @"http://121.40.157.200:12345/api/mobile/technician/order/listMain";
    seconderUrl = @"http://121.40.157.200:12345/api/mobile/technician/order/listSecond";
    curUrl = mainUrl;
    
    page = 1;
    pageSize = 2;
    
    upSuo = 0;
    
    self.modelArr = [[NSMutableArray alloc] init];
    
    
    
    // 负责人横条
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = kHeight * 0.0651;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = 64;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    
    
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
    
    self.nothingView = [[GFNothingView alloc] initWithImageName:@"NoOrder" withTipString:@"暂无订单" withSubtipString:nil];
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [self.view addSubview:self.nothingView];
//    [self.tableview addSubview:self.nothingView];
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableview.header beginRefreshing];
//    [self.tableview.footer beginRefreshing];
    
    
    
    
}

- (void)renButClick:(UIButton *)sender {

    sender.selected = YES;
    
    if(sender.tag == 1000) {
        
        
        UIButton *but = (UIButton *)[self.view viewWithTag:2000];
        but.selected = NO;
        
        but.userInteractionEnabled = YES;
        sender.userInteractionEnabled = NO;
        
        curUrl = mainUrl;
        
    }else {
        
        UIButton *but = (UIButton *)[self.view viewWithTag:1000];
        but.selected = NO;
        
        
        but.userInteractionEnabled = YES;
        sender.userInteractionEnabled = NO;
        
        curUrl = seconderUrl;
    
    }
    
    CGFloat centerX = sender.center.x;
    CGPoint oriPoint = self.lineView.center;
    oriPoint.x = centerX;
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.center = oriPoint;
    }];
    
    
    [self.tableview.header beginRefreshing];
    
    
}

- (void)headRefresh {
    
    self.modelArr = [[NSMutableArray alloc] init];
    
    NSLog(@"脑袋刷新");
    
    page = 1;
    pageSize = 2;
    
    NSString *urlStr = curUrl;
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"page"] = [NSString stringWithFormat:@"%ld", page];
    mDic[@"pageSize"] = [NSString stringWithFormat:@"%ld", pageSize];
    
    [GFHttpTool indentGet:urlStr parameters:mDic success:^(id responseObject) {
        
        NSInteger flage = [responseObject[@"result"] integerValue];
        
        if(flage == 1) {
            
            NSLog(@"请求成功+++++++++++%@", responseObject);
            
            NSDictionary *dataDic = responseObject[@"data"];
            
            NSArray *listArr = dataDic[@"list"];
            
            if(listArr.count > 0) {
                self.nothingView.hidden = YES;
//                [self.nothingView removeFromSuperview];
            }else {
                self.nothingView.hidden = NO;
            }
            
//            NSLog(@"%@*******", listArr);
            
            for(NSDictionary *dic in listArr) {
                
                GFIndentModel *listModel = [[GFIndentModel alloc] init];
                listModel.orderNum = dic[@"orderNum"];
                listModel.photo = dic[@"photo"];
                listModel.remark = dic[@"remark"];
  
                if([curUrl isEqualToString:mainUrl]) {
                    NSDictionary *constructDic = dic[@"mainConstruct"];
                    listModel.payment = constructDic[@"payment"];
                    if (![constructDic[@"workItems"] isKindOfClass:[NSNull class]]) {
                        listModel.workItems = constructDic[@"workItems"];
                    }
                    
                    listModel.signinTime = constructDic[@"signinTime"];
                    listModel.payStatus = constructDic[@"payStatus"];
                    
                    NSInteger startTime = [constructDic[@"startTime"] integerValue];
                    NSInteger endTime = [constructDic[@"endTime"] integerValue];
                    NSInteger chaTime = endTime - startTime;
                    
                    NSInteger fenNum = chaTime/1000 % 60;
                    NSInteger shiNum = chaTime/1000 / 60;

                    if(shiNum > 0) {
                        listModel.workTime = [NSString stringWithFormat:@"%ld小时%ld分", shiNum, fenNum];
                    }else {
                        listModel.workTime = [NSString stringWithFormat:@"%ld分", fenNum];
                    }
                    
                
                }else if([curUrl isEqualToString:seconderUrl]) {
                    
                    NSLog(@"@@@@@@@@@@@\n@@@\n@@\n@@\n@@@@@   次负责人");
                    NSDictionary *constructDic = dic[@"secondConstruct"];
                    listModel.payment = constructDic[@"payment"];
                    listModel.workItems = constructDic[@"workItems"];
                    listModel.signinTime = constructDic[@"signinTime"];
                    listModel.payStatus = constructDic[@"payStatus"];
                    
                    NSInteger startTime = [constructDic[@"startTime"] integerValue];
                    NSInteger endTime = [constructDic[@"endTime"] integerValue];
                    NSInteger chaTime = endTime - startTime;

                    NSInteger fenNum = chaTime/1000 % 60;
                    NSInteger shiNum = chaTime/1000 / 60;

                    if(shiNum > 0) {
                        listModel.workTime = [NSString stringWithFormat:@"%ld小时%ld分", shiNum, fenNum];
                    }else {
                        listModel.workTime = [NSString stringWithFormat:@"%ld分", fenNum];
                    }
                }
                
                [self.modelArr addObject:listModel];

            }
            
            [self.tableview reloadData];
            
            
        }else {
            
            NSLog(@"请求失败+++++++++++%@", responseObject); 
        }
        
        [self.tableview.header endRefreshing];
        
    } failure:^(NSError *error) {
        
        NSLog(@"网络请求失败");

        
        [self.tableview.header endRefreshing];
        
    }];

    
}

- (void)footRefresh {
    
    NSLog(@"大脚刷新");
    
    NSString *urlStr = curUrl;
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"page"] = [NSString stringWithFormat:@"%ld", ++page];
    mDic[@"pageSize"] = [NSString stringWithFormat:@"%ld", pageSize];
    
    [GFHttpTool indentGet:urlStr parameters:mDic success:^(id responseObject) {
        
        NSInteger flage = [responseObject[@"result"] integerValue];
        
        if(flage == 1) {
            
            NSLog(@"请求成功+++++++++++%@", responseObject);
            
            NSLog(@"请求成功+++++++++++%@", responseObject);
            
            NSDictionary *dataDic = responseObject[@"data"];
            
            NSArray *listArr = dataDic[@"list"];
            
//            NSLog(@"%@*******", listArr);
            
            for(NSDictionary *dic in listArr) {
                
                GFIndentModel *listModel = [[GFIndentModel alloc] init];
                listModel.orderNum = dic[@"orderNum"];
                listModel.photo = dic[@"photo"];
                listModel.remark = dic[@"remark"];
                
                if([curUrl isEqualToString:mainUrl]) {
                    NSDictionary *constructDic = dic[@"mainConstruct"];
                    listModel.payment = constructDic[@"payment"];
                    listModel.workItems = constructDic[@"workItems"];
                    listModel.signinTime = constructDic[@"signinTime"];
                    listModel.payStatus = constructDic[@"payStatus"];
                    
                    NSInteger startTime = [constructDic[@"startTime"] integerValue];
                    NSInteger endTime = [constructDic[@"endTime"] integerValue];
                    NSInteger chaTime = endTime - startTime;
                    NSInteger fenNum = chaTime / 1000 % 60;
                    NSInteger shiNum = chaTime / 60 / 1000;
                    if(shiNum > 0) {
                        listModel.workTime = [NSString stringWithFormat:@"%ld小时%ld分", shiNum, fenNum];
                    }else {
                        listModel.workTime = [NSString stringWithFormat:@"%ld分", fenNum];
                    }
                    
                }else if([curUrl isEqualToString:seconderUrl]) {
                    
                    NSLog(@"@@@@@@@@@@@\n@@@\n@@\n@@\n@@@@@   次负责人");
                    NSDictionary *constructDic = dic[@"secondConstruct"];
                    listModel.payment = constructDic[@"payment"];
                    listModel.workItems = constructDic[@"workItems"];
                    listModel.signinTime = constructDic[@"signinTime"];
                    listModel.payStatus = constructDic[@"payStatus"];
                    
                    NSInteger startTime = [constructDic[@"startTime"] integerValue];
                    NSInteger endTime = [constructDic[@"endTime"] integerValue];
                    NSInteger chaTime = endTime - startTime;
                    NSInteger fenNum = chaTime / 1000 % 60;
                    NSInteger shiNum = chaTime / 60 / 1000;
                    if(shiNum > 0) {
                        listModel.workTime = [NSString stringWithFormat:@"%ld小时%ld分", shiNum, fenNum];
                    }else {
                        listModel.workTime = [NSString stringWithFormat:@"%ld分", fenNum];
                    }
                    
                }
                
                [self.modelArr addObject:listModel];
                
                
                
            }

            [self.tableview reloadData];
            
        }else {
            
            NSLog(@"请求失败+++++++++++%@", responseObject);
            
        }
        
        [self.tableview.footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        NSLog(@"网络请求失败");
        
        
        [self.tableview.footer endRefreshing];
        
    }];

    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.modelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    GFIndentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFIndentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    GFIndentModel *model = self.modelArr[indexPath.row];
    
    NSLog(@"********** %@ **********", model.orderNum);
    NSLog(@"********** %@ **********", model.photo);
    NSLog(@"********** %@ **********", model.payment);
    NSLog(@"********** %@ **********", model.signinTime);
    NSLog(@"********** %@ **********", model.workItems);
    NSLog(@"********** %@ **********", model.remark);
    
    // 订单编号
    cell.numberLab.text = [NSString stringWithFormat:@"订单编号%@", model.orderNum];
    // 加载图片
//    model.photo = [NSString stringWithFormat:@"http://121.40.157.200:12345%@", model.photo];
    NSURL *imgUrl = [NSURL URLWithString:model.photo];
    [cell.photoImgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    // 金额
    cell.moneyLab.text = [NSString stringWithFormat:@"￥%@", model.payment];
    // 是否结算
    NSInteger jisuanNum = (NSInteger)[model.payStatus integerValue];
    if(jisuanNum == 0 || jisuanNum == 1) {
        cell.tipBut.selected = NO;
    }else {
        cell.tipBut.selected = YES;
    }
    // 开始时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.signinTime integerValue]/1000];
    cell.timeLab.text = [NSString stringWithFormat:@"施工时间：%@", [formatter stringFromDate:date]];
    // 施工部位
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WorkItemDic" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *workItemsStr = [[NSString alloc] init];
    NSArray *strArr = [model.workItems componentsSeparatedByString:@","];
    for(NSString *str in strArr) {
        if(workItemsStr.length == 0) {
            workItemsStr = [NSString stringWithFormat:@"%@", dic[str]];
        }else {
            workItemsStr = [NSString stringWithFormat:@"%@,%@", workItemsStr, dic[str]];
        }
    }
    
    NSLog(@"%@", strArr);
    
    cell.placeLab.text = [NSString stringWithFormat:@"施工部位：%@", workItemsStr];
    
    [self.workItemArr addObject:workItemsStr];
    

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return kHeight * 0.464 + kHeight * 0.0183;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    NSLog(@"++++++++++++++\n%ld\n\n", self.modelArr.count);
    
    GFIndentDetailsViewController *indentDeVC = [[GFIndentDetailsViewController alloc] init];
    indentDeVC.model = self.modelArr[indexPath.row];
    indentDeVC.workItems = self.workItemArr[indexPath.row];
    [self.navigationController pushViewController:indentDeVC animated:YES];
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
