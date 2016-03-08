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
    _orderView = [[UIView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, self.view.frame.size.height-80)];
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
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 150, 20)];
    titleLabel.text = @"汽车贴膜";
    [_orderView addSubview:titleLabel];
    
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    NSDictionary *orderDic = _orderDictionary[@"order"];
    mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake([orderDic[@"positionLat"]floatValue],[orderDic[@"positionLon"]floatValue]);
    mapVC.distanceBlock = ^(double distance) {
        NSLog(@"距离－－%f--",distance);
        _distanceLabel.text = [NSString stringWithFormat:@"距离：  %0.2fkm",distance/1000.0];
    };
    
    [_orderView addSubview:mapVC.view];
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    mapVC.view.frame = CGRectMake(0, 25, _orderView.frame.size.width, _orderView.frame.size.height/3);
    mapVC.mapView.frame = CGRectMake(0, 0, _orderView.frame.size.width, _orderView.frame.size.height/3);
}

- (void)setViewForAutobon{
    
    NSDictionary *orderDic = _orderDictionary[@"order"];
    
    // 距离label
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _orderView.frame.size.height/3+20, self.view.frame.size.width, self.view.frame.size.height/18)];
    //    distanceLabel.backgroundColor = [UIColor cyanColor];
    _distanceLabel.text = @"距离：  1.3km";
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
    [imageView sd_setImageWithURL:[NSURL URLWithString:orderDic[@"photo"]]];
    [_orderView addSubview:imageView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+_orderView.frame.size.height/4+5, _orderView.frame.size.width, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_orderView addSubview:lineView2];
    
    // 施工时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDic[@"orderTime"] integerValue]/1000];
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
    //    otherLabel.backgroundColor = [UIColor cyanColor];
//    otherLabel.text = @"工作备注：今天天气不错，适合工作";
//    otherLabel.text = [NSString stringWithFormat:@"工作备注：%@",orderDic[@"remark"]];
    otherLabel.text = [NSString stringWithFormat:@"工作备注：%@",@"今天天气不错，适合工作今天天气不错适合工作适合工作适合工作适合工作适合工作适合工作适合工作适合工作适合工作适合工作适合工作适合工作适合工作"];
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
    
    
    // 我要认证
    _certifyButton = [[UIButton alloc]initWithFrame:CGRectMake(_orderView.frame.size.width/4, _orderView.frame.size.height-_orderView.frame.size.height/18-7, _orderView.frame.size.width/2, self.view.frame.size.height/18)];
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
