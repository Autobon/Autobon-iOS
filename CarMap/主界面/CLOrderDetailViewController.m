//
//  CLOrderDetailViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLOrderDetailViewController.h"
#import "GFMapViewController.h"
#import "GFNavigationView.h"
#import "CLSigninViewController.h"
#import "CLAddPersonViewController.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "GFAlertView.h"
#import "UIImageView+WebCache.h"
#import "CLHomeOrderViewController.h"
#import "CLImageView.h"


@interface CLOrderDetailViewController ()
{
    
    UIScrollView *_scrollView;
    GFMapViewController *_mapVC;
}

@property (nonatomic ,strong) UILabel *distanceLabel;


@end

@implementation CLOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//     NSLog(@"orderNumber--%@--",self.orderNumber);
    
    self.view.backgroundColor = [[UIColor alloc]initWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3+64, self.view.frame.size.width, self.view.frame.size.height*2/3-64-40)];
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
//    _scrollView.backgroundColor = [UIColor cyanColor];
    
    
    
    [self addMap];
    [self setNavigation];
    [self setViewForAutobon];
}

// 添加地图
- (void)addMap{
    _mapVC = [[GFMapViewController alloc] init];
    if ([self.customerLon isKindOfClass:[NSNull class]]) {
        _mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake(30.4,114.4);
    }else{
        _mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake([self.customerLat floatValue],[self.customerLon floatValue]);
        
    }
    _mapVC.bossPointAnno.iconImgName = @"location";
    __weak CLOrderDetailViewController *weakOrder = self;
    _mapVC.distanceBlock = ^(double distance) {
//        NSLog(@"距离－－%f--",distance);
#pragma mark - 返回距离
        weakOrder.distanceLabel.text = [NSString stringWithFormat:@"距离：%0.2fkm",distance/1000.0];
    };
    
    [self.view addSubview:_mapVC.view];
    [self addChildViewController:_mapVC];
    [_mapVC didMoveToParentViewController:self];
    _mapVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/3);
    _mapVC.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3);
}

- (void)setViewForAutobon{
    
    // 距离label
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -10, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    distanceLabel.backgroundColor = [UIColor cyanColor];
    _distanceLabel.text = @"距离：  1.3km";
    _distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:_distanceLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _distanceLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];
    
    // 订单图片
    UIImageView *imageView = [[CLImageView alloc]initWithFrame:CGRectMake(10, lineView.frame.origin.y + 7, self.view.frame.size.width - 20, self.view.frame.size.height/4)];
    //    imageView.backgroundColor = [UIColor darkGrayColor];
//    imageView.image = [UIImage imageNamed:@"orderImage"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_orderPhotoURL] placeholderImage:[UIImage imageNamed:@"orderImage"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:imageView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+self.view.frame.size.height/4+5, self.view.frame.size.width, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView2];
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"userId"] integerValue] == [_mainTechId integerValue] || [_action isEqualToString:@"INVITATION_ACCEPTED"]||[_action isEqualToString:@"NEWLY_CREATED"]){
        // 施工时间
        [self setLineView:[NSString stringWithFormat:@"施工时间：%@",self.orderTime] maxY:lineView2.frame.origin.y];
        
        NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
        [self setLineView:[NSString stringWithFormat:@"订单类型：%@",array[[self.orderType integerValue]-1]] maxY:lineView2.frame.origin.y+self.view.frame.size.height/18+1];
        
        [self setLineView:[NSString stringWithFormat:@"下单人员：%@",self.cooperatorName] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*2];
        
        [self setLineView:[NSString stringWithFormat:@"商户位置：%@",self.cooperatorAddress] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*3];
    }else{
        
        UIView *timeLineView = [[UIView alloc]initWithFrame:CGRectMake(0, lineView2.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
        timeLineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [_scrollView addSubview:timeLineView];
        
        
        // 施工时间
        [self setLineView:[NSString stringWithFormat:@"施工时间：%@",self.orderTime] maxY:lineView2.frame.origin.y+self.view.frame.size.height/18+1];
        
        NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
        [self setLineView:[NSString stringWithFormat:@"订单类型：%@",array[[self.orderType integerValue]-1]] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*2];
        
        [self setLineView:[NSString stringWithFormat:@"下单人员：%@",self.cooperatorName] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*3];
        
        [self setLineView:[NSString stringWithFormat:@"商户位置：%@",self.cooperatorAddress] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*4];
        
        [_scrollView bringSubviewToFront:timeLineView];
    }
    
    
//    [self setLineView:[NSString stringWithFormat:@"商户名称：%@",@"英卡科技"] maxY:lineView2.frame.origin.y];
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView2.frame.origin.y+4+(self.view.frame.size.height/18+1)*4, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = [NSString stringWithFormat:@"商户名称：%@",self.cooperatorFullname];
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView3];

    // 备注
    UILabel *otherLabel = [[UILabel alloc]init];
    //    otherLabel.backgroundColor = [UIColor cyanColor];
    otherLabel.text = [NSString stringWithFormat:@"下单备注：%@",self.remark];
    otherLabel.numberOfLines = 0;
    CGSize detailSize = [otherLabel.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT)];
    otherLabel.frame = CGRectMake(10, CGRectGetMaxY(lineView3.frame)+4, self.view.frame.size.width-20, detailSize.height);
    
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:otherLabel];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, otherLabel.frame.size.height + otherLabel.frame.origin.y, self.view.frame.size.width, 1)];
    lineView4.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    lineView4.hidden = YES;
    [_scrollView addSubview:lineView4];
    
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 41, self.view.frame.size.width, 1)];
    lineView5.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView5];
    
    
// 添加小伙伴
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40 ,self.view.frame.size.width/2, 40)];
    
    [addButton setTitleColor:[[UIColor alloc]initWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.view addSubview:addButton];
    
    
// 开始工作
    UIButton *workButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-40, self.view.frame.size.width/2, 40)];
    [workButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    workButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:workButton];
    
    if ([_action isEqualToString:@"TAKEN_UP"] || [_action isEqualToString:@"INVITATION_REJECTED"]||[_action isEqualToString:@"NEWLY_CREATED"]){
        [addButton setTitle:@"+合作人" forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [workButton addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [workButton setTitle:@"开始工作" forState:UIControlStateNormal];

    }else if ([_action isEqualToString:@"SEND_INVITATION"]){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        UILabel *label3 = [[UILabel alloc]init];
        lineView4.frame = CGRectMake(0, otherLabel.frame.origin.y + otherLabel.frame.size.height+3, self.view.frame.size.width, 1);
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView4.frame.origin.y + 4, 85, 30)];
        label1.text = @"合 作 人 ：";
        [_scrollView addSubview:label1];
        UILabel *label2 = [[UILabel alloc]init];
        label2.text = _secondId;
        CGSize nameSize = [_secondId sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        label2.frame = CGRectMake(90, lineView4.frame.origin.y + 4, nameSize.width+10, 30);
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor whiteColor];
        label2.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        label2.layer.cornerRadius = 10;
        label2.clipsToBounds = YES;
        [_scrollView addSubview:label2];
        
        
        label3.frame = CGRectMake(self.view.frame.size.width-80, lineView4.frame.origin.y + 4, 70, 30);
        label3.textAlignment = NSTextAlignmentLeft;
        label3.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
        [_scrollView addSubview:label3];
        lineView4.hidden = NO;
        
        
        
        if ([[userDefaults objectForKey:@"userId"] integerValue] == [_mainTechId integerValue]) {
            [addButton setTitle:@"+合作人" forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [workButton addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [workButton setTitle:@"开始工作" forState:UIControlStateNormal];
            label3.text = @"待确认";
        }else{
            
            
            label1.frame = CGRectMake(10, lineView2.frame.origin.y+4, 85, 30);
            label1.text = @"主 技 师 ：";
            label2.frame = CGRectMake(95, lineView2.frame.origin.y+9, 200, 20);
            label2.backgroundColor = [UIColor whiteColor];
            label2.textAlignment = NSTextAlignmentLeft;
            label2.textColor = [UIColor blackColor];
            timeLabel.frame = CGRectMake(10, lineView3.frame.origin.y+4, self.view.frame.size.width, self.view.frame.size.height/18);
            lineView4.frame = CGRectMake(0, timeLabel.frame.size.height + timeLabel.frame.origin.y, self.view.frame.size.width, 1);
            otherLabel.frame = CGRectMake(10, lineView4.frame.origin.y+4, self.view.frame.size.width-20, detailSize.height);
            
            [addButton addTarget:self action:@selector(orderDisagree) forControlEvents:UIControlEventTouchUpInside];
            [addButton setTitle:@"拒绝" forState:UIControlStateNormal];
            
            [workButton addTarget:self action:@selector(orderAgree) forControlEvents:UIControlEventTouchUpInside];
            [workButton setTitle:@"接受" forState:UIControlStateNormal];
        
        }
        
        
    }else if ([_action isEqualToString:@"INVITATION_ACCEPTED"]){
        UILabel *label3 = [[UILabel alloc]init];
        addButton.hidden = YES;
        lineView4.frame = CGRectMake(0, otherLabel.frame.origin.y + otherLabel.frame.size.height+3, self.view.frame.size.width, 1);
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView4.frame.origin.y + 4, 85, 30)];
        label1.text = @"合 作 人 ：";
        [_scrollView addSubview:label1];
        
        if (_mainTechId) {
            
                UILabel *label2 = [[UILabel alloc]init];
                label2.text = _secondId;
            CGSize nameSize = [_secondId sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
            label2.frame = CGRectMake(90, lineView4.frame.origin.y + 4, nameSize.width+10, 30);
                label2.textAlignment = NSTextAlignmentCenter;
                label2.textColor = [UIColor whiteColor];
                label2.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
                label2.layer.cornerRadius = 10;
                label2.clipsToBounds = YES;
                [_scrollView addSubview:label2];
            label3.text = @"已接单";

        }else{
            UILabel *label2 = [[UILabel alloc]init];
            label2.text = _secondId;
            CGSize nameSize = [_secondId sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
            label2.frame = CGRectMake(90, lineView4.frame.origin.y + 4, nameSize.width+10, 30);
            label2.textAlignment = NSTextAlignmentCenter;
            label2.textColor = [UIColor whiteColor];
            label2.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
            label2.layer.cornerRadius = 10;
            label2.clipsToBounds = YES;
            [_scrollView addSubview:label2];
//            label3.text = @"已接单";
            label3.hidden = YES;
        }
        
        
        
        
//        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, lineView4.frame.origin.y + 4, 70, 30)];
        label3.frame = CGRectMake(self.view.frame.size.width-80, lineView4.frame.origin.y + 4, 70, 30);
        
        label3.textAlignment = NSTextAlignmentLeft;
        label3.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
        [_scrollView addSubview:label3];
        
        lineView4.hidden = NO;
//        lineView4.frame = CGRectMake(0, label1.frame.origin.y + 39, self.view.frame.size.width, 1);
        workButton.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
        
        [workButton addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [workButton setTitle:@"开始工作" forState:UIControlStateNormal];
        

    }
    if (lineView4.hidden) {
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, lineView3.frame.origin.y+1+detailSize.height+self.view.frame.size.height/18);
    }else{
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, lineView3.frame.origin.y+1+detailSize.height+self.view.frame.size.height/18+15);
    }
    
}


- (void)setLineView:(NSString *)title maxY:(float)maxY{
    
// 施工时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, maxY +4, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = title;
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView3];
    
}



#pragma mark - 添加合作小伙伴的响应方法
- (void)addBtnClick{
//    NSLog(@"是时候添加一个小伙伴啦");
    CLAddPersonViewController *addPerson = [[CLAddPersonViewController alloc]init];
    addPerson.orderId = _orderId;
    [self.navigationController pushViewController:addPerson animated:YES];
}

#pragma mark - 开始工作按钮的响应方法
- (void)workBtnClick{
   
    
    [GFHttpTool postOrderStart:@{@"orderId":_orderId} Success:^(NSDictionary *responseObject) {
//        NSLog(@"----responseObject--%@",responseObject);
        if ([responseObject[@"result"]integerValue] == 1) {
            CLSigninViewController *signinView = [[CLSigninViewController alloc]init];
            signinView.customerLat = self.customerLat;
            signinView.customerLon = self.customerLon;
            signinView.orderId = self.orderId;
            signinView.orderType = self.orderType;
            NSDictionary *dataDictionary = responseObject[@"data"];
            signinView.startTime = dataDictionary[@"startTime"];
            signinView.orderNumber = self.orderNumber;
            
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:signinView];
//            navigation.navigationBarHidden = YES;
//            window.rootViewController = navigation;
            
            [self.navigationController pushViewController:signinView animated:YES];
        }else{
            if ([responseObject[@"error"] isEqualToString:@"INVITATION_NOT_FINISH"]) {
                GFAlertView *alertView = [[GFAlertView alloc]initWithTitle:@"合作人暂无回应" leftBtn:@"继续等待" rightBtn:@"强制开始"];
                [alertView.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:alertView];
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
        }
        
    } failure:^(NSError *error) {
//        NSLog(@"----失败原因－－%@--",error);
//        [self addAlertView:@"请求失败"];
    }];
    
}

#pragma mark - 强制开始的方法
- (void)rightButtonClick{
    [GFHttpTool postOrderStart:@{@"orderId":_orderId,@"ignoreInvitation":@"true"} Success:^(NSDictionary *responseObject) {
//        NSLog(@"----responseObject--%@",responseObject);
        if ([responseObject[@"result"]integerValue] == 1) {
            CLSigninViewController *signinView = [[CLSigninViewController alloc]init];
            signinView.customerLat = self.customerLat;
            signinView.customerLon = self.customerLon;
            signinView.orderId = self.orderId;
            signinView.orderType = self.orderType;
            signinView.orderNumber = self.orderNumber;
            NSDictionary *dataDictionary = responseObject[@"data"];
            signinView.startTime = dataDictionary[@"startTime"];
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:signinView];
//            navigation.navigationBarHidden = YES;
//            window.rootViewController = navigation;
            [self.navigationController pushViewController:signinView animated:YES];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
        
    } failure:^(NSError *error) {
//        [self addAlertView:@"请求失败"];
    }];
}

#pragma mark - 接受订单邀请的响应方法
- (void)orderAgree{
    [GFHttpTool PostAcceptOrderId:[_orderId integerValue] accept:@"true" success:^(id responseObject) {
        if ([responseObject[@"result"]integerValue] == 1) {
            [self addAlertView:@"接受邀请成功"];
//            _scrollView.delegate = nil;
            CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
            [homeOrder headRefresh];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
//        [self addAlertView:@"请求失败"];
    }];
}

#pragma mark - 不接受订单邀请的响应方法
- (void)orderDisagree{
    
    [GFHttpTool PostAcceptOrderId:[_orderId integerValue] accept:@"false" success:^(id responseObject) {
        [self addAlertView:@"已拒绝邀请"];
//        _scrollView.delegate = nil;
        CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
        [homeOrder headRefresh];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
//        NSLog(@"---error---%@--",error);
//        [self addAlertView:@"请求失败"];
    }];

}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    UIButton *removeOrderButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 20, 40, 44)];
    [removeOrderButton setTitle:@"放弃" forState:UIControlStateNormal];
    [removeOrderButton setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [removeOrderButton addTarget:self action:@selector(removeOrderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:removeOrderButton];
    
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
}

#pragma mark - 弃单提示和请求
- (void)removeOrderBtnClick{
    GFAlertView *alertView = [[GFAlertView alloc]initWithTitle:@"确认要放弃此单吗？" leftBtn:@"取消" rightBtn:@"确定"];
    [alertView.rightButton addTarget:self action:@selector(removeOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertView];
}
- (void)removeOrder{
//    NSLog(@"确认放弃订单，订单ID为 －－%@--- ",_orderId);
    
    
   [GFHttpTool postCancelOrder:_orderId Success:^(id responseObject) {
      
       if ([responseObject[@"result"] integerValue] == 1) {
           
           [GFTipView tipViewWithNormalHeightWithMessage:@"弃单成功" withShowTimw:1.5];
           [self performSelector:@selector(removeOrderSuccess) withObject:nil afterDelay:1.5];
       }else{
           
           [GFTipView tipViewWithNormalHeightWithMessage:responseObject[@"message"] withShowTimw:1.5];
           
       }
       
   } failure:^(NSError *error) {
       
//       NSLog(@"放弃订单失败----%@---",error);
       
   }];
    
    
}

- (void)removeOrderSuccess{
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    [self.navigationController popToRootViewControllerAnimated:YES];
}




- (void)backBtnClick{
//    _scrollView.delegate = nil;
    if (_orderNumber==nil) {
        CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
        [homeOrder headRefresh];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
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
