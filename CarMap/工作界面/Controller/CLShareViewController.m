//
//  CLShareViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/3/2.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLShareViewController.h"
#import "GFNavigationView.h"
#import "GFMyMessageViewController.h"
#import "CLHomeOrderViewController.h"

#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>

@interface CLShareViewController ()<UMSocialShareMenuViewDelegate>

@end

@implementation CLShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setNavigation];
    
    [self setDate];
    
    [self setViewForShare];
    
    
    
}


// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"person" withRightImgHightName:@"personClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
    
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 20, 44, 44)];
    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    
    [shareButton setImage:[UIImage imageNamed:@"shareClick"] forState:UIControlStateHighlighted];
    [shareButton addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:shareButton];
    
    
    
}

- (void)shareBtnClick{
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWebPageToPlatformType:platformType];
    }];
    
    
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    
    
    //    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://media.incardata.com.cn/others%2f512-512.png"];
    //    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"车邻邦";
    //    [UMSocialData defaultData].extConfig.qqData.title = @"车邻邦";
    //    [UMSocialData defaultData].extConfig.qzoneData.title = @"车邻邦";
    //    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"564572b9e0f55a38dd001e6c" shareText:@"车邻邦专业的汽车保养团队" shareImage:[UIImage imageNamed:@"logoImage"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToSina,nil] delegate:self];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL =  @"http://media.incardata.com.cn/others%2f512-512.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"车邻邦" descr:@"车邻邦专业的汽车保养团队" thumImage:[UIImage imageNamed:@"logoImage"]];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"%@/shareA.html",BaseHttp];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            ICLog(@"************Share fail with error %@*********",error);
        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                ICLog(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                ICLog(@"response originalResponse data is %@",resp.originalResponse);
//
//            }else{
//                ICLog(@"response data is %@",data);
//            }
        }
        //        [self alertWithError:error];
    }];
}



#pragma mark - 设置日期和状态
- (void)setDate{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 36)];
    headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-120, 8, 100, 20)];
    stateLabel.text = @"工作完成模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:stateLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 36, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
    [headerView addSubview:view];
    
//    NSLog(@"设置日期和时间");
    //    headerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:headerView];
}

#pragma mark - 设置界面

- (void)setViewForShare{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, self.view.frame.size.width-60, 80)];
    label.text = [NSString stringWithFormat:@"恭喜，您已经顺利完成本次编号为%@的订单，分享可获得奖励啊！",_orderNumber];
//    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    
    // 提交按钮
    UIButton *submitButton = [[UIButton alloc]init];
    submitButton.frame = CGRectMake(30, 250, self.view.frame.size.width-60, 40);
    [submitButton setTitle:@"继续接单" forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"buttonClick"] forState:UIControlStateHighlighted];
    [submitButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}

- (void)submitBtnClick{
    
//    CLHomeOrderViewController *homeView = [[CLHomeOrderViewController alloc]init];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeView];
//    window.rootViewController = navigation;
//    navigation.navigationBarHidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 继续接单按钮响应方法
- (void)workOverBtnClick{
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

- (void)backBtnClick{
    
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
        [self.navigationController popToRootViewControllerAnimated:YES];
//    GFMyMessageViewController *myMessage = [[GFMyMessageViewController alloc]init];
//    [self.navigationController pushViewController:myMessage animated:YES];
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
