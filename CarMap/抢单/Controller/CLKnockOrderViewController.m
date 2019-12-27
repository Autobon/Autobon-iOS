//
//  CLKnockOrderViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLKnockOrderViewController.h"
#import "GFMapViewController.h"
#import "CLCertifyViewController.h"
#import "GFNavigationView.h"
#import "UIImageView+WebCache.h"
#import "CLImageView.h"
#import "GFHttpTool.h"
#import "CLHomeOrderCellModel.h"

#import "UIButton+WebCache.h"

#import "HZPhotoBrowser.h"

#import "CLAddOrderSuccessViewController.h"
#import "GFTipView.h"
#import "CLHomeOrderViewController.h"

@interface CLKnockOrderViewController () <HZPhotoBrowserDelegate>
{
    UIScrollView *_scrollView;
    UILabel *_distanceLabel; // 距离label
    NSArray *_productOfferArray;
}

@property (nonatomic, strong) CLHomeOrderCellModel *model;

@property (nonatomic, strong) NSArray *photoArr;

@end

@implementation CLKnockOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc]initWithWhite:0.1 alpha:0.5];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 64+self.view.frame.size.height/3+10, self.view.frame.size.width-20, self.view.frame.size.height-74-5-self.view.frame.size.height/3)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.layer.borderWidth = 1.0f;
    _scrollView.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1]CGColor];
//    _scrollView.layer.cornerRadius = 10;
    
    
//    NSLog(@"==返回字典===%@===%@", _orderDictionary, _orderDictionary[@"status"]);
    NSDictionary *dic = _orderDictionary[@"order"];
    NSMutableDictionary *mDic= [[NSMutableDictionary alloc] init];
    mDic[@"orderId"] = dic[@"id"];
//    NSLog(@"===请求的数据==%@", mDic);
    [GFHttpTool oederDDGetWithParameters:mDic success:^(id responseObject) {
        
        ICLog(@"----%@-", responseObject);
        if([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDictionary = responseObject[@"message"];
            CLHomeOrderCellModel *model = [[CLHomeOrderCellModel alloc] initWithDictionary:messageDictionary];
            _model = model;
            
//            NSLog(@"===%@", _model.cooperatorAddress);
            _productOfferArray = messageDictionary[@"productOfferShows"];
            [self.view addSubview:_scrollView];
            
            
            [self addMap];
            
            [self setViewForAutobon];
        }else {
        
            [self deleteBtnClick];
        }
        
        
    } failure:^(NSError *error) {
        ICLog(@"--error--%@-", error);
        [self deleteBtnClick];
    }];
    
    
    
    
    
}

// 添加地图
- (void)addMap{
    NSDictionary *orderDic = _orderDictionary[@"order"];
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 150, 30)];
//    NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
//    titleLabel.text = array[[orderDic[@"orderType"] integerValue]-1];
//    [_orderView addSubview:titleLabel];
    
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    if (![orderDic[@"positionLat"] isKindOfClass:[NSNull class]] && ![orderDic[@"positionLon"] isKindOfClass:[NSNull class]]) {
        mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake([orderDic[@"positionLat"]floatValue],[orderDic[@"positionLon"]floatValue]);
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
    mapVC.view.frame = CGRectMake(10, 74, self.view.frame.size.width-20, self.view.frame.size.height/3);
    mapVC.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width-20, self.view.frame.size.height/3);
}

- (void)setViewForAutobon{
    
//    NSDictionary *orderDic = _orderDictionary[@"order"];
    
    // 距离label
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 40)];
    //    distanceLabel.backgroundColor = [UIColor cyanColor];
    _distanceLabel.text = @"距离：  0km";
    _distanceLabel.font = [UIFont systemFontOfSize:14];
    _distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:_distanceLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _distanceLabel.frame.origin.y + 40, _scrollView.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];
    
//    // 订单图片
//    UIImageView *imageView = [[CLImageView alloc]initWithFrame:CGRectMake(10, lineView.frame.origin.y + 7, _scrollView.frame.size.width - 20, self.view.frame.size.height/4)];
//    //    imageView.backgroundColor = [UIColor darkGrayColor];
//    imageView.image = [UIImage imageNamed:@"orderImage"];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    extern NSString* const URLHOST;
//    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLHOST,orderDic[@"photo"]]] placeholderImage:[UIImage imageNamed:@"orderImage"]];
//    [_scrollView addSubview:imageView];
    
    // 订单图片
    _photoArr = [_model.orderPhotoURL componentsSeparatedByString:@","];
//    NSLog(@"照片地址数组：%ld：：：%@", _photoArr.count, _photoArr);
    CGFloat butW = (_scrollView.frame.size.width - 40) / 3.0;
    CGFloat butH = butW;
    CGFloat maxY = 0;
    for(int i=0; i<_photoArr.count; i++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor = [UIColor redColor];
        but.frame = CGRectMake(10 + (butW + 10) * (i % 3), lineView.frame.origin.y + 7 + (butH + 10) * (i / 3), butW, butH);
        [but sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp, _photoArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage"]];
        but.clipsToBounds = YES;
        but.tag = i + 1;
        [_scrollView addSubview:but];
        [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == _photoArr.count - 1) {
            
            maxY = CGRectGetMaxY(but.frame);
        }
    }
    
    
    
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, maxY+5, _scrollView.frame.size.width, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView2];
    
    [self setLineView:[NSString stringWithFormat:@"车牌号：%@",self.model.license] maxY:lineView2.frame.origin.y];
    [self setLineView:[NSString stringWithFormat:@"车驾号：%@",self.model.vin] maxY:lineView2.frame.origin.y + 40*1];
    [self setLineView:[NSString stringWithFormat:@"车型：%@",self.model.vehicleModel] maxY:lineView2.frame.origin.y + 40*2];
    [self setLineView:[NSString stringWithFormat:@"订单类型：%@",_model.orderType] maxY:lineView2.frame.origin.y + 40*3];
    
    NSString *offerString = @"";
    for (int i = 0; i < _productOfferArray.count; i++) {
        NSDictionary *productOfferDictionary = _productOfferArray[i];
        if (i == 0){
            offerString = [NSString stringWithFormat:@"%@%@/%@", offerString, productOfferDictionary[@"constructionPositionName"], productOfferDictionary[@"model"]];
        }else{
            offerString = [NSString stringWithFormat:@"%@\r%@/%@", offerString, productOfferDictionary[@"constructionPositionName"], productOfferDictionary[@"model"]];
        }
    }
    UILabel *productDetailTitleLabel = [[UILabel alloc]init];
    productDetailTitleLabel.text = @"施工详情：";
    productDetailTitleLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    productDetailTitleLabel.frame = CGRectMake(10, lineView2.frame.origin.y+ 40*4, 90, 40);
    [_scrollView addSubview:productDetailTitleLabel];
    
    UILabel *productDetailValueLabel = [[UILabel alloc]init];
    productDetailValueLabel.text = offerString;
    productDetailValueLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    productDetailValueLabel.numberOfLines = 0;
    productDetailValueLabel.frame = CGRectMake(95, lineView2.frame.origin.y+ 40*4, self.view.frame.size.width - 120, 20 + 20*_productOfferArray.count);
    [_scrollView addSubview:productDetailValueLabel];
    
    UIView *productLineView = [[UIView alloc]initWithFrame:CGRectMake(0,  lineView2.frame.origin.y+ 40*4 + 20 + 20*_productOfferArray.count + 0, self.view.frame.size.width, 1)];
    if (_productOfferArray.count == 0){
        productLineView.frame = CGRectMake(0,  lineView2.frame.origin.y+ 40*4 + 20 + 20 + 0, self.view.frame.size.width, 1);
    }
    productLineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:productLineView];
    
    
    [self setLineView:[NSString stringWithFormat:@"预约施工时间：%@",_model.orderTime] maxY:productLineView.frame.origin.y+ 40*0];
    [self setLineView:[NSString stringWithFormat:@"最晚交车时间：%@",_model.agreedEndTime] maxY:productLineView.frame.origin.y+ 40*1];
    [self setLineView:[NSString stringWithFormat:@"下单人员：%@",_model.creatorName] maxY:productLineView.frame.origin.y+ 40*2];
    [self setLineView:[NSString stringWithFormat:@"下单时间：%@",_model.createTime] maxY:productLineView.frame.origin.y+ 40*3];
    [self setLineView:[NSString stringWithFormat:@"商户名称：%@",_model.cooperatorFullname] maxY:productLineView.frame.origin.y+ 40*4];
    UILabel *lastLab = [self setLineView:[NSString stringWithFormat:@"商户位置：%@",_model.address] maxY:productLineView.frame.origin.y+ 40*5];
    // 备注
    UILabel *otherLabel = [[UILabel alloc]init];
    otherLabel.text = [NSString stringWithFormat:@"下单备注：%@",_model.remark];
    otherLabel.numberOfLines = 0;
    CGRect detailSize = [otherLabel.text boundingRectWithSize:CGSizeMake(_scrollView.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    otherLabel.frame = CGRectMake(10, CGRectGetMaxY(lastLab.frame)+16, _scrollView.frame.size.width-20, detailSize.size.height);
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:otherLabel];
    
    // 抢单
    UIButton *workButton = [[UIButton alloc]initWithFrame:CGRectMake(25, [UIScreen mainScreen].bounds.size.height-60, _scrollView.frame.size.width - 50, 40)];
    [workButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    workButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:workButton];
    [workButton addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [workButton setTitle:@"抢单" forState:UIControlStateNormal];
    workButton.layer.cornerRadius = 7.5;
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(lastLab.frame)+1+detailSize.size.height+_scrollView.frame.size.height/18 + 70);
    
    /*
    // 施工时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDic[@"agreedEndTime"] floatValue]/1000];
    NSString *timeString = [formatter stringFromDate:date];
    
    
    
    
    
    // 施工时间
    [self setLineView:[NSString stringWithFormat:@"施工时间：%@",timeString] maxY:lineView2.frame.origin.y];
    
    NSArray *array = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
    NSArray *typeArr = [orderDic[@"type"] componentsSeparatedByString:@","];
    NSString *ss = @"";
    for(int i=0; i<typeArr.count; i++) {
    
        NSInteger j = [typeArr[i] integerValue] - 1;
        if([ss isEqualToString:@""]) {
        
            ss = array[j];
        }else {
            
            ss = [NSString stringWithFormat:@"%@,%@", ss, array[j]];
        }
        
        NSLog(@"===%@", ss);
    }
    
    [self setLineView:[NSString stringWithFormat:@"订单类型：%@",ss] maxY:lineView2.frame.origin.y+self.view.frame.size.height/18+1];
    
    NSDictionary *cooperatorDictionary = orderDic[@"cooperator"];

    [self setLineView:[NSString stringWithFormat:@"下单人员：%@",cooperatorDictionary[@"creatorName"]] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*2];
    
    [self setLineView:[NSString stringWithFormat:@"商户位置：%@",cooperatorDictionary[@"address"]] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*3];
    
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*4, _scrollView.frame.size.width, self.view.frame.size.height/18)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
//    timeLabel.text = @"工作时间： 今天14:30";
    timeLabel.text = [NSString stringWithFormat:@"商户名称：%@",cooperatorDictionary[@"coopName"]];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18-5, _scrollView.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView3];
    
    
    // 备注
    UILabel *otherLabel = [[UILabel alloc]init];
    
    NSString *remarkString = orderDic[@"remark"];
//    NSLog(@"---_orderDictionary--%@--",_orderDictionary);
    
    if ([remarkString isKindOfClass:[NSNull class]]) {
        otherLabel.text = [NSString stringWithFormat:@"工作备注："];
    }else if(remarkString == NULL){
        otherLabel.text = [NSString stringWithFormat:@"工作备注："];
    }else{
        otherLabel.text = [NSString stringWithFormat:@"工作备注：%@",orderDic[@"remark"]];
    }
    
    CGSize detailSize = [otherLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT)];
    
    
    otherLabel.frame = CGRectMake(10, CGRectGetMaxY(timeLabel.frame)+5, self.view.frame.size.width-40, detailSize.height);
    
    
    otherLabel.font = [UIFont systemFontOfSize:14];
//    otherLabel.textAlignment = NSTextAlignmentRight;
    
    otherLabel.numberOfLines = 0;
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:otherLabel];
    
    
    // 立即抢单
    _certifyButton = [[UIButton alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width/4, CGRectGetMaxY(otherLabel.frame)+10, _scrollView.frame.size.width/2, self.view.frame.size.height/18)];
    [_certifyButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_certifyButton setBackgroundImage:[UIImage imageNamed:@"buttonClick"] forState:UIControlStateHighlighted];
    [_certifyButton setTitle:@"立即抢单" forState:UIControlStateNormal];
    [_certifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scrollView addSubview:_certifyButton];
    */
    
    
// 取消按钮
    _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, _scrollView.frame.origin.y-5-self.view.frame.size.height/3, 30, 30)];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"deleteOrder"] forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateHighlighted];
    [_cancelButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    
    
//    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(_certifyButton.frame)+20);
}

- (UILabel *)setLineView:(NSString *)title maxY:(float)maxY{
    
    // 施工时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, maxY + 10, _scrollView.frame.size.width, 40)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = title;
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 39, _scrollView.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [timeLabel addSubview:lineView3];
    
    return timeLabel;
}

#pragma mark - 抢单按钮的响应方法
- (void)workBtnClick{
    
    
    [GFHttpTool postOrderId:[_model.orderId integerValue] Success:^(NSDictionary *responseObject) {
        
//        NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"status"]integerValue] == 1) {
            
            CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
            addSuccess.model = _model;
            CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
            homeOrder.knockOrder = nil;
            [self.view removeFromSuperview];
            //            addSuccess.orderNum = _model.orderNumber;
            //            addSuccess.dataDictionary = _model.dataDictionary;
            addSuccess.isHome = YES;
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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp ,_photoArr[index]]];
    
    return url;
}


//- (void)setLineView:(NSString *)title maxY:(CGFloat)maxY{
//    
//    // 施工时间
//    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, maxY +4, self.view.frame.size.width, self.view.frame.size.height/18)];
//    //    timeLabel.backgroundColor = [UIColor cyanColor];
//    timeLabel.text = title;
//    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
//    timeLabel.font = [UIFont systemFontOfSize:14];
//    [_scrollView addSubview:timeLabel];
//    
//    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
//    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
//    [_scrollView addSubview:lineView3];
//    
//}




-(void)deleteBtnClick{
    
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    [userDefalts setObject:@"YES" forKey:@"homeOrder"];
    [userDefalts synchronize];
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    homeOrder.knockOrder = nil;
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
