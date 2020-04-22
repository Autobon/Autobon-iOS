//
//  CLAutobonViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/16.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLAutobonViewController.h"
#import "GFMapViewController.h"
#import "CLCertifyViewController.h"
#import "GFNavigationView.h"
#import "CLCertifyingViewController.h"
#import "CLCertifyFailViewController.h"

#import "GFFCertifyViewController.h"
#import "GFCertifyFaileViewController.h"

#import "GFHttpTool.h"

#import "GFCertifyModel.h"

#import "GFSignInViewController.h"


@interface CLAutobonViewController ()
{
    
    UIScrollView *_scrollView;
    
    
}

@property (nonatomic, strong) UIButton *shuomingView;

@end

@implementation CLAutobonViewController

- (UIButton *)certifyButton{
    if (!_certifyButton) {
        _certifyButton = [[UIButton alloc]init];
    }
    return _certifyButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc]initWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3+64, self.view.frame.size.width, self.view.frame.size.height*2/3-64-self.view.frame.size.height/18)];
    _scrollView.bounces = NO;
//    _scrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollView];
    
    [self setNavigation];
    
    [self addMap];
    
    [self setViewForAutobon];
}

// 添加地图
- (void)addMap{
    __block GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    mapVC.bossPointAnno.coordinate = CLLocationCoordinate2DMake(30.4,114.4);
    __weak GFMapViewController *weakMapVC = mapVC;
    mapVC.distanceBlock = ^(double distance) {
        [weakMapVC userLocationService];
    };
    
    [self.view addSubview:mapVC.view];
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    mapVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/3);
    mapVC.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3);
//
}

- (UIButton *)shuomingView {
    
    if(_shuomingView == nil) {
        
        UIButton *vv = [[UIButton alloc] init];
        vv.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        vv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:vv];
        [vv addTarget:self action:@selector(vvbutClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *str = @"认证通过后才能接单赚钱，快去认证吧！";
        CGRect strRect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width - 40 , strRect.size.height + 100);
        lab.backgroundColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = str;
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = [UIColor darkGrayColor];
        [vv addSubview:lab];
        lab.numberOfLines = 0;
        
        
        
        _shuomingView = vv;
    }
    
    return _shuomingView;
}
- (void)vvbutClick:(UIButton *)sender {
    
    self.shuomingView.hidden = YES;
}

- (void)setViewForAutobon{
    
// 距离label
    UILabel *distanceLabel = [[UILabel alloc] init];
    distanceLabel.frame = CGRectMake(10, -5, self.view.frame.size.width, self.view.frame.size.height/18);
//    distanceLabel.backgroundColor = [UIColor cyanColor];
    distanceLabel.text = @"距离：  ";
    distanceLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:distanceLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, distanceLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];
    
// 订单图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, lineView.frame.origin.y + 7, self.view.frame.size.width - 20, self.view.frame.size.height/4)];
//    imageView.backgroundColor = [UIColor darkGrayColor];
    imageView.image = [UIImage imageNamed:@"orderImage"];
    [_scrollView addSubview:imageView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+self.view.frame.size.height/4+5, self.view.frame.size.width, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView2];
    
    
    
// 施工时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(10, lineView2.frame.origin.y+4, self.view.frame.size.width, self.view.frame.size.height/18);
//    timeLabel.backgroundColor = [UIColor cyanColor];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    timeLabel.text = [NSString stringWithFormat:@"工作时间：%@",dateString];
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView3];
    
    
    
    
    [self setLineView:[NSString stringWithFormat:@"订单类型：%@",@""] maxY:lineView2.frame.origin.y+self.view.frame.size.height/18+1];
    
    [self setLineView:[NSString stringWithFormat:@"下单人员：%@",@""] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*2];
    
    [self setLineView:[NSString stringWithFormat:@"商户位置：%@",@""] maxY:lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*3];

    
    
// 备注
    UILabel *otherLabel = [[UILabel alloc] init];
    otherLabel.frame = CGRectMake(10, lineView2.frame.origin.y+(self.view.frame.size.height/18+1)*4, self.view.frame.size.width, self.view.frame.size.height/18);
//    otherLabel.backgroundColor = [UIColor cyanColor];
    otherLabel.text = @"工作备注：";
    otherLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:otherLabel];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/18-2, self.view.frame.size.width, 1)];
    lineView4.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView4];

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(otherLabel.frame));
// 我要接单
    UIButton *orderLabel = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/18, self.view.frame.size.width/2, self.view.frame.size.height/18)];
    [orderLabel setTitle:@"我要接单" forState:UIControlStateNormal];
    [orderLabel setTitleColor:[[UIColor alloc]initWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:orderLabel];
    [orderLabel addTarget:self action:@selector(jiedanButClick) forControlEvents:UIControlEventTouchUpInside];
    
// 我要认证
    _certifyButton.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-self.view.frame.size.height/18, self.view.frame.size.width/2, self.view.frame.size.height/18);
    
    [_certifyButton addTarget:self action:@selector(certifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_certifyButton setTitle:@"我要认证" forState:UIControlStateNormal];
    [_certifyButton setTitleColor:[[UIColor alloc]initWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:_certifyButton];
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-1, self.view.frame.size.height-self.view.frame.size.height/18, 1, self.view.frame.size.height/18)];
    lineView5.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView5];
    
}

- (void)jiedanButClick {
    
    self.shuomingView.hidden = NO;
}

- (void)setLineView:(NSString *)title maxY:(float)maxY{
    
    // 施工时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(10, maxY +4, self.view.frame.size.width, self.view.frame.size.height/18);
    //    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = title;
    timeLabel.textColor = [[UIColor alloc]initWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    [_scrollView addSubview:timeLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+self.view.frame.size.height/18, self.view.frame.size.width, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView3];
    
}



- (void)certifyBtnClick{
//    NSLog(@"认证按钮的响应方法");
    if ([_status isEqualToString:@"NEWLY_CREATED"]) {
        // 未认证
        GFFCertifyViewController *certify = [[GFFCertifyViewController alloc] init];
        [self.navigationController pushViewController:certify animated:YES];
    }else if ([_status isEqualToString:@"REJECTED"]){
        // 认证未通过
        [GFHttpTool getCertificateSuccess:^(id responseObject) {
            
            if([responseObject[@"status"] integerValue] == 1) {
//                NSLog(@"===认证界面＝＝＝%@", responseObject);
                NSDictionary *dicc = responseObject[@"message"];
                NSDictionary *dic = dicc[@"technician"];
                if([dic[@"status"] isEqualToString:@"REJECTED"]) {
                
                    GFCertifyModel *model = [[GFCertifyModel alloc] initWithDictionary:dic];
                    GFCertifyFaileViewController *homeVC = [[GFCertifyFaileViewController alloc] init];
                    homeVC.model = model;
                    [self.navigationController pushViewController:homeVC animated:YES];
                }else {
                
                    GFCertifyModel *model = [[GFCertifyModel alloc] initWithDictionary:dic];
                    CLCertifyingViewController *homeVC = [[CLCertifyingViewController alloc] init];
                    homeVC.model = model;
                    [self.navigationController pushViewController:homeVC animated:YES];
                }
                
//                GFCertifyModel *model = [[GFCertifyModel alloc] initWithDictionary:responseObject[@"message"]];
//                GFCertifyFaileViewController *homeVC = [[GFCertifyFaileViewController alloc] init];
//                homeVC.model = model;
//                [self.navigationController pushViewController:homeVC animated:YES];
            }
        } failure:^(NSError *error) {
            
            
        }];
    }else{
        // 正在认证
        
        [GFHttpTool getCertificateSuccess:^(id responseObject) {
            
            if([responseObject[@"status"] integerValue] == 1) {
                
                NSDictionary *dicc = responseObject[@"message"];
                NSDictionary *dic = dicc[@"technician"];
                if([dic[@"status"] isEqualToString:@"REJECTED"]) {
                
                    GFCertifyModel *model = [[GFCertifyModel alloc] initWithDictionary:dic];
                    GFCertifyFaileViewController *homeVC = [[GFCertifyFaileViewController alloc] init];
                    homeVC.model = model;
                    [self.navigationController pushViewController:homeVC animated:YES];
                }else {
//                    NSLog(@"===认证界面＝＝＝%@", responseObject);
                    GFCertifyModel *model = [[GFCertifyModel alloc] initWithDictionary:dic];
                    CLCertifyingViewController *homeVC = [[CLCertifyingViewController alloc] init];
                    homeVC.model = model;
                    [self.navigationController pushViewController:homeVC animated:YES];
                }
            }
        } failure:^(NSError *error) {
            
            
        }];
        
//        CLCertifyingViewController *homeVC = [[CLCertifyingViewController alloc] init];
//        [self.navigationController pushViewController:homeVC animated:YES];
    }
}



// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
//    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    

}

- (void)backBtnClick{
//    [self.navigationController popViewControllerAnimated:YES];
    
    UINavigationController *mavVC = [[UINavigationController alloc] initWithRootViewController:[[GFSignInViewController alloc] init]];
    mavVC.navigationBarHidden = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = mavVC;
    
    
//    CLHomeOrderViewController *home = [[CLHomeOrderViewController alloc]init];
//    [self.navigationController pushViewController:home animated:YES];

    
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
