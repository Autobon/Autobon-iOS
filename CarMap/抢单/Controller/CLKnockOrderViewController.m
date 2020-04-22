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
#import "AppDelegate.h"
#import "ACETelPrompt.h"

@interface CLKnockOrderViewController () <HZPhotoBrowserDelegate>
{
    UIScrollView *_scrollView;
    UILabel *_distanceLabel; // 距离label
    NSArray *_productOfferArray;
    NSArray *_setMenusArray;
}

@property (nonatomic, strong) CLHomeOrderCellModel *model;
@property (nonatomic, strong) NSArray *photoArr;
@property (nonatomic, strong) UIView *contentView;



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
    mDic[@"id"] = dic[@"id"];
//    NSLog(@"===请求的数据==%@", mDic);
    [GFHttpTool orderDDGetWithParameters:mDic success:^(id responseObject) {
        
        ICLog(@"----%@-", responseObject);
        if([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDictionary = responseObject[@"message"];
            CLHomeOrderCellModel *model = [[CLHomeOrderCellModel alloc] initWithDictionary:messageDictionary];
            _model = model;
            
//            NSLog(@"===%@", _model.cooperatorAddress);
            _productOfferArray = messageDictionary[@"productOfferShows"];
            if ([_productOfferArray isKindOfClass:[NSNull class]]){
                _productOfferArray = [[NSArray  alloc]init];
            }
            _setMenusArray = messageDictionary[@"setMenus"];
            if ([_setMenusArray isKindOfClass:[NSNull class]]){
                _setMenusArray = [[NSArray  alloc]init];
            }
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
    if (![orderDic[@"positionLat"] isKindOfClass:[NSNull class]] && ![orderDic[@"positionLat"] isKindOfClass:[NSNull class]]) {
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
    
    
    _contentView = [[UIView alloc]init];
    [_scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_scrollView);
        make.edges.equalTo(_scrollView);
    }];
    
    // 订单编号
    UILabel *orderNumberLabel = [[UILabel alloc]init];
    orderNumberLabel = [[UILabel alloc]init];
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
    _distanceLabel = [[UILabel alloc]init];
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
    float coorLocationLat = [self.model.customerLat floatValue];
    float coorLocationLng = [self.model.customerLon floatValue];

    CLLocationCoordinate2D myLocation = CLLocationCoordinate2DMake(myLocationLat, myLocationLng);
    CLLocationCoordinate2D coorLocation = CLLocationCoordinate2DMake(coorLocationLat, coorLocationLng);
    
    double distance = [GFMapViewController calculatorWithCoordinate1:myLocation withCoordinate2:coorLocation];
    _distanceLabel.text = [NSString stringWithFormat:@"距离：%0.2fkm",distance/1000.0];
    
    UIView *distanceLineView = [[UIView alloc]init];
    distanceLineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_contentView addSubview:distanceLineView];
    [distanceLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_distanceLabel.mas_bottom).offset(0);
        make.height.mas_offset(1);
    }];
    
    // 订单图片
    _photoArr = [_model.orderPhotoURL componentsSeparatedByString:@","];
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
    lastLineView = [self setLineView:[NSString stringWithFormat:@"订单类型：%@",self.model.orderType] lastView:lastLineView];
    
    
    
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
        
        UILabel *titleImageLabel = [[UILabel alloc]init];
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
            UILabel *menusNameLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30)];
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
        
        UILabel *titleImageLabel = [[UILabel alloc]init];
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
            UILabel *menusNameLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30)];
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
    
    
    
    
    
    
    lastLineView = [self setLineView:[NSString stringWithFormat:@"预约施工时间：%@",self.model.orderTime] lastView:lastLineView];
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
    lastLineView = [self setLineView:[NSString stringWithFormat:@"商户名称：%@",self.model.cooperatorName] lastView:lastLineView];
    lastLineView = [self setLineView:[NSString stringWithFormat:@"商户位置：%@",self.model.cooperatorAddress] lastView:lastLineView];
    
    // 备注
    UILabel *otherLabel = [[UILabel alloc]init];
    otherLabel.text = [NSString stringWithFormat:@"下单备注：%@",self.model.remark];
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
    
    // 取消按钮
    _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, _scrollView.frame.origin.y-5-self.view.frame.size.height/3, 30, 30)];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"deleteOrder"] forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateHighlighted];
    [_cancelButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    
    

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
    
    

    
    
//    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(_certifyButton.frame)+20);
}

- (UIView *)setLineView:(NSString *)title lastView:(UIView *)lastView{
    
    // label
    UILabel *label = [[UILabel alloc]init];
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

- (void)phoneBtnClick{
    [ACETelPrompt callPhoneNumber:_model.contactPhone call:^(NSTimeInterval duration) {
        
    } cancel:^{
        
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
