//
//  AppDelegate.m
//  CarMap
//
//  Created by 李孟龙 on 16/1/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "AppDelegate.h"
#import "GeTuiSdk.h"
#import "FirstViewController.h"
#import "ViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "SecondViewController.h"
#import "TestViewController.h"
#import "GFMapViewController.h"
//#import "ViewController.h"
#import "CLAutobonViewController.h"
#import "CLCertifyViewController.h"


// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId      @"bA8VREs20O83tJSR23Q2w4"
#define kGtAppKey     @"J7erlQojfG6L4Fli5I3kz1"
#define kGtAppSecret  @"9CI81CHleC6R4KyDvQYK35"

@interface AppDelegate ()<GeTuiSdkDelegate,BMKGeneralDelegate>
{
    NSDictionary *_launchDict;
    BMKMapManager *_mapManager;
//    ViewController *_firstView;
    UINavigationController *_navigation;
}
@end

@implementation AppDelegate

//如果应用程序没有存活，点击推送打开程序，那么会在 launchOptions 中加入一对 key-value，value 就是当前激活的推送对象。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _launchDict = [[NSDictionary alloc]initWithDictionary:launchOptions];
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];
    
    // 注册APNS
    [self registerUserNotification];
    
    
    
    [UMSocialData setAppKey:@"564d41b4e0f55a596d003fe4"];
    
    
    [UMSocialWechatHandler setWXAppId:@"wxccc42b939e04a75a" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105028016" appKey:@"9xBu4r8AcljNU4bS" url:@"http://www.umeng.com/social"];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"439118116" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"qQxUcaGNCZfeFmhB8EHWVvgt" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
//    _firstView = [[ViewController alloc]init];
//    CLAutobonViewController *firstView = [[CLAutobonViewController alloc]init];
    CLCertifyViewController *firstView = [[CLCertifyViewController alloc]init];
    _navigation = [[UINavigationController alloc]initWithRootViewController:firstView];
    _navigation.navigationBarHidden = YES;
    _window.rootViewController = _navigation;
    [_window makeKeyAndVisible];
    
    return YES;
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


//-(void)applicationWillEnterForeground:(UIApplication *)application{
//    NSLog(@"回到前台");
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSLog(@"---daying--%@--",[userDefaults objectForKey:@"title"]);
//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
//    UILocalNotification *note = dictionary[UIApplicationLaunchOptionsLocalNotificationKey];
//    [dictionary description];
//    NSLog(@"--222-daying--%@--",[_launchDict description]);
//    
//    
//}


#pragma mark - 用户通知(推送) _自定义方法

/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */

    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        NSLog(@"zounaqule--");
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert;
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        NSLog(@"注册APNs");
    } else {
        NSLog(@"zounaquleaaaaa");
        // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        // 注册远程通知 -根据远程通知类型
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
        return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>---->>[Launching RemoteNotification]:%@", userInfo);
    }
}

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *myToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [GeTuiSdk registerDeviceToken:myToken];    /// 向个推服务器注册deviceToken
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n",myToken);
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GeTuiSdk registerDeviceToken:@""];     /// 如果APNS注册失败，通知个推服务器
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n",error.description);
}



- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//Background Fetch 恢复SDK 运行
    NSLog(@"后台运行");
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
//    UILocalNotification* ln = [[UILocalNotification alloc] init];
//    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
//    ln.alertBody = @"category";
//    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
//    NSLog(@"方法运行了");
    
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}
/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}


/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId {
    // [4]: 收到个推消息
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
        }
    NSString *msg = [NSString stringWithFormat:@" payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    /**
     *汇报个推自定义事件
     *actionId：用户自定义的actionid，int类型，取值90001-90999。
     *taskId：下发任务的任务ID。
     
     *msgId： 下发任务的消息ID。
     *返回值：BOOL，YES表示该命令已经提交，NO表示该命令未提交成功。注：该结果不代表服务器收到该条命令
     **/
    [GeTuiSdk sendFeedbackMessage:90001 taskId:taskId msgId:aMsgId];
//    NSLog(@"接受消息");
//    UILocalNotification* ln = [[UILocalNotification alloc] init];
//    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
//    ln.alertBody = @"category";
//    [[UIApplication sharedApplication] scheduleLocalNotification:ln];

//    FirstViewController *first = [[FirstViewController alloc]init];
//    first.labelTitle = @"地图";
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [window addSubview:first.view];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    FirstViewController *first = [[FirstViewController alloc]init];
    [_navigation pushViewController:first animated:NO];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
// 收到的推送消息还是要存储起来的，用来查看历史订单不用存储到数据库中吧
    
}

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
#pragma mark - 后台运行调用的方法
    NSLog(@"\n>>>[Receive ------ RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"通知消息" forKey:@"title"];
    completionHandler(UIBackgroundFetchResultNewData);
//    [UIApplication sharedApplication].scheduledLocalNotifications = ln;
//    UILocalNotification* ln = [[UILocalNotification alloc] init];
//    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
//    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
//    NSLog(@"方法运行了");

}


//当应用程序存活并收到推送的时候。
//如果应用程序正在前台使用，直接调用这个方法，不产生提示。
//如果应用程序在后台，会产生提示。如果点击推送的消息打开应用程序，那么会调用这个方法。如果点击 icon 打开应用程序，就不会调用这个方法。
//如果应用程序没有存活，会产生提示，但是无论通过那种方式启动应用程序，都不会调用这个方法。如果我们需要处理收到的通知消息，我们需要使用上面的方法。
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //系统提供给我们用来处理收到推送后操作的方法。
    NSLog(@"消息来了a－－%@",notification.alertBody);
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 120, 120)];
//    view.backgroundColor = [UIColor cyanColor];
    
//    first.labelTitle = @"地图";
//    SecondViewController *second = [[SecondViewController alloc]init];
//    GFMapViewController *test = [[GFMapViewController alloc]init];
//    FirstViewController *first = [[FirstViewController alloc]init];
//    [_navigation pushViewController:first animated:NO];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [window addSubview:test.view];
//    [_window presentViewController:vc animated:YES completion:nil];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:@"tongzhi" forKey:@"title"];
//    [window addChildViewController:first];
//    [first didMoveToParentViewController:window];
//    [_firstView addMap];
    
    
}

-(void)btnClick:(UIButton *)button{
    [[button superview] removeFromSuperview];
    NSLog(@"移走view");
}

@end
