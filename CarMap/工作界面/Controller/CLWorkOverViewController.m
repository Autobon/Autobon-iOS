//
//  CLWorkOverViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLWorkOverViewController.h"
#import "GFNavigationView.h"
#import "CLTitleView.h"
#import "GFMyMessageViewController.h"
#import "CLShareViewController.h"
#import "GFHttpTool.h"
#import "MYImageView.h"
#import "GFTipView.h"
#import "CLHomeOrderViewController.h"
#import "GFAlertView.h"
#import "GFBuweiModel.h"
#import "GFProjectView.h"
#import "CLHomeOrderCellModel.h"
#import "GFImageView.h"

#import "GFAddpeoModel.h"
#import "GFAlertView.h"
#import "GFFangqiViewController.h"
#import "MJRefresh.h"
#import "GFAddPeoTableViewCell.h"
#import "CLTouchView.h"


@interface CLWorkOverViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GFProjectViewDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>
{
    UIView *_chooseView;
    UIButton *_carImageButton;
    UIButton *_cameraBtn;
    NSMutableArray *_imageArray;
    NSMutableArray *_buttonArray;
    NSArray *_workItemarray;
//    NSMutableArray *_workItemBtnArray;
    NSMutableArray *_workItemIdArray;
    UIScrollView *_scrollView;
    NSMutableArray *_fiveItemArray;
    NSMutableArray *_fiveItemIdArray;
    NSMutableArray *_sevenItemArray;
    NSMutableArray *_sevenItemIdArray;
    UICollectionView *_collectionView;
    
    UILabel *_distanceLabel;
    
    NSTimer *_timer;
    
    
    NSMutableArray *_buweiModelArr;
    
    
    CLTitleView *_titleView;
    
    GFNavigationView *_navView;
    
}

/**
 *  施工项目选择页面属性
 */
@property (nonatomic, strong) NSMutableArray *proArr;  // 施工项目数组
@property (nonatomic, strong) NSMutableArray *proIdArr;
@property (nonatomic, strong) NSMutableArray *buweiArr; // 施工部位数组
@property (nonatomic, strong) NSMutableArray *buweiIdArr;
@property (nonatomic, strong) NSMutableArray *buweiOOArr;
@property (nonatomic, strong) NSMutableArray *peoArr;  // 施工人员数组
@property (nonatomic, strong) NSMutableArray *peoIdArr;
@property (nonatomic, strong) NSMutableArray *proViewArr;   // 施工项目View数组

@property (nonatomic, strong) NSMutableDictionary *bbppDic; // 施工部位对应的操作人的字典
@property (nonatomic, strong) NSMutableArray *bbppArr;      // 施工部位对应的操作人的字典数组
@property (nonatomic, strong) NSMutableArray *baofeiArr;    // 报废按钮
@property (nonatomic, strong) NSMutableArray *baofeiProArr; // 报废项目数组
@property (nonatomic, strong) NSMutableArray *baofeiDicMarr;
@property (nonatomic, assign) CGFloat baofeiH;

@property (nonatomic, assign) CGFloat vvhh;
@property (nonatomic, assign) CGFloat maxVV;
@property (nonatomic, strong) NSMutableArray *maxVVArr;
@property (nonatomic, assign) CGPoint conoffSet;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIScrollView *scView;

@property (nonatomic, strong) UIButton *proButSelect;

@property (nonatomic, strong) NSMutableArray *photoUrlArr;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UISearchBar *seatchBar;
@property (nonatomic, assign) NSInteger ppage;
@property (nonatomic, assign) NSInteger ppageSize;
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) UIView *bbView;
@property (nonatomic, strong) UIPickerView *timePickerView;
@property (nonatomic, strong) UIButton *selBaofeiBut;
@property (nonatomic, strong) NSMutableArray *baifeiSelArr;
@property (nonatomic, strong) NSMutableArray *baofeiNorArr;

@property (nonatomic, strong) NSArray *messageArr;
@property (nonatomic, strong) UIView *proButView;

@property (nonatomic, copy) NSString *curNum;
//*****//*****//*****//*****//*****//*****//*****//*****//*****//*****//
@end

@implementation CLWorkOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageArray = [[NSMutableArray alloc]init];
    _buttonArray = [[NSMutableArray alloc]init];
    _buweiOOArr = [[NSMutableArray alloc] init];
    _scrollView = [[UIScrollView alloc]init];
//    _scrollView.frame = CGRectMake(0, 64+36, self.view.frame.size.width, self.view.frame.size.height-64-38);

    [self.view addSubview:_scrollView];
    
    self.photoUrlArr = [[NSMutableArray alloc] init];
    
    
    [self setNavigation];
    
    [self setDate];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom).offset(36);
    }];
    
    [self titleView];
    
    
    [self startTimeForNows];
    
}

#pragma mark - 设置日期和状态
- (void)setDate{
    UIView *headerView = [[UIView alloc]init];
   headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 20)];
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-120, 8, 100, 20)];
    stateLabel.text = @"即将完成模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:stateLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 36, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
    [headerView addSubview:view];
    
//    NSLog(@"设置日期和时间");
    //    headerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.height.mas_offset(36);
    }];
    
}


#pragma mark - 获取周几
- (NSString *)weekdayString{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"zh_CN"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
//    NSLog(@"---dateString--%@---",dateString);
    
    NSString *timeString = [NSString stringWithFormat:@"%@  %@",dateString,[weekdays objectAtIndex:theComponents.weekday]];
    return timeString;
    
}


#pragma mark - 获取开始时间计算用时
- (void)startTimeForNows{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_startTime floatValue]/1000];
    NSInteger time = (NSInteger)[[NSDate date] timeIntervalSince1970] - [_startTime floatValue]/1000;
    
//    NSLog(@"--时间戳-%ld", time);
        NSInteger minute = time/60;
        if (minute > 60) {
            _distanceLabel.text = [NSString stringWithFormat:@"已用时：%ld时 %ld分",minute/60,minute%60];
        }else{
//            NSLog(@"----shezhi时间");
            _distanceLabel.text = [NSString stringWithFormat:@"已用时： %ld分钟",(long)minute];
            
        }
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(timeForWork:) userInfo:@{@"time":@(time)} repeats:YES];
    }
    
}

- (void)timeForWork:(NSTimer *)timer{
    
//    NSLog(@"----%@----",timer.userInfo[@"time"]);
    static NSInteger a = 0;
    if (a == 0) {
        a = [timer.userInfo[@"time"] integerValue];
        
    }
    a = a + 60;
    NSInteger minute = a/60;
    if (minute > 60) {
        _distanceLabel.text = [NSString stringWithFormat:@"已用时：%ld时 %ld分",minute/60,minute%60];
    }else{
//        NSLog(@"----shezhi时间");
        _distanceLabel.text = [NSString stringWithFormat:@"已用时： %ld分钟",minute];
        
    }
}
- (void)headRefresh {
    
    self.modelArr = [[NSMutableArray alloc] init];
    self.ppage = 1;
    self.ppageSize = 20;
    [self addpeoHttpWork];
}
- (void)footRefresh {
    
    self.ppage = self.ppage + 1;
    self.ppageSize = 20;
    [self addpeoHttpWork];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    GFAddPeoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFAddPeoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if(self.modelArr.count > indexPath.row) {
    
        GFAddpeoModel *model = (GFAddpeoModel *)self.modelArr[indexPath.row];
        cell.model = model;
        [cell.addBut addTarget:self action:@selector(addPeoClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.addBut.tag = indexPath.row;
    }
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    // 取消选择状态
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
- (void)addPeoClick:(UIButton *)sender {
    
    
    
    
    GFAddpeoModel *model = (GFAddpeoModel *)self.modelArr[sender.tag];
    for(int i=0; i<_peoIdArr.count; i++) {
        
        NSString *ss = [NSString stringWithFormat:@"%@", _peoIdArr[i]];
        if([ss isEqualToString:model.jishiId]) {
            
            UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该技师已经添加，请重新选择。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [aView show];
            return;
        }
    }
    [self.baseView removeFromSuperview];
    [self.peoIdArr addObject:model.jishiId];
    [_peoArr addObject:model.name];
    [_scView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self _setSC];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(_scView.frame)+20);
    }];
}
- (void)setAddPeoView {
    
    self.modelArr = [[NSMutableArray alloc] init];
    UIView *vv = [[UIView alloc] init];
    vv.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    vv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:vv];
    self.baseView = vv;
//    vv.layer.cornerRadius = 7;
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(20, 50, vv.frame.size.width - 40, vv.frame.size.height - 60)];
    baseView.backgroundColor = [UIColor whiteColor];
    baseView.layer.cornerRadius = 7;
    [vv addSubview:baseView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, baseView.frame.size.width, baseView.frame.size.height - 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    _tableView.allowsSelection = NO;
    [baseView addSubview:_tableView];
    
    
    self.seatchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 10, baseView.frame.size.width - 70, 40)];
    self.seatchBar.barTintColor = [UIColor whiteColor];
    self.seatchBar.layer.cornerRadius = 20;
    self.seatchBar.layer.borderWidth = 1.0;
    self.seatchBar.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]CGColor];
    [baseView addSubview:self.seatchBar];
    self.seatchBar.clipsToBounds = YES;
    self.seatchBar.placeholder = @"请输入";
    
    UIButton *searchBut = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBut.frame = CGRectMake(baseView.frame.size.width - 60, 10, 50, 40);
    [searchBut setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [baseView addSubview:searchBut];
    searchBut.titleLabel.font = [UIFont systemFontOfSize:16];
    searchBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [searchBut addTarget:self action:@selector(seaButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 0, 70, 50);
    [but setTitle:@"关闭" forState:UIControlStateNormal];
    [vv addSubview:but];
    [but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)butClick {
    
    [self.baseView removeFromSuperview];
}
- (void)seaButClick {
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)addpeoHttpWork {
    
//    NSLog(@"jhljkhl;khkjlhjlkkj46465456453%@", self.seatchBar.text);
    [self.view endEditing:YES];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"query"] = self.seatchBar.text;
    mDic[@"page"] = @(self.ppage);
    mDic[@"pageSize"] = @(self.ppageSize);
    [GFHttpTool searPeoGetWithParameters:mDic success:^(id responseObject) {
        
//        NSLog(@"%@", responseObject);
        
        if([responseObject[@"status"] integerValue] == 1) {
            
            NSDictionary *dic = responseObject[@"message"];
            NSArray *arr = dic[@"list"];
            if(self.ppage <= [dic[@"totalPages"] integerValue]) {
                
                for(NSDictionary *ddd in arr) {
                    
                    GFAddpeoModel *model = [[GFAddpeoModel alloc] initWithdictionary:ddd];
                    [self.modelArr addObject:model];
                }
            }
            
            if(self.ppage >= [dic[@"totalPages"] integerValue]) {
                
                [self addAlertView:@"已加载完毕"];
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)titleView{
    
    self.curNum = @"0";
    
//    NSLog(@"－1457600262000－－已用时－－%@--",_startTime);
    
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 20)];
//    _distanceLabel.text = @"已用时：15分28秒";
    _distanceLabel.backgroundColor = [UIColor whiteColor];
    _distanceLabel.font = [UIFont systemFontOfSize:15];
    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_distanceLabel];
    
    CLTitleView *photoTitle = [[CLTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_distanceLabel.frame)+10, self.view.frame.size.width, 45) Title:@"上传工作完成车辆照片"];
    UILabel *photoLabel = [[UILabel alloc]init];
    photoLabel.text = @"不少于3张";
    photoLabel.font = [UIFont systemFontOfSize:16];
    photoLabel.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0];
    photoLabel.frame = CGRectMake(190, 8, 120, 35);
    [photoTitle addSubview:photoLabel];
    
    [_scrollView addSubview:photoTitle];
    
    
    _carImageButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7, CGRectGetMaxY(photoTitle.frame)+10, self.view.frame.size.width*5/7, self.view.frame.size.width*27/70)];
//    _carImageView.image = [UIImage imageNamed:@"carImage"];
    [_carImageButton setBackgroundImage:[UIImage imageNamed:@"carImage"] forState:UIControlStateNormal];
    [_carImageButton addTarget:self action:@selector(userChoosePhoto) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_carImageButton];
    
    _cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_carImageButton.frame)-15, CGRectGetMaxY(_carImageButton.frame)-20, 30, 30)];
    [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(userChoosePhoto) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_cameraBtn];
    
    
    
    
    CLTitleView *titleView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 40 + self.view.frame.size.width+30, self.view.frame.size.width, 45) Title:@"选择本次负责的工作项"];
    _titleView = titleView;
    [_scrollView addSubview:titleView];
    
    // 添加合伙人按钮
    UIButton *addBut = [UIButton buttonWithType:UIButtonTypeCustom];
    addBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 85, _titleView.frame.origin.y + 3, 80, 39);
    [addBut setImage:[UIImage imageNamed:@"addPa"] forState:UIControlStateNormal];
    [addBut setTitle:@" 添加合伙人" forState:UIControlStateNormal];
    addBut.titleLabel.font = [UIFont systemFontOfSize:12];
    [addBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    addBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_scrollView addSubview:addBut];
    [addBut addTarget:self action:@selector(addButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIButton *fiveButton = [[UIButton alloc]initWithFrame:CGRectMake(10, titleView.frame.origin.y+50, 100, 30)];
////    fiveButton.backgroundColor = [UIColor cyanColor];
//    [fiveButton setTitle:@"五座车" forState:UIControlStateNormal];
//    [fiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    fiveButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    [fiveButton setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateNormal];
//    [fiveButton addTarget:self action:@selector(workItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    fiveButton.tag = 5;
//    [_scrollView addSubview:fiveButton];
//    
//    UIButton *sevenButton = [[UIButton alloc]initWithFrame:CGRectMake(130, titleView.frame.origin.y+50, 100, 30)];
////    sevenButton.backgroundColor = [UIColor cyanColor];
//    [sevenButton setTitle:@"七座车" forState:UIControlStateNormal];
//    [sevenButton setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
//    sevenButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    [sevenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [sevenButton addTarget:self action:@selector(workItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    sevenButton.tag = 7;
//    [_scrollView addSubview:sevenButton];
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleView.frame.origin.y+95, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];

    
//    _fiveItemArray = [[NSMutableArray alloc]init];
//    _sevenItemArray = [[NSMutableArray alloc]init];
//    _fiveItemIdArray = [[NSMutableArray alloc]init];
//    _sevenItemIdArray = [[NSMutableArray alloc]init];
    
    _buweiModelArr = [[NSMutableArray alloc] init];
    
//    NSLog(@"--订单ID－－-%@", _orderId);
    
    [GFHttpTool GetWorkItemsOrderTypeId:[_orderId integerValue] success:^(NSDictionary *responseObject) {
        
//        _proArr = [[NSMutableArray alloc] init];
//        _proIdArr = [[NSMutableArray alloc] init];
//        _buweiArr = [[NSMutableArray alloc] init];
//        _buweiIdArr = [[NSMutableArray alloc] init];
        
//        NSLog(@"－  施工部位，，，－－%@---",responseObject);
        if(![responseObject[@"message"] isKindOfClass:[NSNull class]]) {
//
            self.messageArr = responseObject[@"message"];
//            if(self.messageArr.count > 0) {
//                
//                for(int i=0; i<self.messageArr.count; i++) {
//                    
//                    NSDictionary *dic = self.messageArr[i];
//                    GFBuweiModel *model = [[GFBuweiModel alloc] initWithDictionary:dic];
//                    [_buweiModelArr addObject:model];
//                    [_proArr addObject:model.proName];
//                    [_proIdArr addObject:model.proId];
//                    
//                    NSArray *buweiAA = model.buweiDicArr;
//                    NSMutableArray *bbArr = [[NSMutableArray alloc] init];
//                    NSMutableArray *bbIdArr = [[NSMutableArray alloc] init];
//                    NSMutableArray *bbOOArr = [[NSMutableArray alloc] init];
//                    for(NSDictionary *dic in buweiAA) {
//                        
//                        NSString *buwei = dic[@"name"];
//                        NSString *buweiID = dic[@"id"];
//                        [bbArr addObject:buwei];
//                        [bbIdArr addObject:buweiID];
//                        [bbOOArr addObject:@"0"];
//                    }
//                    [_buweiArr addObject:bbArr];
//                    [_buweiIdArr addObject:bbIdArr];
//                    [_buweiOOArr addObject:bbOOArr];
//                    
//                    // 施工项目按钮
//                    CGFloat butW = ([UIScreen mainScreen].bounds.size.width - 60) / 4.0;
//                    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//                    but.frame = CGRectMake(15 + (butW + 10) * i, CGRectGetMaxY(_titleView.frame) + 5, butW, 40);
//                    but.titleLabel.font = [UIFont systemFontOfSize:14];
//                    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
//                    but.layer.cornerRadius = 7.5;
//                    but.layer.borderWidth = 1.0;
//                    but.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//                    but.backgroundColor = [UIColor whiteColor];
//                    but.tag = i + 1;
//                    [but setTitle:_proArr[i] forState:UIControlStateNormal];
//                    [but addTarget:self action:@selector(proButClick:) forControlEvents:UIControlEventTouchUpInside];
//                    [_scrollView addSubview:but];
//                    if(i == 0) {
//                        
//                        _proButSelect = but;
//                        _proButSelect.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//                        _proButSelect.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
//                        _proButSelect.enabled = NO;
//                        //                but.selected = YES;
//                    }
//                }
//            }
        }
//
//        _peoArr = [[NSMutableArray alloc] init];
//        [_peoArr addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]];
//        _peoIdArr = [[NSMutableArray alloc] init];
//        [_peoIdArr addObject:_model.mainTechId];
//        NSLog(@"--jishiIDfffff--%@", _model.mainTechId);
//        // 添加合伙人按钮
//        UIButton *addBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        addBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 85, _titleView.frame.origin.y + 3, 80, 39);
//        [addBut setImage:[UIImage imageNamed:@"addPa"] forState:UIControlStateNormal];
//        [addBut setTitle:@" 添加合伙人" forState:UIControlStateNormal];
//        addBut.titleLabel.font = [UIFont systemFontOfSize:12];
//        [addBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
//        addBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [_scrollView addSubview:addBut];
//        [addBut addTarget:self action:@selector(addButClick) forControlEvents:UIControlEventTouchUpInside];
        _peoArr = [[NSMutableArray alloc] init];
        [_peoArr addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]];
        _peoIdArr = [[NSMutableArray alloc] init];
        [_peoIdArr addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"mainTechId"]];
//        NSLog(@"--jishiIDfffff--%@", _model.mainTechId);
        
        [self _setSC];
        
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(_scView.frame)+20);
        /*
        [messageArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if ([obj[@"seat"]integerValue] == 5) {
                [_fiveItemArray addObject:obj[@"name"]];
                [_fiveItemIdArray addObject:obj[@"id"]];
            }else{
                [_sevenItemArray addObject:obj[@"name"]];
                [_sevenItemIdArray addObject:obj[@"id"]];
            }
        }];
        
        _workItemarray = _fiveItemArray;
        _workItemIdArray = _fiveItemIdArray;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((self.view.frame.size.width-50)/4, 30);
        layout.minimumInteritemSpacing = 5.0f;
        layout.minimumLineSpacing = 5.0f;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, lineView.frame.origin.y + 5, self.view.frame.size.width , ((_workItemarray.count+1)/4 + 1)*35+10) collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_scrollView addSubview:_collectionView];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, _collectionView.frame.origin.y+_collectionView.frame.size.height+10, self.view.frame.size.width-20, 1)];
        lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [_scrollView addSubview:lineView2];
        
        UIButton *workOverButton = [[UIButton alloc]initWithFrame:CGRectMake(30, lineView2.frame.origin.y+30, self.view.frame.size.width-60, 50)];
        //    workOverButton.center = CGPointMake(self.view.center.x, self.view.center.y+50+36+50);
        [workOverButton setTitle:@"完成工作" forState:UIControlStateNormal];
        workOverButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        workOverButton.layer.cornerRadius = 10;
        
        [workOverButton addTarget:self action:@selector(workOverBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:workOverButton];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(workOverButton.frame)+20);
         */
        
    } failure:^(NSError *error) {
//        NSLog(@"失败了－－－%@---",error);
//        [self addAlertView:@"请求失败"];
    }];
    
//

    
    // 时间选择器
    _bbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _bbView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:_bbView];
    self.timePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 150)];
    self.timePickerView.dataSource = self;
    self.timePickerView.delegate = self;
    self.timePickerView.backgroundColor = [UIColor whiteColor];
    [_bbView addSubview:self.timePickerView];
    _bbView.hidden = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [_bbView addGestureRecognizer:tapGesture];
    
    
    
    
    
}



#pragma mark - UICollectionViewDataSource
//返回当前区有多少 item。每一个单独的元素就是一个 item。
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _workItemarray.count;
}
//配置每个 item。
- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    cell.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = [[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0]CGColor];

    
    UILabel* label = (UILabel *)[cell viewWithTag:5];
    if(!label){
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        label.tag = 5;
    }
    
    label.text = _workItemarray[indexPath.row];
    label.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:label];
    return cell;
}
#pragma mark - UICollectionViewDelegate
//选中某个 item。
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:5];
    if ([_buttonArray containsObject:_workItemIdArray[indexPath.row]]) {
        cell.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        label.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
        cell.layer.borderColor = [[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0]CGColor];
        [_buttonArray removeObject:_workItemIdArray[indexPath.row]];
    }else{
        
        cell.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        label.textColor = [UIColor whiteColor];
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        [_buttonArray addObject:_workItemIdArray[indexPath.row]];
    }
    
    
}



#pragma mark - 选择照片
- (void)userChoosePhoto{
    
    
    
    if (_chooseView == nil) {
        _chooseView = [[CLTouchView alloc]initWithFrame:self.view.bounds];
        _chooseView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        [self.view addSubview:_chooseView];
        
        UIView *chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 80)];
        chooseView.center = self.view.center;
        chooseView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        chooseView.layer.cornerRadius = 15;
        chooseView.clipsToBounds = YES;
        [_chooseView addSubview:chooseView];
        
        // 相机和相册按钮
        UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 40)];
        [cameraButton setTitle:@"相册" forState:UIControlStateNormal];
        [cameraButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
        cameraButton.tag = 1;
        [chooseView addSubview:cameraButton];
        
        UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-100, 40)];
        [photoButton setTitle:@"相机" forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
        photoButton.tag = 2;
        [chooseView addSubview:photoButton];
    }
    
    
    _chooseView.hidden = NO;
    
}

#pragma mark - 选择照片
- (void)userHeadChoose:(UIButton *)button{
    _chooseView.hidden = YES;
    //    _scrollView.userInteractionEnabled = YES;
    if (button.tag == 1) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate =self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        //        NSLog(@"打开相机");
        BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (result) {
            //            NSLog(@"---支持使用相机---");
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            // 编辑模式
            //            imagePicker.allowsEditing = YES;
            [self  presentViewController:imagePicker animated:YES completion:^{
            }];
        }else{
            //            NSLog(@"----不支持使用相机----");
        }
        
    }
    
    
}

#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_imageArray.count == 0) {
        _carImageButton.hidden = YES;
        GFImageView *imageView = [[GFImageView alloc]init];
        imageView.image = image;
        imageView.frame = CGRectMake(10, _carImageButton.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        _cameraBtn.frame = CGRectMake(20+(self.view.frame.size.width-40)/3, _carImageButton.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        [_cameraBtn setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width-30, 0, 30, 30)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.alpha = 0.5;
        [imageView addSubview:deleteBtn];
        
        imageView.tag = _imageArray.count;
        imageView.imageArray = _imageArray;
        
        [_imageArray addObject:imageView];
        [_scrollView addSubview:imageView];
        
    }else{
//        NSLog(@"小车不存在---%@--",@(_imageArray.count));
        GFImageView *imageView = [[GFImageView alloc]initWithFrame:CGRectMake(_cameraBtn.frame.origin.x, _cameraBtn.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3)];
        imageView.image = image;
        [_scrollView addSubview:imageView];
        
        if (_imageArray.count == 8) {
            _cameraBtn.hidden = YES;
        }else{
            _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        }
        
        
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width-30, 0, 30, 30)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.alpha = 0.5;
        
        imageView.tag = _imageArray.count;
        imageView.imageArray = _imageArray;
        
        [imageView addSubview:deleteBtn];
        [_imageArray addObject:imageView];
    }

    CGSize imagesize;
    if (image.size.width > image.size.height) {
        imagesize.width = 800;
        imagesize.height = image.size.height*800/image.size.width;
    }else{
        imagesize.height = 800;
        imagesize.width = image.size.width*800/image.size.height;
    }
    UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.8);
    
    GFImageView *imageView = [_imageArray objectAtIndex:_imageArray.count-1];
    [GFHttpTool PostImageForWork:imageData success:^(NSDictionary *responseObject) {
//        NSLog(@"上传成功－%@--－%@",responseObject,responseObject[@"message"]);
        if ([responseObject[@"status"] integerValue] == 1) {
            
            imageView.resultURL = responseObject[@"message"];
            [self.photoUrlArr addObject:imageView.resultURL];
        }else{

            [self addAlertView:@"图片上传失败"];
            _cameraBtn.frame = imageView.frame;
            [_imageArray removeLastObject];
            [imageView removeFromSuperview];
        }
        
    } failure:^(NSError *error) {
//        NSLog(@"上传失败原因－－%@--",error);
        [self addAlertView:@"图片上传失败"];
        _cameraBtn.frame = imageView.frame;
        [_imageArray removeLastObject];
        [imageView removeFromSuperview];
    }];
    
    
     
}
#pragma mark - 压缩图片尺寸
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
#pragma mark - 删除相片的方法
- (void)deleteBtnClick:(UIButton *)button{
//    NSLog(@"删除照片");
    
    UIImageView *imageView = (UIImageView *)[button superview];
    [imageView removeFromSuperview];
    [_imageArray removeObject:[button superview]];
    imageView = nil;
    
    [_imageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *stop) {
        
        obj.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*(idx%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*(idx/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }];
    
    if (_imageArray.count == 8) {
        _cameraBtn.hidden = NO;
    }else if (_imageArray.count == 0){
        _carImageButton.hidden = NO;
        _cameraBtn.frame = CGRectMake(CGRectGetMaxX(_carImageButton.frame)-15, CGRectGetMaxY(_carImageButton.frame)-20, 30, 30);
        [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor clearColor];
    }else{
        _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 五座车七座车按钮
- (void)workItemBtnClick:(UIButton *)button{
    
    
    [_buttonArray removeAllObjects];
    if (button.tag == 5) {
        [button setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateNormal];
        UIButton *severBtn = (UIButton *)[self.view viewWithTag:7];
        [severBtn setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
        
        _workItemarray = _fiveItemArray;
        _workItemIdArray = _fiveItemIdArray;
        [_collectionView reloadData];
        
    }else{
        [button setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateNormal];
        UIButton *fiveBtn = (UIButton *)[self.view viewWithTag:5];
        [fiveBtn setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
        _workItemarray = _sevenItemArray;
        _workItemIdArray = _sevenItemIdArray;
        [_collectionView reloadData];
    
}
    
    
    
}
#pragma mark - 工作完成的按钮响应方法
- (void)workOverBtnClick{
    
    
    
    
    
    NSString *carSeat;
    if (_workItemarray.count < _sevenItemArray.count) {
//        NSLog(@"五座车");
        carSeat = @"5";
    }else{
//        NSLog(@"七座车");
        carSeat = @"7";
    }
    
    __block NSString *itemIdString;
    
    
    __block NSString *URLString;
// 判断图片个数
    if (_imageArray.count > 2) {
        [_imageArray enumerateObjectsUsingBlock:^(GFImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"imageURL---%@--",obj.resultURL);
            if (idx == 0) {
                URLString = obj.resultURL;
            }else{
                URLString = [NSString stringWithFormat:@"%@,%@",URLString,obj.resultURL];
            }
        }];

    // 判断是否选择工作项
        if (_buttonArray.count > 0) {
            [_buttonArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                if (idx == 0) {
                    itemIdString = obj;
                }else{
                    itemIdString = [NSString stringWithFormat:@"%@,%@",itemIdString,obj];
                }
            }];
//            NSLog(@"----itemIdString---%@---",itemIdString);
            
            NSDictionary *dictionary = @{@"orderId":_orderId,@"afterPhotos":URLString,@"workItems":itemIdString,@"carSeat":carSeat};
//            NSLog(@"----dictionary---%@--",dictionary);
            
            [GFHttpTool PostOverDictionary:dictionary success:^(NSDictionary *responseObject) {
//                NSLog(@"请求成功--%@--",responseObject);
                if ([responseObject[@"result"] integerValue] == 1) {
                    [_timer invalidate];
                    _timer = nil;
                    
                    CLShareViewController *homeOrder = [[CLShareViewController alloc]init];
                    homeOrder.orderNumber = self.orderNumber;
//                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeOrder];
//                    navigation.navigationBarHidden = YES;
//                    window.rootViewController = navigation;
                    [self.navigationController pushViewController:homeOrder animated:YES];
                    
                    
                    
                }else{
                    [self addAlertView:responseObject[@"message"]];
                }
                
                
                
            } failure:^(NSError *error) {
//                NSLog(@"----请求失败了--%@--",error);
//                [self addAlertView:@"提交失败"];
            }];
            
            
            
        }else{
//            [self addAlertView:@"请选择工作项"];
            
            [self removeOrderBtnClick];
            
            
        }
        
        
        
       
    }else{
        [self addAlertView:@"至少上传三张照片"];
    }
    
//    NSLog(@"----URLString----%@---",URLString);
    
    
    
    
    
//    CLShareViewController *shareView = [[CLShareViewController alloc]init];
//    [self.navigationController pushViewController:shareView animated:YES];
    
}

#pragma mark - 确定不选择工作项提示框
- (void)removeOrderBtnClick{
    GFAlertView *alertView = [[GFAlertView alloc]initWithTitle:@"确认不选择工作项吗？" leftBtn:@"取消" rightBtn:@"确定"];
    [alertView.rightButton addTarget:self action:@selector(workOver) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertView];
}

- (void)workOver{
    
    
    NSString *carSeat;
    if (_workItemarray.count < _sevenItemArray.count) {
        //        NSLog(@"五座车");
        carSeat = @"5";
    }else{
        //        NSLog(@"七座车");
        carSeat = @"7";
    }
    
    
    __block NSString *URLString;
    // 判断图片个数
    if (_imageArray.count > 2) {
        [_imageArray enumerateObjectsUsingBlock:^(GFImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //            NSLog(@"imageURL---%@--",obj.resultURL);
            if (idx == 0) {
                URLString = obj.resultURL;
            }else{
                URLString = [NSString stringWithFormat:@"%@,%@",URLString,obj.resultURL];
            }
        }];
    }
    NSDictionary *dictionary = @{@"orderId":_orderId,@"afterPhotos":URLString,@"workItems":@"",@"carSeat":carSeat};
//    NSLog(@"----dictionary---%@--",dictionary);
    
    [GFHttpTool PostOverDictionary:dictionary success:^(NSDictionary *responseObject) {
        //                NSLog(@"请求成功--%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            [_timer invalidate];
            _timer = nil;
             
            CLShareViewController *homeOrder = [[CLShareViewController alloc]init];
            homeOrder.orderNumber = self.orderNumber;
            //                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
            //                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeOrder];
            //                    navigation.navigationBarHidden = YES;
            //                    window.rootViewController = navigation;
            [self.navigationController pushViewController:homeOrder animated:YES];
            
            
            
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
        
        
        
    } failure:^(NSError *error) {
        //                NSLog(@"----请求失败了--%@--",error);
        //                [self addAlertView:@"提交失败"];
    }];
    
    
}



#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

// 添加导航
- (void)setNavigation{
    
    
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"person" withRightImgHightName:@"personClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightBut addTarget:_navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *removeOrderButton = [[UIButton alloc]init];
    removeOrderButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //    removeOrderButton.backgroundColor = [UIColor grayColor];
//    removeOrderButton.layer.borderColor = [[UIColor whiteColor] CGColor];
//    removeOrderButton.layer.borderWidth = 1;
//    removeOrderButton.layer.cornerRadius = 20;
    [removeOrderButton setTitle:@"改派" forState:UIControlStateNormal];
    if([_model.status isEqualToString:@"IN_PROGRESS"] || [_model.status isEqualToString:@"SIGNED_IN"] || [_model.status isEqualToString:@"AT_WORK"]) {
        
        [removeOrderButton setTitle:@"改派" forState:UIControlStateNormal];
    }
    [removeOrderButton setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [removeOrderButton addTarget:self action:@selector(removeOrderBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:removeOrderButton];
    
    
    [removeOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_navView).offset(-4);
        make.right.equalTo(_navView).offset(-45);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    
    [self.view addSubview:_navView];
}
- (void)backBtnClick{
    [_timer invalidate];
    _timer = nil;
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    GFMyMessageViewController *myMessage = [[GFMyMessageViewController alloc]init];
//    [self.navigationController pushViewController:myMessage animated:YES];
}

//*****//*****//*****//*****//*****//*****//*****//*****//*****//*****//
//*****//*****//*****//*****//*****//*****//*****//*****//*****//*****//
#pragma mark - 施工项目选择版块
- (UIView *)_setBaofeiView:(NSArray *)buweiArr withMaxY:(CGFloat)baofeiY withPage:(NSInteger)page {
    
    UIView *vv = [[UIView alloc] init];
    vv.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * (page), baofeiY, [UIScreen mainScreen].bounds.size.width, 0);
    vv.backgroundColor = [UIColor clearColor];
    [self.scView addSubview:vv];
    
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 10 * 5) / 4;
    CGFloat h = 30;
    CGFloat y = 10;
    
    
    CLTitleView *titleView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, -2, self.view.frame.size.width, 45) Title:@"材料耗损"];
    [vv addSubview:titleView];
    
    [_baofeiProArr addObject:[[NSMutableArray alloc] init]];
    
    for(int i=0; i<buweiArr.count; i++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.tag = i + 1;
        but.titleLabel.font = [UIFont systemFontOfSize:10];
        [but setTitle:buweiArr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageNamed:@"but_normal"] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"but_selected"] forState:UIControlStateSelected];
        but.frame = CGRectMake((10 + w) * (i % 4) + 10, y + (i / 4) * (h + y) + 45, w, h);
        [vv addSubview:but];
        [but addTarget:self action:@selector(baofeiButClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSInteger allNum = buweiArr.count;
    
    if(allNum % 4 == 0) {
        
        _baofeiH = y + (buweiArr.count / 4) * (h + y) + 30;
    }else {
        
        _baofeiH = y + (buweiArr.count / 4 + 1) * (h + y) + 30;
    }
    
    vv.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * (page), baofeiY, [UIScreen mainScreen].bounds.size.width, _baofeiH);
    
    return vv;
}
- (void)_setSC {
    
    _proArr = [[NSMutableArray alloc] init];
    _proIdArr = [[NSMutableArray alloc] init];
    _buweiArr = [[NSMutableArray alloc] init];
    _buweiIdArr = [[NSMutableArray alloc] init];

    
    _scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150)];
    _scView.delegate = self;
    [_scrollView addSubview:_scView];
    _scView.directionalLockEnabled = YES;
    _scView.alwaysBounceVertical = YES;
    _scView.bounces = NO;
    _scrollView.bounces = NO;
//    _scView.backgroundColor = [UIColor redColor];

    self.proButView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    self.proButView.backgroundColor = [UIColor whiteColor];
    [_scView addSubview:self.proButView];
    
    for(int i=0; i<self.messageArr.count; i++) {
        
        NSDictionary *dic = self.messageArr[i];
        GFBuweiModel *model = [[GFBuweiModel alloc] initWithDictionary:dic];
        [_buweiModelArr addObject:model];
        [_proArr addObject:model.proName];
        [_proIdArr addObject:model.proId];
        
        NSArray *buweiAA = model.buweiDicArr;
        NSMutableArray *bbArr = [[NSMutableArray alloc] init];
        NSMutableArray *bbIdArr = [[NSMutableArray alloc] init];
        NSMutableArray *bbOOArr = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in buweiAA) {
            
            NSString *buwei = dic[@"name"];
            NSString *buweiID = dic[@"id"];
            [bbArr addObject:buwei];
            [bbIdArr addObject:buweiID];
            [bbOOArr addObject:@"0"];
        }
        [_buweiArr addObject:bbArr];
        [_buweiIdArr addObject:bbIdArr];
        [_buweiOOArr addObject:bbOOArr];
        
        // 施工项目按钮
        CGFloat butW = ([UIScreen mainScreen].bounds.size.width - 60) / 4.0;
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(15 + (butW + 10) * i, 5, butW, 40);
        but.titleLabel.font = [UIFont systemFontOfSize:14];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        but.layer.cornerRadius = 7.5;
        but.layer.borderWidth = 1.0;
        but.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        but.backgroundColor = [UIColor whiteColor];
        but.tag = i + 1;
        [but setTitle:_proArr[i] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(proButClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.proButView addSubview:but];
        if(i == 0) {
            
            _proButSelect = but;
            _proButSelect.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
            _proButSelect.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
            _proButSelect.enabled = NO;
            //                but.selected = YES;
        }
    }
    
    _page = 1;
    _proViewArr = [[NSMutableArray alloc] init];
    _bbppDic = [[NSMutableDictionary alloc] init];
    
//    _scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame) + 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200)];
//    _scView.delegate = self;
//    [_scrollView addSubview:_scView];
//    _scView.directionalLockEnabled = YES;
//    _scView.alwaysBounceVertical = YES;
//    _scView.bounces = NO;
//    _scrollView.bounces = NO;

    
    _maxVVArr = [[NSMutableArray alloc] init];
    for(int m=0; m<_proArr.count; m++) {
        
//        NSLog(@"施工部位%@---\n---%@", _buweiIdArr[m], _buweiArr[m]);
        for(int i=0; i<_peoArr.count; i++) {
            
            GFProjectView *vv = [[GFProjectView alloc] init];
            vv.backgroundColor = [UIColor whiteColor];
            [self.scView addSubview:vv];
            vv.prArr = _buweiArr[m];
            vv.buweiIdArr = _buweiIdArr[m];
            vv.delegate = self;
            vv.frame = CGRectMake(m * [UIScreen mainScreen].bounds.size.width, 10 + _vvhh * i + 50, [UIScreen mainScreen].bounds.size.width, vv.vvHeight);
            _vvhh = vv.vvHeight;
            
            vv.name = _peoArr[i];
            if(i > 0) {
                
                // 删除合伙人
                UIButton *cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
                cancelBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 50, 30);
                [cancelBut setImage:[UIImage imageNamed:@"cancelPa"] forState:UIControlStateNormal];
                cancelBut.tag = i;
                [vv addSubview:cancelBut];
                [cancelBut addTarget:self action:@selector(cancelButclick:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if(i == _peoArr.count - 1) {
                
                // 添加报废材料页面
                UIView *baofeiView = [self _setBaofeiView:_buweiArr[m] withMaxY:CGRectGetMaxY(vv.frame) withPage:m];
                
                // 提交按钮
                UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
                but.frame = CGRectMake(50 + [UIScreen mainScreen].bounds.size.width * m, CGRectGetMaxY(baofeiView.frame) + 25, [UIScreen mainScreen].bounds.size.width - 100, 50);
                [but setTitle:@"完成工作" forState:UIControlStateNormal];
                [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                but.layer.cornerRadius = 7.5;
                but.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
                [_scView addSubview:but];
                [but addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
                
                NSString *maxvv = [NSString stringWithFormat:@"%f", CGRectGetMaxY(baofeiView.frame) + 100];
                [_maxVVArr addObject:maxvv];
            }
            
            [_proViewArr addObject:vv];
        }
    }

    _scView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _proArr.count, [_maxVVArr[_page - 1] floatValue] - 20);
    _scView.frame = CGRectMake(0, CGRectGetMaxY(_titleView.frame), [UIScreen mainScreen].bounds.size.width, [_maxVVArr[_page - 1] floatValue] - 10);
    
//    NSLog(@"-----%@===%@", _peoIdArr, _peoArr);
}
- (void)addButClick {
    
    [self setAddPeoView];
    
//    [GFHttpTool addPeoListGetWithParameters:nil success:^(id responseObject) {
//        
//        NSLog(@"技师列表数据＝＝＝＝%@", responseObject);
//    } failure:^(NSError *error) {
//        
//        
//    }];
    
//    NSLog(@"fasdfas");
//    [_peoArr addObject:@"增加的人"];
//    [_scView removeFromSuperview];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        [self _setSC];
//        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(_scView.frame)+20);
//    }];
}
- (void)cancelButclick:(UIButton *)sender {
    
    [_peoArr removeObjectAtIndex:sender.tag];
    [_peoIdArr removeObjectAtIndex:sender.tag];
    
    [_scView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self _setSC];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(_scView.frame)+20);
    }];
}
- (void)GFProjectView:(GFProjectView *)projectView {
    
    NSInteger a = 0;
    
    int sum = ((int)_peoArr.count - 1) * ((int)_page - 1);
    
    
    for(int i=sum + (int)_page - 1; i<_proViewArr.count; i++) {
        
        if(a < _peoArr.count) {
            
            GFProjectView *pp = (GFProjectView *)_proViewArr[i];
            pp.disableArr = projectView.disableArr;
            a++;
            
            //            NSLog(@"----%ld=====%@", a, projectView.idArr);
        }
    }
}
- (void)proButClick:(UIButton *)sender {
    
    
    sender.enabled = !sender.enabled;
    sender.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    sender.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _proButSelect.backgroundColor = [UIColor whiteColor];
    _proButSelect.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _proButSelect.enabled = YES;
    _proButSelect = sender;
    
    _baofeiArr = [[NSMutableArray alloc] init];
    
    _page = sender.tag;
    
    self.scView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * (sender.tag - 1), 0);
    _scView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _proArr.count, [_maxVVArr[(sender.tag - 1)] floatValue] - 20);
    _scView.frame = CGRectMake(0, CGRectGetMaxY(_titleView.frame), [UIScreen mainScreen].bounds.size.width, [_maxVVArr[_page - 1] floatValue] - 10);
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(_scView.frame)+20);
    
    self.proButView.frame = CGRectMake(self.scView.contentOffset.x, 0, [UIScreen mainScreen].bounds.size.width, 50);
    
    _conoffSet = self.scView.contentOffset;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

//    NSLog(@"---%ld", buttonIndex);
    if(buttonIndex == 1) {
//        NSLog(@"提交啦！！！");
        
        _baofeiDicMarr = [[NSMutableArray alloc] init];
        _bbppDic = [[NSMutableDictionary alloc] init];
        _bbppArr = [[NSMutableArray alloc] init];
        NSMutableArray *allArr = [[NSMutableArray alloc] init];
        
        NSMutableArray *buweiIdDicArr = [[NSMutableArray alloc] init];
        for(int i=0; i<_proArr.count; i++) {
            
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
            [buweiIdDicArr addObject:mDic];
        }
        
        for(int i=0; i<_peoArr.count; i++) {
            /** 1、获取一个技师*/
            // 每个技师对应一个字典
            NSMutableDictionary *jishiDic = [[NSMutableDictionary alloc] init];
            // 获取一个技师ID添加到技师字典中
            NSString *jishiID = _peoIdArr[i];
            jishiDic[@"techId"] = jishiID;
            
            /** 2、获取技师每个项目的ID以及每个项目所对应的施工部位*/
            // 存放技师项目和项目部位字典的数组
            NSMutableArray *ppArr = [[NSMutableArray alloc] init];
            for(int j=0; j<_proArr.count; j++) {
                
                NSMutableDictionary *mDic = buweiIdDicArr[j];
                _bbppDic = [[NSMutableDictionary alloc] init];
                
                // 每个项目对应一个字典
                NSMutableDictionary *proDic = [[NSMutableDictionary alloc] init];
                // 项目类型
                //            NSString *proName = _proArr[j];
                NSString *proId = _proIdArr[j];
                proDic[@"project"] = proId;
                /** 3、获取每个项目下施工部位*/
                NSInteger indexNum = _proViewArr.count / _proArr.count * j + i;
                GFProjectView *proView = _proViewArr[indexNum];
                NSArray *buweiIdArr = proView.idArr;
//                NSLog(@"---已选择的施工部位数组-%@", buweiIdArr);
                // 拼接施工部位的字符串
                NSString *ss = nil;
                for(int n=0; n<buweiIdArr.count; n++) {
                    
                    mDic[buweiIdArr[n]] = jishiDic[@"techId"];
                    
                    if(ss == nil) {
                        
                        ss = [NSString stringWithFormat:@"%@", buweiIdArr[n]];
                    }else {
                        
                        ss = [NSString stringWithFormat:@"%@,%@", ss, buweiIdArr[n]];
                    }
                }
                
                
                //            [_bbppArr addObject:mDic];
                
                proDic[@"position"] = ss;
                if(buweiIdArr.count > 0) {
                    
                    [ppArr addObject:proDic];
                }
            }
            
            jishiDic[@"projectPositions"] = ppArr;
            [allArr addObject:jishiDic];
            //        NSLog(@"=====%@\n=====%ld \n\n\n\n---", jishiDic, ppArr.count);
        }
        
//        NSLog(@"-报废材料的数组-%@===", buweiIdDicArr);
        NSMutableArray *constructionWastesArr = [[NSMutableArray alloc] init];
        for(int i=0; i<_proIdArr.count; i++) {
            
            NSMutableArray *mArr1 = _buweiIdArr[i];
            NSMutableArray *mArr2 = _buweiOOArr[i];
            NSMutableDictionary *mDic3 = buweiIdDicArr[i];
//            NSLog(@"====%@", _buweiOOArr);
            for(int a=0; a<mArr2.count; a++) {
                
                NSInteger str = [mArr2[a] integerValue];
//                NSLog(@"%@", mArr2);
                if(str != 0) {
                    
                    NSString *keyStr = [NSString stringWithFormat:@"%@", mArr1[a]];
                    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
                    mDic[@"techId"] = mDic3[keyStr];
                    mDic[@"project"] = _proIdArr[i];
                    mDic[@"position"] = mArr1[a];
                    mDic[@"total"] = mArr2[a];
//                    NSLog(@"++++++++++++++++%@", mDic[@"techId"]);
                    
                    if(mDic[@"techId"] != nil) {
                        
                        [constructionWastesArr addObject:mDic];
                    }
                }
            }
        }
        
//        NSLog(@"====报废材料提交====%@", constructionWastesArr);
        
        
        // 网络请求“完成工作”
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        
        
        mDic[@"orderId"] = _orderId;
        //    mDic[@"orderId"] = @(23);
        NSString *urlStr = @"";
        for(int i=0; i<self.photoUrlArr.count; i++) {
            
            if(i == 0) {
                
                urlStr = self.photoUrlArr[i];
            }else {
                
                urlStr = [NSString stringWithFormat:@"%@,%@", urlStr, self.photoUrlArr[i]];
            }
        }
        mDic[@"afterPhotos"] = urlStr;
        mDic[@"constructionDetails"] = allArr;
        mDic[@"constructionWastes"] = constructionWastesArr;
//        NSLog(@"提交的数据%@", mDic);
        
        NSDictionary *dicccc = allArr[0];
        NSArray *projectPositionsArrrr  = dicccc[@"projectPositions"];
        if(projectPositionsArrrr.count > 0) {
        
            NSArray *aa = [urlStr componentsSeparatedByString:@","];
            if(aa.count >= 3) {
                
//                NSLog(@"提交的数据%@", mDic);
                [GFHttpTool PostOverDictionary:mDic success:^(id responseObject) {
                    
//                    NSLog(@"$$$$$提交成功$$$%@", responseObject);
                    if([responseObject[@"status"] integerValue] == 1) {
                        
                        [self addAlertView:responseObject[@"message"]];
//                        CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
//                        [homeOrder headRefresh];
//                        [self.navigationController popToRootViewControllerAnimated:YES];
                        CLShareViewController *homeOrder1 = [[CLShareViewController alloc]init];
                        homeOrder1.orderNumber = self.orderNumber;
                        //                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                        //                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeOrder];
                        //                    navigation.navigationBarHidden = YES;
                        //                    window.rootViewController = navigation;
                        [self.navigationController pushViewController:homeOrder1 animated:YES];
                    }else {
                        
                        [self addAlertView:responseObject[@"message"]];
                    }
                } failure:^(NSError *error) {
                    
//                    NSLog(@"+++++%@", error);
                }];
            }else {
                
                [self addAlertView:@"请上传不少于3张工作后的照片"];
            }
        }else {
            
            [self addAlertView:@"请选择您的工作内容。"];
        }
        
        
    }
}
- (void)submitClick {
    
    UIAlertView *aa = [[UIAlertView alloc] initWithTitle:@"注意" message:@"确定要提交施工单！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aa show];
}
- (void)baofeiButClick:(UIButton *)sender {
    
    sender.selected = YES;
//    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    
    self.bbView.hidden = NO;
    _scrollView.frame = CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height-64-38);
    self.selBaofeiBut = sender;
    if(sender.selected == YES) {
        
        NSMutableArray *mArr = self.buweiOOArr[_page - 1];
//        mArr[sender.tag - 1] = @"1";
        self.baifeiSelArr = mArr;
        NSMutableArray *arr = _buweiArr[_page - 1];
        self.baofeiNorArr = arr;
//        [_baofeiArr addObject:arr[sender.tag - 1]];
//        _baofeiProArr[_page - 1] = _baofeiArr;
    }else {
        NSMutableArray *mArr = self.buweiOOArr[_page - 1];
//        mArr[sender.tag - 1] = @"0";
        self.baifeiSelArr = mArr;
        NSMutableArray *arr = _buweiArr[_page - 1];
        self.baofeiNorArr = arr;
//        [_baofeiArr removeObject:arr[sender.tag - 1]];
//        _baofeiProArr[_page - 1] = _baofeiArr;
    }
    
    [self.timePickerView selectRow:0 inComponent:0 animated:YES];
    
//    NSLog(@"===报废按钮点击了======%@", self.buweiOOArr);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if((((NSInteger)scrollView.contentOffset.x % (NSInteger)[UIScreen mainScreen].bounds.size.width) != 0)) {
        
        _conoffSet.y = scrollView.contentOffset.y;
        self.scView.contentOffset = _conoffSet;
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 6;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [NSString stringWithFormat:@"x %ld", row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen {
    
    //    [self.selectBut setTitle:[NSString stringWithFormat:@"%ld 年", row] forState:UIControlStateNormal];
    //    NSLog(@"===%@", self.selectBut.titleLabel.text);
    
    self.baifeiSelArr[self.selBaofeiBut.tag - 1] = @(row);
    if(row == 0) {
        
        [self.selBaofeiBut setTitle:[NSString stringWithFormat:@"%@", self.baofeiNorArr[self.selBaofeiBut.tag - 1]] forState:UIControlStateNormal];
        self.selBaofeiBut.selected = NO;
    }else {
        
        [self.selBaofeiBut setTitle:[NSString stringWithFormat:@"%@ x %ld", self.baofeiNorArr[self.selBaofeiBut.tag - 1], row] forState:UIControlStateNormal];
        self.selBaofeiBut.selected = YES;
    }
    
    self.curNum = [NSString stringWithFormat:@"%ld", row];
}
//轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender {
    
    _bbView.hidden = YES;
    //    _tableView.hidden = YES;
    
    _scrollView.frame = CGRectMake(0, 64+36, self.view.frame.size.width, self.view.frame.size.height-64-38);
    
    if([self.curNum isEqualToString:@"0"]) {
    
        self.selBaofeiBut.selected = NO;
    }
    
    self.curNum = @"0";
}



#pragma mark - 弃单提示和请求
- (void)removeOrderBtnClick1{
    GFAlertView *alertView = [[GFAlertView alloc]initWithTitle:@"确认要放弃此单吗？" leftBtn:@"取消" rightBtn:@"确定"];
    [alertView.rightButton addTarget:self action:@selector(removeOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertView];
}
- (void)removeOrder{
    //    NSLog(@"确认放弃订单，订单ID为 －－%@--- ",_orderId);
    
    GFFangqiViewController *vc = [[GFFangqiViewController alloc] init];
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
    
    /*
     [GFHttpTool postCancelOrder:_model.orderId Success:^(id responseObject) {
     
     NSLog(@"--放弃订单--%@", responseObject);
     if ([responseObject[@"status"] integerValue] == 1) {
     
     [GFTipView tipViewWithNormalHeightWithMessage:@"弃单成功" withShowTimw:1.5];
     [self performSelector:@selector(removeOrderSuccess) withObject:nil afterDelay:1.5];
     }else{
     
     [GFTipView tipViewWithNormalHeightWithMessage:responseObject[@"message"] withShowTimw:1.5];
     
     }
     
     } failure:^(NSError *error) {
     
     //       NSLog(@"放弃订单失败----%@---",error);
     
     }];
     */
    
}

- (void)removeOrderSuccess{
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    [self.navigationController popToRootViewControllerAnimated:YES];
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

