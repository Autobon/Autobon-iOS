//
//  GFKeqiangDDViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/12/5.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFKeqiangDDViewController.h"
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
#import "UIButton+WebCache.h"

#import "CLHomeOrderCellModel.h"

#import "HZPhotoBrowser.h"

#import "CLWorkOverViewController.h"
#import "CLWorkBeforeViewController.h"

#import "CLAddOrderSuccessViewController.h"
#import "ACETelPrompt.h"

@interface GFKeqiangDDViewController ()<HZPhotoBrowserDelegate>
{
    
    UIScrollView *_scrollView;
    GFMapViewController *_mapVC;
}

@property (nonatomic ,strong) UILabel *distanceLabel;

@property (nonatomic, strong) NSArray *photoArr;


@end

@implementation GFKeqiangDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [[UIColor alloc]initWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3+64, self.view.frame.size.width, self.view.frame.size.height*2/3-64-40)];
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
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
    _mapVC.bossPointAnno.title = _cooperatorName;
    __weak GFKeqiangDDViewController *weakOrder = self;
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
    
    
    // 订单编号
    UILabel *orderNumberLabel = [[UILabel alloc]init];
    orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width, self.view.frame.size.height/18)];
    orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@",_model.orderNumber];
    orderNumberLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:orderNumberLabel];
    
    UIView *orderNumberLineView = [[UIView alloc]initWithFrame:CGRectMake(-10, CGRectGetMaxY(orderNumberLabel.frame) - 10, self.view.frame.size.width, 1)];
    orderNumberLineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [orderNumberLabel addSubview:orderNumberLineView];
    
    
    // 距离label
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(orderNumberLineView.frame) + 7, self.view.frame.size.width, self.view.frame.size.height/18)];
    _distanceLabel.text = @"距离：  1.3km";
    _distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:_distanceLabel];
    
    UIView *distanceLineView = [[UIView alloc]initWithFrame:CGRectMake(0, _distanceLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    distanceLineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:distanceLineView];
    
    // 订单图片
    _photoArr = [_orderPhotoURL componentsSeparatedByString:@","];
//    NSLog(@"照片地址数组：%ld：：：%@", _photoArr.count, _photoArr);
    CGFloat butW = ([UIScreen mainScreen].bounds.size.width - 40) / 3.0;
    CGFloat butH = butW;
    CGFloat maxY = 0;
    for(int i=0; i<_photoArr.count; i++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor = [UIColor redColor];
        but.frame = CGRectMake(10 + (butW + 10) * (i % 3), distanceLineView.frame.origin.y + 7 + (butH + 10) * (i / 3), butW, butH);
        [but sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp ,_photoArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage"]];
        but.clipsToBounds = YES;
        but.tag = i + 1;
        [_scrollView addSubview:but];
        [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == _photoArr.count - 1) {
            
            maxY = CGRectGetMaxY(but.frame);
        }
    }
    
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, maxY + 5, self.view.frame.size.width, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView2];
    
    [self setLineView:[NSString stringWithFormat:@"车牌号：%@",self.model.license] maxY:lineView2.frame.origin.y];
    [self setLineView:[NSString stringWithFormat:@"车驾号：%@",self.model.vin] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*1];
    [self setLineView:[NSString stringWithFormat:@"订单类型：%@",self.orderType] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*2];
    [self setLineView:[NSString stringWithFormat:@"预约施工时间：%@",self.orderTime] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*3];
    [self setLineView:[NSString stringWithFormat:@"最晚交车时间：%@",_model.agreedEndTime] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*4];
    [self setLineView:[NSString stringWithFormat:@"下单人员：%@",_model.creatorName] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*5];
    [self setLineView:[NSString stringWithFormat:@"联系方式：%@",_model.contactPhone] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*6];
    
    UIButton *phoneButton = [[UIButton alloc]init];
    [phoneButton setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    [_scrollView addSubview:phoneButton];
    [phoneButton addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    phoneButton.frame = CGRectMake(self.view.frame.size.width - self.view.frame.size.height/9 - 20, lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*6 +3 , self.view.frame.size.height/9, self.view.frame.size.height/18);
    
    [self setLineView:[NSString stringWithFormat:@"下单时间：%@",_model.createTime] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*7];
    [self setLineView:[NSString stringWithFormat:@"商户名称：%@",self.cooperatorName] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*8];
    UILabel *lastLab = [self setLineView:[NSString stringWithFormat:@"商户位置：%@",self.cooperatorAddress] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*9];
    
    // 备注
    UILabel *otherLabel = [[UILabel alloc]init];
    otherLabel.text = [NSString stringWithFormat:@"下单备注：%@",self.remark];
    otherLabel.numberOfLines = 0;
    CGRect detailSize = [otherLabel.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    otherLabel.frame = CGRectMake(10, CGRectGetMaxY(lastLab.frame)+4, self.view.frame.size.width-20, detailSize.size.height);
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:otherLabel];
    
    // 抢单
    UIButton *workButton = [[UIButton alloc]initWithFrame:CGRectMake(25, self.view.frame.size.height-60, self.view.frame.size.width - 50, 40)];
    [workButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    workButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:workButton];
    [workButton addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [workButton setTitle:@"抢单" forState:UIControlStateNormal];
    workButton.layer.cornerRadius = 7.5;
    
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(lastLab.frame)+1+detailSize.size.height+self.view.frame.size.height/18 + 20);
}

- (void)phoneBtnClick{
    [ACETelPrompt callPhoneNumber:_model.contactPhone call:^(NSTimeInterval duration) {
        
    } cancel:^{
        
    }];
}


- (void)imgViewButClick:(UIButton *)sender {
    
//    NSLog(@"---tupiande de index %ld", sender.tag - 1);
    
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = _scrollView;
    
    browser.imageCount = _photoArr.count;
    
    browser.currentImageIndex = sender.tag - 1;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    
    UIImage *img = [UIImage imageNamed:@"orderImage"];
    
    return img;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp, _photoArr[index]]];
    
    return url;
}

- (UILabel *)setLineView:(NSString *)title maxY:(float)maxY{
    
    // 施工时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, maxY +4, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = title;
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18 - 1, self.view.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView3];
    
    return timeLabel;
}

#pragma mark - 添加合作小伙伴的响应方法
- (void)addBtnClick{
    //    NSLog(@"是时候添加一个小伙伴啦");
    CLAddPersonViewController *addPerson = [[CLAddPersonViewController alloc]init];
    addPerson.orderId = _orderId;
    [self.navigationController pushViewController:addPerson animated:YES];
}

#pragma mark - 抢单按钮的响应方法
- (void)workBtnClick{
    
    
    [GFHttpTool postOrderId:[_model.orderId integerValue] Success:^(NSDictionary *responseObject) {
        
//                NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"status"]integerValue] == 1) {
            
            CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
            addSuccess.model = _model;
            
//            addSuccess.orderNum = _model.orderNumber;
//            addSuccess.dataDictionary = _model.dataDictionary;

            [self.navigationController pushViewController:addSuccess animated:NO];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"----抢单结果-222-%@--",error);
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
    
    UIButton *removeOrderButton = [[UIButton alloc]init];
    [removeOrderButton setTitle:@"收藏" forState:UIControlStateNormal];
    [removeOrderButton setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [navView addSubview:removeOrderButton];
    
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [removeOrderButton addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    
    [removeOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(navView).offset(-4);
        make.right.equalTo(navView).offset(-20);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    
    [self.view addSubview:navView];
    
    
}


-(void)deleteBtnClick{
    
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    [userDefalts setObject:@"YES" forKey:@"homeOrder"];
    [userDefalts synchronize];
    
    [self.view removeFromSuperview];
    
}


#pragma mark - 收藏商户
- (void)collect{
    
    [GFHttpTool favoriteCooperatorPostWithParameters:@{@"cooperatorId":_model.cooperatorId} success:^(id responseObject) {
        NSLog(@"responseObject---%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            [self addAlertView:@"收藏商户成功"];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"error--%@--",error);
    }];
    
    
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
//    if (_orderNumber==nil) {
//        CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
//        [homeOrder headRefresh];
//    }
//    
//    [self.navigationController popToRootViewControllerAnimated:YES];
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
