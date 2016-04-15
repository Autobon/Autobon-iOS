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


@interface CLKnockOrderViewController ()
{
    UIView *_orderView;
    UILabel *_distanceLabel; // 距离label
}
@end

@implementation CLKnockOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc]initWithWhite:0.1 alpha:0.5];
    _orderView = [[UIView alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-20, self.view.frame.size.height-70)];
    _orderView.backgroundColor = [UIColor whiteColor];
    _orderView.layer.borderWidth = 1.0f;
    _orderView.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1]CGColor];
    _orderView.layer.cornerRadius = 10;
    
    
    [self.view addSubview:_orderView];
    
    
    [self addMap];
    
    [self setViewForAutobon];
    
    
    
}

// 添加地图
- (void)addMap{
    NSDictionary *orderDic = _orderDictionary[@"order"];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 150, 30)];
    NSArray *array = @[@"隔热层",@"隐形车衣",@"车身改色",@"美容清洁"];
    titleLabel.text = array[[orderDic[@"orderType"] integerValue]-1];
    [_orderView addSubview:titleLabel];
    
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    
    mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake([orderDic[@"positionLat"]floatValue],[orderDic[@"positionLon"]floatValue]);
    mapVC.bossPointAnno.iconImgName = @"location";
    mapVC.distanceBlock = ^(double distance) {
//        NSLog(@"距离－－%f--",distance);
        _distanceLabel.text = [NSString stringWithFormat:@"距离：  %0.2fkm",distance/1000.0];
    };
    
    [_orderView addSubview:mapVC.view];
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    mapVC.view.frame = CGRectMake(0, 35, _orderView.frame.size.width, _orderView.frame.size.height/3);
    mapVC.mapView.frame = CGRectMake(0, 0, _orderView.frame.size.width, _orderView.frame.size.height/3);
}

- (void)setViewForAutobon{
    
    NSDictionary *orderDic = _orderDictionary[@"order"];
    
    // 距离label
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _orderView.frame.size.height/3+30, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    distanceLabel.backgroundColor = [UIColor cyanColor];
    _distanceLabel.text = @"距离：  0km";
    _distanceLabel.font = [UIFont systemFontOfSize:14];
    _distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_orderView addSubview:_distanceLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _distanceLabel.frame.origin.y+self.view.frame.size.height/18, _orderView.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_orderView addSubview:lineView];
    
    // 订单图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, lineView.frame.origin.y + 7, _orderView.frame.size.width - 20, _orderView.frame.size.height/4)];
    //    imageView.backgroundColor = [UIColor darkGrayColor];
    imageView.image = [UIImage imageNamed:@"orderImage"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345%@",orderDic[@"photo"]]] placeholderImage:[UIImage imageNamed:@"orderImage"]];
    [_orderView addSubview:imageView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+_orderView.frame.size.height/4+5, _orderView.frame.size.width, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_orderView addSubview:lineView2];
    
    // 施工时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDic[@"orderTime"] floatValue]/1000];
    NSString *timeString = [formatter stringFromDate:date];
    
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView2.frame.origin.y, _orderView.frame.size.width, _orderView.frame.size.height/18)];
    //    timeLabel.backgroundColor = [UIColor cyanColor];
//    timeLabel.text = @"工作时间： 今天14:30";
    timeLabel.text = [NSString stringWithFormat:@"工作时间：%@",timeString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_orderView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18-5, _orderView.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_orderView addSubview:lineView3];
    
    
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
    if (_orderView.frame.size.height-lineView3.frame.origin.y-2-self.view.frame.size.height/18-7 > detailSize.height) {
        otherLabel.frame = CGRectMake(10, lineView3.frame.origin.y+2, self.view.frame.size.width-40, detailSize.height);
    }else{
        otherLabel.frame = CGRectMake(10, lineView3.frame.origin.y+2, self.view.frame.size.width-40, _orderView.frame.size.height-lineView3.frame.origin.y-2-self.view.frame.size.height/18-7);
    }
    
    otherLabel.font = [UIFont systemFontOfSize:14];
//    otherLabel.textAlignment = NSTextAlignmentRight;
    
    otherLabel.numberOfLines = 0;
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_orderView addSubview:otherLabel];
    
    
    // 立即抢单
    _certifyButton = [[UIButton alloc]initWithFrame:CGRectMake(_orderView.frame.size.width/4, _orderView.frame.size.height-_orderView.frame.size.height/18-10, _orderView.frame.size.width/2, self.view.frame.size.height/18)];
    [_certifyButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_certifyButton setBackgroundImage:[UIImage imageNamed:@"buttonClick"] forState:UIControlStateHighlighted];
    [_certifyButton setTitle:@"立即抢单" forState:UIControlStateNormal];
    [_certifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_orderView addSubview:_certifyButton];
    
    
// 取消按钮
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, _orderView.frame.origin.y-5, 30, 30)];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"deleteOrder"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
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
