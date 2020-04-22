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
#import "AppDelegate.h"

@interface GFKeqiangDDViewController ()<HZPhotoBrowserDelegate>
{
    
    UIScrollView *_scrollView;
    GFMapViewController *_mapVC;
    NSArray *_productOfferArray;
    NSArray *_setMenusArray;
}

@property (nonatomic ,strong) UILabel *distanceLabel;

@property (nonatomic, strong) NSArray *photoArr;
@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation GFKeqiangDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [[UIColor alloc]initWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    
   
    [self setNavigation];
    
    [self getOrderDetail];
}

- (void)setViewForDetail{
    
    [self addMap];
    
//    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3+64, self.view.frame.size.width, self.view.frame.size.height*2/3-64-40)];
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_mapVC.view.mas_bottom);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    [self setViewForAutobon];
    
}



- (void)getOrderDetail{
    [GFHttpTool orderDDGetWithParameters:@{@"id": self.model.orderId} success:^(id responseObject) {
        ICLog(@"----responseObject---%@---", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDictionary = responseObject[@"message"];
            _productOfferArray = messageDictionary[@"productOfferShows"];
            if ([_productOfferArray isKindOfClass:[NSNull class]]){
                _productOfferArray = [[NSArray  alloc]init];
            }
            _setMenusArray = messageDictionary[@"setMenus"];
            if ([_setMenusArray isKindOfClass:[NSNull class]]){
                _setMenusArray = [[NSArray  alloc]init];
            }
            self.model.vehicleModel = [NSString stringWithFormat:@"%@", messageDictionary[@"vehicleModel"]];
        }
        [self setViewForDetail];
    } failure:^(NSError *error) {
        ICLog(@"----error---%@----", error);
    }];
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
//    __weak GFKeqiangDDViewController *weakOrder = self;
//    _mapVC.distanceBlock = ^(double distance) {
//        //        NSLog(@"距离－－%f--",distance);
//#pragma mark - 返回距离
//        weakOrder.distanceLabel.text = [NSString stringWithFormat:@"距离：%0.2fkm",distance/1000.0];
//    };
    
    
    
    
    [self.view addSubview:_mapVC.view];
    [self addChildViewController:_mapVC];
    [_mapVC didMoveToParentViewController:self];
    [_mapVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom);
        make.height.mas_offset(self.view.frame.size.height/3);
    }];
    [_mapVC.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(_mapVC.view);
    }];
    _mapVC.mapView.clipsToBounds = YES;
    
}

- (void)setViewForAutobon{
    
    
    _contentView = [[UIView alloc]init];
    [_scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_scrollView);
        make.edges.equalTo(_scrollView);
    }];
    
    
    // 订单编号
    UILabel *orderNumberLabel = [[UILabel alloc] init];
    orderNumberLabel = [[UILabel alloc] init];
    orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@",_model.orderNumber];
    orderNumberLabel.font = [UIFont systemFontOfSize:15];
    orderNumberLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_contentView addSubview:orderNumberLabel];
    [orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
    }];
    
    UIView *orderNumberLineView = [[UIView alloc]init];
    orderNumberLineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_contentView addSubview:orderNumberLineView];
    [orderNumberLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(orderNumberLabel.mas_bottom).offset(0);
        make.height.mas_offset(1);
    }];

    
    // 距离label
    _distanceLabel = [[UILabel alloc] init];
    _distanceLabel.text = @"距离：  ";
    _distanceLabel.font = [UIFont systemFontOfSize:15];
    _distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_contentView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(orderNumberLineView.mas_bottom);
        make.height.mas_offset(45);
    }];
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    float myLocationLat = [appDelegate.locationDictionary[@"lat"] floatValue];
    float myLocationLng = [appDelegate.locationDictionary[@"lng"] floatValue];
    float coorLocationLat = [self.customerLat floatValue];
    float coorLocationLng = [self.customerLon floatValue];
    
    CLLocationCoordinate2D myLocation = CLLocationCoordinate2DMake(myLocationLat, myLocationLng);
    CLLocationCoordinate2D coorLocation = CLLocationCoordinate2DMake(coorLocationLat, coorLocationLng);
    
    double distance = [GFMapViewController calculatorWithCoordinate1:myLocation withCoordinate2:coorLocation];
    self.distanceLabel.text = [NSString stringWithFormat:@"距离：%0.2fkm",distance/1000.0];
    
    UIView *distanceLineView = [[UIView alloc]init];
    distanceLineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_contentView addSubview:distanceLineView];
    [distanceLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.distanceLabel.mas_bottom).offset(0);
        make.height.mas_offset(1);
    }];

    
    // 订单图片
    _photoArr = [_orderPhotoURL componentsSeparatedByString:@","];
    //    NSLog(@"照片地址数组：%ld：：：%@", _photoArr.count, _photoArr);
    CGFloat butW = ([UIScreen mainScreen].bounds.size.width - 40) / 3.0;
    CGFloat butH = butW;
    for(int i=0; i<_photoArr.count; i++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
//        but.frame = CGRectMake(10 + (butW + 10) * (i % 3), distanceLineView.frame.origin.y + 7 + (butH + 10) * (i / 3), butW, butH);
        [but sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp, _photoArr[i]]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            ICLog(@"error---%@--", error);
            if(error){
                ICLog(@"图片加载失败");
                [but setImage:[UIImage imageNamed:@"load_image_failed"] forState:UIControlStateNormal];
            }
        }];
        but.clipsToBounds = YES;
        but.tag = i + 1;
        [_contentView addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10 + (butW + 10) * (i % 3));
            make.top.equalTo(distanceLineView.mas_bottom).offset(10 + (butH + 10) * (i / 3));
            make.width.mas_offset(butW);
            make.height.mas_offset(butH);
        }];
        [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(distanceLineView.mas_bottom).offset(10 + (butH + 10) * (( _photoArr.count - 1)/3 + 1));
        make.height.mas_offset(1);
    }];
    
    UIView *lastLineView;
    lastLineView = [self setLineView:[NSString stringWithFormat:@"车牌号：%@",self.model.license] lastView:lineView2];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"车驾号：%@",self.model.vin] lastView:lastLineView];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"车型：%@",self.model.vehicleModel] lastView:lastLineView];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"订单类型：%@",self.orderType] lastView:lastLineView];
    
    /*
    NSString *offerString = @"";
    for (int i = 0; i < _productOfferArray.count; i++) {
        NSDictionary *productOfferDictionary = _productOfferArray[i];
        if (i == 0){
            offerString = [NSString stringWithFormat:@"%@%@/%@", offerString, productOfferDictionary[@"constructionPositionName"], productOfferDictionary[@"model"]];
        }else{
            offerString = [NSString stringWithFormat:@"%@\r%@/%@", offerString, productOfferDictionary[@"constructionPositionName"], productOfferDictionary[@"model"]];
        }
    }
    UILabel *productDetailTitleLabel = [[UILabel alloc] init];
    productDetailTitleLabel.text = @"施工详情：";
    productDetailTitleLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
//    productDetailTitleLabel.frame = CGRectMake(10, lineView2.frame.origin.y+ 40*4, 90, 40);
    [_contentView addSubview:productDetailTitleLabel];
    [productDetailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(lastLineView).offset(0);
        make.height.mas_offset(45);
    }];
    
    UILabel *productDetailValueLabel = [[UILabel alloc] init];
    productDetailValueLabel.text = offerString;
    productDetailValueLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    productDetailValueLabel.numberOfLines = 0;
    productDetailValueLabel.frame = CGRectMake(95, lineView2.frame.origin.y+ 40*4, self.view.frame.size.width - 120, 20 + 20*_productOfferArray.count);
    [_contentView addSubview:productDetailValueLabel];
    [productDetailValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(95);
        make.top.equalTo(lastLineView).offset(0);
        make.right.equalTo(self.contentView).offset(-25);
        make.height.mas_offset(25 + 20*_productOfferArray.count);
    }];
    
    
    
    UIView *productLineView = [[UIView alloc]initWithFrame:CGRectMake(0,  lineView2.frame.origin.y+ 40*4 + 20 + 20*_productOfferArray.count + 0, self.view.frame.size.width, 1)];
    if (_productOfferArray.count == 0){
        productLineView.frame = CGRectMake(0,  lineView2.frame.origin.y+ 40*4 + 20 + 20 + 0, self.view.frame.size.width, 1);
    }
    productLineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_contentView addSubview:productLineView];
    [productLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        if(_productOfferArray.count == 0){
            make.top.equalTo(productDetailTitleLabel.mas_bottom);
        }else{
            make.top.equalTo(productDetailValueLabel.mas_bottom);
        }
        make.height.mas_offset(1);
    }];
    */
    
    
#pragma mark - 报价产品
    if (_productOfferArray.count > 0){
        UIView *titleBaseView = [[UIView alloc]init];
        titleBaseView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [self.contentView addSubview:titleBaseView];
        [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(lastLineView.mas_bottom);
            make.height.mas_offset(45);
        }];
        
        
        UIView *leftLittleView = [[UIView alloc]init];
        leftLittleView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [titleBaseView addSubview:leftLittleView];
        [leftLittleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView);
            make.centerY.mas_offset(16);
            make.width.mas_offset(6);
        }];
        
        
        UILabel *menusTitleLab = [[UILabel alloc] init];
        menusTitleLab.textColor = [UIColor darkGrayColor];
        menusTitleLab.font = [UIFont systemFontOfSize:14];
        menusTitleLab.text = [NSString stringWithFormat:@"报价产品"];
        [titleBaseView addSubview:menusTitleLab];
        [menusTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView).offset(20);
            make.centerY.equalTo(titleBaseView);
            make.right.equalTo(titleBaseView).offset(-20);
            make.height.mas_offset(30);
        }];
        
        UIView *titleImageBaseView = [[UIView alloc]init];
        titleImageBaseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:titleImageBaseView];
        [titleImageBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(titleBaseView.mas_bottom);
            make.height.mas_offset(40);
        }];
        
        
        UIImageView *titleImageView = [[UIImageView alloc]init];
        titleImageView.image = [UIImage imageNamed:@"cpin"];
        [titleImageBaseView addSubview:titleImageView];
        titleImageView.frame = CGRectMake(20, 12, 15, 15);
        
        UILabel *titleImageLabel = [[UILabel alloc] init];
        titleImageLabel.text = @"型号+部位";
        titleImageLabel.font = [UIFont boldSystemFontOfSize:14];
        [titleImageBaseView addSubview:titleImageLabel];
        titleImageLabel.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30);
        
        UIView *titleLineView = [[UIView alloc]init];
        titleLineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [titleImageBaseView addSubview:titleLineView];
        titleLineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        
        lastLineView = titleImageBaseView;
        for (int i = 0; i < _productOfferArray.count; i++) {
            
            UIView *titleBaseView = [[UIView alloc]init];
            titleBaseView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:titleBaseView];
            [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView);
                make.top.equalTo(lastLineView.mas_bottom);
                make.height.mas_offset(40);
            }];
            lastLineView = titleBaseView;
            
            
            NSDictionary *productDict = _productOfferArray[i];
            UILabel *menusNameLab = [[UILabel alloc] init];
            menusNameLab.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30);
            menusNameLab.textColor = [UIColor darkGrayColor];
            menusNameLab.font = [UIFont systemFontOfSize:14];
            menusNameLab.text = [NSString stringWithFormat:@"%@--%@", productDict[@"model"], productDict[@"constructionPositionName"]];
            [titleBaseView addSubview:menusNameLab];
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
            [titleBaseView addSubview:lineView];
            lineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        }
    }
    
    
    
#pragma mark - 施工套餐
    
    if (_setMenusArray.count > 0){
        
        UIView *titleBaseView = [[UIView alloc]init];
        titleBaseView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [self.contentView addSubview:titleBaseView];
        [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(lastLineView.mas_bottom);
            make.height.mas_offset(45);
        }];
        
        UIView *leftLittleView = [[UIView alloc]init];
        leftLittleView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [titleBaseView addSubview:leftLittleView];
        [leftLittleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView);
            make.centerY.equalTo(titleBaseView);
            make.height.mas_offset(16);
            make.width.mas_offset(6);
        }];
        
        UILabel *menusTitleLab = [[UILabel alloc] init];
        menusTitleLab.textColor = [UIColor darkGrayColor];
        menusTitleLab.font = [UIFont systemFontOfSize:14];
        menusTitleLab.text = [NSString stringWithFormat:@"组合套餐"];
        [titleBaseView addSubview:menusTitleLab];
        [menusTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView).offset(20);
            make.centerY.equalTo(titleBaseView);
            make.right.equalTo(titleBaseView).offset(-20);
            make.height.mas_offset(30);
        }];
        
        UIView *titleImageBaseView = [[UIView alloc]init];
        titleImageBaseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:titleImageBaseView];
        [titleImageBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(titleBaseView.mas_bottom);
            make.height.mas_offset(40);
        }];
        
        UIImageView *titleImageView = [[UIImageView alloc]init];
        titleImageView.image = [UIImage imageNamed:@"tchan"];
        [titleImageBaseView addSubview:titleImageView];
        titleImageView.frame = CGRectMake(20, 12, 15, 15);
        
        UILabel *titleImageLabel = [[UILabel alloc] init];
        titleImageLabel.text = @"套餐名称";
        titleImageLabel.font = [UIFont boldSystemFontOfSize:14];
        [titleImageBaseView addSubview:titleImageLabel];
        titleImageLabel.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30);
        
        UIView *titleLineView = [[UIView alloc]init];
        titleLineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [titleImageBaseView addSubview:titleLineView];
        titleLineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        
        lastLineView = titleImageBaseView;
        
        for (int i = 0; i < _setMenusArray.count; i++) {
            
            UIView *titleBaseView = [[UIView alloc]init];
            titleBaseView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:titleBaseView];
            [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView);
                make.top.equalTo(lastLineView.mas_bottom);
                make.height.mas_offset(40);
            }];
            lastLineView = titleBaseView;
            
            
            NSDictionary *menusDict = _setMenusArray[i];
            UILabel *menusNameLab = [[UILabel alloc] init];
            menusNameLab.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30);
            menusNameLab.textColor = [UIColor darkGrayColor];
            menusNameLab.font = [UIFont systemFontOfSize:14];
            menusNameLab.text = [NSString stringWithFormat:@"%@", menusDict[@"name"]];
            [titleBaseView addSubview:menusNameLab];
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
            [titleBaseView addSubview:lineView];
            lineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
            
        }
    }
    
    
    
    
    
    
    lastLineView = [self setLineView:[NSString stringWithFormat:@"预约施工时间：%@",self.orderTime] lastView:lastLineView];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"最晚交车时间：%@",_model.agreedEndTime] lastView:lastLineView];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"下单人员：%@",_model.creatorName]  lastView:lastLineView];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"联系方式：%@",_model.contactPhone] lastView:lastLineView];
    
    UIButton *phoneButton = [[UIButton alloc]init];
    [phoneButton setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    [_contentView addSubview:phoneButton];
    [phoneButton addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-50);
        make.bottom.equalTo(lastLineView.mas_top).offset(-5);
        make.width.mas_offset(35);
        make.height.mas_offset(35);
    }];
    
    
    
    lastLineView = [self setLineView:[NSString stringWithFormat:@"下单时间：%@",_model.createTime] lastView:lastLineView];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"商户名称：%@",self.cooperatorName] lastView:lastLineView];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"商户位置：%@",self.cooperatorAddress] lastView:lastLineView];
    
    // 备注
    UILabel *otherLabel = [[UILabel alloc] init];
    otherLabel.text = [NSString stringWithFormat:@"下单备注：%@",self.remark];
    otherLabel.font = [UIFont systemFontOfSize:15];
    otherLabel.numberOfLines = 0;
    CGRect detailSize = [otherLabel.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_contentView addSubview:otherLabel];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(lastLineView.mas_bottom).offset(10);
        make.height.mas_offset(detailSize.size.height + 5);
        
        make.bottom.equalTo(self.contentView).offset(-60);
    }];
    
    
    // 抢单
    UIButton *workButton = [[UIButton alloc]initWithFrame:CGRectMake(25, self.view.frame.size.height-60, self.view.frame.size.width - 50, 40)];
    [workButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    workButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:workButton];
    [workButton addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [workButton setTitle:@"抢单" forState:UIControlStateNormal];
    workButton.layer.cornerRadius = 7.5;
    
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

- (UIView *)setLineView:(NSString *)title lastView:(UIView *)lastView{
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:15];
    [_contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(lastView.mas_bottom);
        make.height.mas_offset(45);
    }];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,  39, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_offset(1);
        make.top.equalTo(label.mas_bottom);
    }];
    
    return lineView;
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
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    UIButton *removeOrderButton = [[UIButton alloc]init];
    [removeOrderButton setTitle:@"收藏" forState:UIControlStateNormal];
    [removeOrderButton setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [_navView addSubview:removeOrderButton];
    
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [removeOrderButton addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    
    [removeOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_navView).offset(-4);
        make.right.equalTo(_navView).offset(-20);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    
    [self.view addSubview:_navView];
    
    
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
