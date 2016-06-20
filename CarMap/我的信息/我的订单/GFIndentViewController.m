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
#import "GFTipView.h"

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
    NSInteger curUrlId;
    
    NSMutableArray *_workNameArr;
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
    _workNameArr = [[NSMutableArray alloc] init];
    self.workItemArr = [[NSMutableArray alloc] init];
    extern NSString *const URLHOST;
    mainUrl = [NSString stringWithFormat:@"%@/api/mobile/technician/order/listMain",URLHOST];
    seconderUrl = [NSString stringWithFormat:@"%@/api/mobile/technician/order/listSecond",URLHOST];
    curUrl = mainUrl;
    curUrlId = 0;
    
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
        curUrlId = 0;
        
    }else {
        
        UIButton *but = (UIButton *)[self.view viewWithTag:1000];
        but.selected = NO;
        
        
        but.userInteractionEnabled = YES;
        sender.userInteractionEnabled = NO;
        
        curUrl = seconderUrl;
        curUrlId = 1;
    
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
    _workItemArr = [[NSMutableArray alloc]init];
    
    
//    NSLog(@"脑袋刷新");
    self.tableview.userInteractionEnabled = NO;
    page = 1;
    pageSize = 4;
    
//    NSString *urlStr = curUrl;
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"curUrlId"] = [NSString stringWithFormat:@"%ld", curUrlId];
    mDic[@"page"] = [NSString stringWithFormat:@"%ld", page];
    mDic[@"pageSize"] = [NSString stringWithFormat:@"%ld", pageSize];
    
    [GFHttpTool indentGetWithParameters:mDic success:^(id responseObject) {
        
        NSInteger flage = [responseObject[@"result"] integerValue];
        
        if(flage == 1) {
            
            NSLog(@"订单数据＝＝＝＝＝%@", responseObject);
            
            NSDictionary *dataDic = responseObject[@"data"];
            
            NSArray *listArr = dataDic[@"list"];
            
            if(listArr.count > 0) {
                self.nothingView.hidden = YES;
//                [self.nothingView removeFromSuperview];
            }else {
                self.nothingView.hidden = NO;
            }
            
//            NSLog(@"%@*******", listArr);
            extern NSString* const URLHOST;
            for(NSDictionary *dic in listArr) {
                
                _workNameArr = [[NSMutableArray alloc] init];
                
                GFIndentModel *listModel = [[GFIndentModel alloc] init];
                listModel.orderNum = dic[@"orderNum"];
                listModel.photo = [NSString stringWithFormat:@"%@%@",URLHOST,dic[@"photo"]];
                listModel.remark = dic[@"remark"];
                listModel.commentDictionary = dic[@"comment"];
                listModel.indentType = dic[@"orderType"];
  
                if([curUrl isEqualToString:mainUrl]) {
                    NSDictionary *constructDic = dic[@"mainConstruct"];
                    if (![constructDic isKindOfClass:[NSNull class]]) {
                        listModel.payment = constructDic[@"payment"];
                        if (![constructDic[@"workItems"] isKindOfClass:[NSNull class]]) {
                            listModel.workItems = constructDic[@"workItems"];
                        }

                        
                        listModel.signinTime = constructDic[@"signinTime"];
                        listModel.payStatus = constructDic[@"payStatus"];
                        listModel.beforePhotos = constructDic[@"beforePhotos"];
                        listModel.afterPhotos = constructDic[@"afterPhotos"];
                        NSInteger startTime = [constructDic[@"startTime"] integerValue];
                        NSInteger endTime;
                        NSInteger fenNum;
                        NSInteger shiNum;
                        NSInteger chaTime;
                        if ([constructDic[@"endTime"] isKindOfClass:[NSNull class]]) {
                            endTime = 0;
                            chaTime = 0;
                        }else{
                            endTime = [constructDic[@"endTime"] integerValue];
                            chaTime = endTime - startTime;
                        }
//                        chaTime = endTime - startTime;
//                        NSLog(@"--starTime-%ld-End--%ld---%ld--",startTime,endTime,chaTime);
                        fenNum = (chaTime/1000/60)%60;
                        shiNum = chaTime/1000 /3600;
                        if(shiNum > 0) {
                            listModel.workTime = [NSString stringWithFormat:@"%ld小时%ld分", (long)shiNum, (long)fenNum];
                        }else {
                            listModel.workTime = [NSString stringWithFormat:@"%ld分", (long)fenNum];
                        }
                        
                        

                    }else{
                        listModel.payment = @"0";
                        listModel.workTime = @"0分";
                    }
                    
                    
                    // 员工姓名添加
                    NSDictionary *tech = dic[@"mainTech"];
                    NSDictionary *seTech = dic[@"secondTech"];
                    if(![tech isKindOfClass:[NSNull class]]) {
                        
                        [_workNameArr addObject:tech[@"name"]];
                    }
                    
                    if(![seTech isKindOfClass:[NSNull class]]) {
                    
                        [_workNameArr addObject:seTech[@"name"]];
                    }
                    
                
                }else if([curUrl isEqualToString:seconderUrl]) {
                    
                    NSDictionary *constructDic = dic[@"secondConstruct"];
                    if (![constructDic isKindOfClass:[NSNull class]]) {
                        listModel.payment = constructDic[@"payment"];
                        listModel.workItems = constructDic[@"workItems"];
                        listModel.signinTime = constructDic[@"signinTime"];
                        listModel.payStatus = constructDic[@"payStatus"];
                        listModel.indentType = dic[@"orderType"];
                        listModel.beforePhotos = constructDic[@"beforePhotos"];
                        
                        NSInteger startTime = [constructDic[@"startTime"] integerValue];
//                        NSInteger endTime = [constructDic[@"endTime"] integerValue];
                        NSInteger endTime;
                        NSInteger fenNum;
                        NSInteger shiNum;
                        NSInteger chaTime;
                        if ([constructDic[@"endTime"] isKindOfClass:[NSNull class]]) {
                            endTime = 0;
                            chaTime = 0;
                        }else{
                            endTime = [constructDic[@"endTime"] integerValue];
                            chaTime = endTime - startTime;
                        }
                        
                        
//                        chaTime = endTime - startTime;
                        
                        fenNum = (chaTime/1000/60)%60;
                        shiNum = chaTime/1000 /3600;
                        
                        if(shiNum > 0) {
                            listModel.workTime = [NSString stringWithFormat:@"%ld小时%ld分", shiNum, fenNum];
                        }else {
                            listModel.workTime = [NSString stringWithFormat:@"%ld分", fenNum];
                        }
                        

                        
                    }else{
                        listModel.payment = @"0";
                        listModel.workTime = @"0分";
                    }
                    
                    
                    // 员工姓名添加
                    NSDictionary *tech = dic[@"mainTech"];
                    NSDictionary *seTech = dic[@"secondTech"];
                    if(![tech isKindOfClass:[NSNull class]]) {
                        
                        [_workNameArr addObject:tech[@"name"]];
                    }
                    
                    if(![seTech isKindOfClass:[NSNull class]]) {
                        
                        [_workNameArr addObject:seTech[@"name"]];
                    }
                    
                }
                
                
                
                
                
                listModel.workerArr = _workNameArr;
                
                [self.modelArr addObject:listModel];
    
                
                // 施工部位
                NSString *path = [[NSBundle mainBundle] pathForResource:@"WorkItemDic" ofType:@"plist"];
                NSDictionary *itemDic = [NSDictionary dictionaryWithContentsOfFile:path];
                NSString *workItemsStr = [[NSString alloc] init];
//                NSLog(@"订单类型%@", dic[@"orderType"]);
                
                if ([dic[@"orderType"] integerValue] == 4) {
                    workItemsStr = @"美容清洁";
                    
                    
                    [self.workItemArr addObject:workItemsStr];
                }else{
                    if([listModel.workItems isKindOfClass:[NSNull class]]) {
                        
                        workItemsStr = @"无";
                        
                        
                        [self.workItemArr addObject:workItemsStr];
                        
                        
                    }else if (listModel.workItems == NULL){
                        workItemsStr = @"无";
                        
                        [self.workItemArr addObject:workItemsStr];
                    }else {
                        
                        NSArray *strArr = [listModel.workItems componentsSeparatedByString:@","];
                        for(NSString *str in strArr) {
                            if(workItemsStr.length == 0) {
                                workItemsStr = [NSString stringWithFormat:@"%@", itemDic[str]];
                            }else {
                                workItemsStr = [NSString stringWithFormat:@"%@,%@", workItemsStr, itemDic[str]];
                            }
                        }
                        
                        [self.workItemArr addObject:workItemsStr];
                        
                    }
                
                }
                

           
            
            }
            

            
            
            
        }else {
            
//            NSLog(@"请求失败+++++++++++%@", responseObject);
            self.tableview.userInteractionEnabled = YES;
        }
        [self.tableview reloadData];
        self.tableview.userInteractionEnabled = YES;
        [self.tableview.header endRefreshing];
        
    } failure:^(NSError *error) {
        
//        NSLog(@"网络请求失败－－－%@--",error);

        self.tableview.userInteractionEnabled = YES;
        [self.tableview.header endRefreshing];
        [self addAlertView:@"请求失败"];
        
    }];

    
}

- (void)footRefresh {
    if (page == 1) {
        page = 2;
    }
//    NSLog(@"大脚刷新");
    pageSize = 2;
//    NSString *urlStr = curUrl;
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"curUrlId"] = [NSString stringWithFormat:@"%ld", curUrlId];
    mDic[@"page"] = [NSString stringWithFormat:@"%ld", ++page];
    mDic[@"pageSize"] = [NSString stringWithFormat:@"%ld", pageSize];
    
    [GFHttpTool indentGetWithParameters:mDic success:^(id responseObject) {
        
        NSInteger flage = [responseObject[@"result"] integerValue];
        
        if(flage == 1) {
            
//            NSLog(@"请求成功+++++++++++%@", responseObject);
            
//            NSLog(@"请求成功+++++++++++%@", responseObject);
            
            NSDictionary *dataDic = responseObject[@"data"];
            
            NSArray *listArr = dataDic[@"list"];
            
            if (listArr.count == 0 ) {
                [self addAlertView:@"已加载全部"];
            }
            
//            NSLog(@"%@*******", listArr);
            extern NSString* const URLHOST;
            for(NSDictionary *dic in listArr) {
                
                _workNameArr = [[NSMutableArray alloc] init];
                
                GFIndentModel *listModel = [[GFIndentModel alloc] init];
                listModel.orderNum = dic[@"orderNum"];
                listModel.photo = [NSString stringWithFormat:@"%@%@",URLHOST,dic[@"photo"]];
                listModel.remark = dic[@"remark"];
                listModel.commentDictionary = dic[@"comment"];
                listModel.indentType = dic[@"orderType"];
                if([curUrl isEqualToString:mainUrl]) {
                    NSDictionary *constructDic = dic[@"mainConstruct"];
                    if ([constructDic isKindOfClass:[NSNull class]]) {
                    
                        listModel.payment = @"0";
                        listModel.workTime = @"0分";
                       
                    }else{
                        listModel.payment = constructDic[@"payment"];
                        listModel.workItems = constructDic[@"workItems"];
                        listModel.signinTime = constructDic[@"signinTime"];
                        listModel.payStatus = constructDic[@"payStatus"];
                        
                        NSInteger startTime = [constructDic[@"startTime"] integerValue];
                        NSInteger endTime;
                        NSInteger chaTime;
                        if ([constructDic[@"endTime"] isKindOfClass:[NSNull class]]) {
                            endTime = 0;
                            chaTime = 0;
                        }else{
                            endTime = [constructDic[@"endTime"] integerValue];
                            chaTime = endTime - startTime;
                        }
                        
                        
                        NSInteger fenNum = (chaTime/1000/60)%60;
                        NSInteger shiNum = chaTime/1000 /3600;
                        
                        if(shiNum > 0) {
                            listModel.workTime = [NSString stringWithFormat:@"%ld小时%ld分", shiNum, fenNum];
                        }else {
                            listModel.workTime = [NSString stringWithFormat:@"%ld分", fenNum];
                        }
                    }
                    
                    // 员工姓名添加
                    NSDictionary *tech = dic[@"mainTech"];
                    NSDictionary *seTech = dic[@"secondTech"];
                    if(![tech isKindOfClass:[NSNull class]]) {
                        
                        [_workNameArr addObject:tech[@"name"]];
                    }
                    
                    if(![seTech isKindOfClass:[NSNull class]]) {
                        
                        [_workNameArr addObject:seTech[@"name"]];
                    }
                    
                    
                }else if([curUrl isEqualToString:seconderUrl]) {
                    
                    NSDictionary *constructDic = dic[@"secondConstruct"];
                    
                    if ([constructDic isKindOfClass:[NSNull class]]) {
                        
                        listModel.payment = @"0";
                        listModel.workTime = @"0分";
                        
                    }else{
                        listModel.payment = constructDic[@"payment"];
                        listModel.workItems = constructDic[@"workItems"];
                        listModel.signinTime = constructDic[@"signinTime"];
                        listModel.payStatus = constructDic[@"payStatus"];
                        
                        NSInteger startTime = [constructDic[@"startTime"] integerValue];
                        
                        NSInteger endTime;
                        NSInteger fenNum;
                        NSInteger shiNum;
                        NSInteger chaTime;
                        if ([constructDic[@"endTime"] isKindOfClass:[NSNull class]]) {
                            endTime = 0;
                            chaTime = 0;
                        }else{
                            endTime = [constructDic[@"endTime"] integerValue];
                            chaTime = endTime - startTime;
                        }
                        
//                        chaTime = endTime - startTime;
                        fenNum = (chaTime/1000/60)%60;
                        shiNum = chaTime/1000 /3600;
                        if(shiNum > 0) {
                            listModel.workTime = [NSString stringWithFormat:@"%ld小时%ld分", (long)shiNum, (long)fenNum];
                        }else {
                            listModel.workTime = [NSString stringWithFormat:@"%ld分", (long)fenNum];
                        }
                    }
                    
                    // 员工姓名添加
                    NSDictionary *tech = dic[@"mainTech"];
                    NSDictionary *seTech = dic[@"secondTech"];
                    if(![tech isKindOfClass:[NSNull class]]) {
                        
                        [_workNameArr addObject:tech[@"name"]];
                    }
                    
                    if(![seTech isKindOfClass:[NSNull class]]) {
                        
                        [_workNameArr addObject:seTech[@"name"]];
                    }
                }
                
                
                listModel.workerArr = _workNameArr;
                [self.modelArr addObject:listModel];
                
                // 施工部位
                NSString *path = [[NSBundle mainBundle] pathForResource:@"WorkItemDic" ofType:@"plist"];
                NSDictionary *itemDic = [NSDictionary dictionaryWithContentsOfFile:path];
                NSString *workItemsStr = [[NSString alloc] init];
//                NSLog(@"订单类型%@", dic[@"orderType"]);
                
                if ([dic[@"orderType"] integerValue] == 4) {
                    workItemsStr = @"美容清洁";
                    
                    
                    [self.workItemArr addObject:workItemsStr];
                }else{
                    if([listModel.workItems isKindOfClass:[NSNull class]]) {
                        
                        workItemsStr = @"无";
                        
                        
                        [self.workItemArr addObject:workItemsStr];
                        
                        
                    }else if (listModel.workItems == NULL){
                        workItemsStr = @"无";
                        
                        [self.workItemArr addObject:workItemsStr];
                    }else {
                        
                        NSArray *strArr = [listModel.workItems componentsSeparatedByString:@","];
                        for(NSString *str in strArr) {
                            if(workItemsStr.length == 0) {
                                workItemsStr = [NSString stringWithFormat:@"%@", itemDic[str]];
                            }else {
                                workItemsStr = [NSString stringWithFormat:@"%@,%@", workItemsStr, itemDic[str]];
                            }
                        }
                        
                        [self.workItemArr addObject:workItemsStr];
                        
                    }
                }
                
                
                
                
            }
                

            [self.tableview reloadData];
            
        }else {
            
//            NSLog(@"请求失败+++++++++++%@", responseObject);
            
        }
        
        [self.tableview.footer endRefreshing];
        
    } failure:^(NSError *error) {
        
//        NSLog(@"网络请求失败");
        
         [self addAlertView:@"请求失败"];
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
    if ([cell.moneyLab.text isEqualToString:@"￥0"]) {
        cell.timeLab.text = @"施工时间：无";
    }else{
        // 开始时间
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.signinTime floatValue]/1000];
        cell.timeLab.text = [NSString stringWithFormat:@"施工时间：%@", [formatter stringFromDate:date]];
    }
    
    cell.placeLab.text = [NSString stringWithFormat:@"施工部位：%@", _workItemArr[indexPath.row]];

    


    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return kHeight * 0.464 + kHeight * 0.0183;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


//    NSLog(@"++++++++++++++\n%@\n\n", self.workItemArr);
    
    GFIndentDetailsViewController *indentDeVC = [[GFIndentDetailsViewController alloc] init];
    indentDeVC.model = self.modelArr[indexPath.row];
    indentDeVC.workItems = self.workItemArr[indexPath.row];
    [self.navigationController pushViewController:indentDeVC animated:YES];
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
