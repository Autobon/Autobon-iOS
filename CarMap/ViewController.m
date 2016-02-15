//
//  ViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/1/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "ViewController.h"
#import "GeTuiSdk.h"
#import "AppDelegate.h"

#define kGtAppId      @"bA8VREs20O83tJSR23Q2w4"
#define kGtAppKey     @"J7erlQojfG6L4Fli5I3kz1"
#define kGtAppSecret  @"9CI81CHleC6R4KyDvQYK35"

#import "FirstViewController.h"
#import "UMSocial.h"
#import "SecondViewController.h"
#import "PoiSearchDemoViewController.h"
#import "GFMapViewController.h"


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 120, 40)];
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"地图" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
//    FirstViewController *first = [[FirstViewController alloc]init];
//    [self.view addSubview:first.view];
//    [self addChildViewController:first];
//    [first didMoveToParentViewController:self];
//    // 绑定别名
//    [GeTuiSdk bindAlias:@"个推研发"];
//    // 取消绑定别名
//    [GeTuiSdk unbindAlias:@"个推研发"];
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请升级" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alertView show];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 120, 40)];
    shareBtn.backgroundColor = [UIColor greenColor];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    UIButton *mapButton = [[UIButton alloc]init];
    mapButton.frame = CGRectMake(100, 300, 120, 40);
    mapButton.backgroundColor = [UIColor redColor];
    [mapButton setTitle:@"相册" forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(mapBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];
    
    
    
    UIButton *imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 120, 40)];
    imageBtn.backgroundColor = [UIColor blueColor];
    [imageBtn setTitle:@"相机" forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imageBtn];
    
}

- (void)imageBtnClick{
    BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (result) {
        NSLog(@"---支持使用相机---");
    }else{
        NSLog(@"----不支持使用相机----");
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    NSLog(@"----选中了一张图片----");
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    imageView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:imageView];
    
    
//    NSURL *URL = [[NSURL alloc]initWithString:@"http://localhost:8080/Server1/upload"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL];
//    [request setHTTPMethod:@"POST"];
//    NSData *data = UIImageJPEGRepresentation(image, 0.3f);
//    [request setHTTPBody:data];
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)shareBtnClick{
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"564d41b4e0f55a596d003fe4" shareText:@"123" shareImage:nil  shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToSina,nil]delegate:self];

    
}

- (void)addMap{
    NSLog(@"添加地图");
    
    GFMapViewController *mapVC = [[GFMapViewController alloc] init];
    [self.view addSubview:mapVC.view];
    [self addChildViewController:mapVC];
    [mapVC didMoveToParentViewController:self];
    
}

-(void)mapBtnClick{
    PoiSearchDemoViewController *second = [[PoiSearchDemoViewController alloc]init];
//    SecondViewController *second = [[SecondViewController alloc]init];
//    self.view.window.rootViewController = second;
//    LineViewController *route = [[LineViewController alloc]init];
    [self.navigationController pushViewController:second animated:YES];
    
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    imagePickerController.allowsEditing = YES;
//    imagePickerController.delegate =self;
//    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    
}

- (void)btnClick{
//    [GeTuiSdk bindAlias:@"个推研发"];
    NSLog(@"发信号－－");
//    UILocalNotification* ln = [[UILocalNotification alloc] init];
//    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
//    ln.alertBody = @"category";
//    ln.category = @"123";
//    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"564d41b4e0f55a596d003fe4" shareText:@"123" shareImage:nil  shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToSina,nil]delegate:self];
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"564aa6fa67e58e4fc4002df9" shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social" shareImage:[UIImage imageNamed:@"fanhui_03.png"] shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone] delegate:self];
    
    FirstViewController *first = [[FirstViewController alloc]init];
    [self.navigationController pushViewController:first animated:NO];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
