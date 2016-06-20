//
//  CLKnockOrderViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLNewOrderDetailViewController.h"
#import "GFMapViewController.h"
#import "CLCertifyViewController.h"
#import "GFNavigationView.h"
#import "UIImageView+WebCache.h"
#import "GFHttpTool.h"
#import "CLAddOrderSuccessViewController.h"
#import "GFTipView.h"
#import "CLImageView.h"


@interface CLNewOrderDetailViewController ()
{
//    UIView *_orderView;
    UILabel *_distanceLabel; // 距离label
    UIScrollView *_scrollView;
}
@end

@implementation CLNewOrderDetailViewController

- (CLListNewModel *)model{
    if (_model == nil) {
        _model = [[CLListNewModel alloc]init];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3+64, self.view.frame.size.width, self.view.frame.size.height*2/3-64)];
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
//    _scrollView.backgroundColor = [UIColor cyanColor];
    
//    self.view.backgroundColor = [[UIColor alloc]initWithWhite:0.1 alpha:0.5];
//    _orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
//    _orderView.backgroundColor = [UIColor whiteColor];
//    _orderView.layer.borderWidth = 1.0f;
//    _orderView.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1]CGColor];
//    _orderView.layer.cornerRadius = 10;
    
    
//    [self.view addSubview:_orderView];
    
    
    [self addMap];
    
    [self setViewForAutobon];
    
    [self setNavigation];
    
//    NSLog(@"------_model---%@--",_model.orderTime);
    
//    [self performSelector:@selector(addMap) withObject:nil afterDelay:0.5];
//    [self performSelector:@selector(setViewForAutobon) withObject:nil afterDelay:0.5];
    
    
}

// 添加地图
- (void)addMap{
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5+64, 150, 30)];
//    NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
//    titleLabel.text = array[[_model.orderType integerValue]-1];
//    [self.view addSubview:titleLabel];
    
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    if (![_model.orderLat isKindOfClass:[NSNull class]] && ![_model.orderLon isKindOfClass:[NSNull class]]) {
        mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake([_model.orderLat floatValue],[_model.orderLon floatValue]);
    }else{
        mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake(30,114);
    }
    
    
    mapVC.bossPointAnno.iconImgName = @"location";
    mapVC.distanceBlock = ^(double distance) {
        //        NSLog(@"距离－－%f--",distance);
        _distanceLabel.text = [NSString stringWithFormat:@"距离：  %0.2fkm",distance/1000.0];
    };
    
    [self.view addSubview:mapVC.view];
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    mapVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/3);
    mapVC.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3);
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




- (void)setViewForAutobon{
    
    
    // 距离label
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -10, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    distanceLabel.backgroundColor = [UIColor cyanColor];
    _distanceLabel.text = @"距离：  0km";
    _distanceLabel.font = [UIFont systemFontOfSize:14];
    _distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:_distanceLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _distanceLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];
    
// 订单图片
    CLImageView *imageView = [[CLImageView alloc]initWithFrame:CGRectMake(10, lineView.frame.origin.y + 7, self.view.frame.size.width - 20, self.view.frame.size.height/4)];
//    imageView.backgroundColor = [UIColor darkGrayColor];
    imageView.image = [UIImage imageNamed:@"orderImage"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.orderPhoto] placeholderImage:[UIImage imageNamed:@"orderImage"]];
    [_scrollView addSubview:imageView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+self.view.frame.size.height/4+5, self.view.frame.size.width, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView2];
    
// 施工时间
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_model.orderTime floatValue]/1000];
//    NSString *timeString = [formatter stringFromDate:date];
    
    
    // 施工时间
    [self setLineView:[NSString stringWithFormat:@"施工时间：%@",_model.orderTime] maxY:lineView2.frame.origin.y];
    
    NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
    
    [self setLineView:[NSString stringWithFormat:@"订单类型：%@",array[[_model.orderType integerValue]-1]] maxY:lineView2.frame.origin.y+self.view.frame.size.height/18+1];
    
    [self setLineView:[NSString stringWithFormat:@"下单人员：%@",_model.cooperatorName] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*2];
    
    [self setLineView:[NSString stringWithFormat:@"商户位置：%@",_model.cooperatorAddress] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*3];
    
    
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView2.frame.origin.y+4+(self.view.frame.size.height/18+1)*4, self.view.frame.size.width-20 ,self.view.frame.size.height/18)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    //    timeLabel.text = @"工作时间： 今天14:30";
    timeLabel.text = [NSString stringWithFormat:@"商户名称：%@",_model.cooperatorFullname];
//    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18-5, self.view.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView3];
    
    
    // 备注
    UILabel *otherLabel = [[UILabel alloc]init];
    
    NSString *remarkString = _model.orderRemark;
    //    NSLog(@"---_orderDictionary--%@--",_orderDictionary);
    
    if ([remarkString isKindOfClass:[NSNull class]]) {
        otherLabel.text = [NSString stringWithFormat:@"工作备注："];
    }else if(remarkString == NULL){
        otherLabel.text = [NSString stringWithFormat:@"工作备注："];
    }else{
        otherLabel.text = [NSString stringWithFormat:@"工作备注：%@",_model.orderRemark];
    }
    
    CGSize detailSize = [otherLabel.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT)];
    if (self.view.frame.size.height-lineView3.frame.origin.y-2-self.view.frame.size.height/18-7 > detailSize.height) {
        otherLabel.frame = CGRectMake(10, lineView3.frame.origin.y+2, self.view.frame.size.width-40, detailSize.height);
    }else{
        otherLabel.frame = CGRectMake(10, lineView3.frame.origin.y+2, self.view.frame.size.width-40, self.view.frame.size.height-lineView3.frame.origin.y-2-self.view.frame.size.height/18-7);
    }
    
    otherLabel.font = [UIFont systemFontOfSize:17];
    //    otherLabel.textAlignment = NSTextAlignmentRight;
    
    otherLabel.numberOfLines = 0;
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:otherLabel];
    
    
    // 立即抢单
    UIButton * _certifyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, CGRectGetMaxY(otherLabel.frame)+10, self.view.frame.size.width/2, self.view.frame.size.height/18)];
    [_certifyButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_certifyButton setBackgroundImage:[UIImage imageNamed:@"buttonClick"] forState:UIControlStateHighlighted];
    [_certifyButton setTitle:@"抢单" forState:UIControlStateNormal];
    [_certifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_certifyButton addTarget:self action:@selector(certifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_certifyButton];
    
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(_certifyButton.frame)+10);
    
    // 取消按钮
//    _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, _orderView.frame.origin.y-5, 30, 30)];
//    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"deleteOrder"] forState:UIControlStateNormal];
//    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateHighlighted];
//    [_cancelButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_cancelButton];
    
    
}


#pragma mark - 抢单按钮
- (void)certifyBtnClick{
    
    [GFHttpTool postOrderId:[_model.orderId integerValue] Success:^(NSDictionary *responseObject) {
        
//        NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"result"]integerValue] == 1) {
            
            
//            CLListNewModel *model = _cellModelArray[button.tag-1];
            CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
            
            addSuccess.orderNum = _model.orderNumber;
            addSuccess.dataDictionary = _model.dataDictionary;
            
            
            
//            addSuccess.addBlock = ^{
//                _noOrderImageView.hidden = YES;
//                _noOrderlabel.hidden = YES;
//                
//                //                [self headRefresh];
//            };
            [self.navigationController pushViewController:addSuccess animated:NO];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"----抢单结果-222-%@--",error);
        [self addAlertView:@"请求失败"];
    }];
}



#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"订单详情" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)deleteBtnClick{
    
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    [userDefalts setObject:@"YES" forKey:@"homeOrder"];
    [userDefalts synchronize];
    
    [self.view removeFromSuperview];
    
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
