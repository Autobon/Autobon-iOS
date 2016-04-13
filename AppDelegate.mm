//
//  AppDelegate.m
//  CarMap
//
//  Created by 李孟龙 on 16/1/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "AppDelegate.h"
#import "GeTuiSdk.h"
#import "FirstViewController.h"
//#import "ViewController.h"
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
#import "CLHomeOrderViewController.h"
#import "CLCertifyingViewController.h"
#import "CLCertifyFailViewController.h"
#import "CLMoreViewController.h"
#import "CLKnockOrderViewController.h"
#import "CLWorkBeforeViewController.h"
#import "CLWorkOverViewController.h"
#import "CLAddPersonViewController.h"
#import "CLMoreViewController.h"
#import "CLCleanWorkViewController.h"
#import "CLShareViewController.h"
#import "CLAddOrderSuccessViewController.h"
#import "GFTestViewController.h"
#import "GFMyMessageViewController.h"
#import "GFSignInViewController.h"
#import "CLCooperateFailViewController.h"
#import "CLCooperatingViewController.h"
#import "GFNoIndentViewController.h"
#import "GFMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "GFHttpTool.h"


// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId      @"zoCAUGD4Hi55CS6iW1OI77"
#define kGtAppKey     @"ESlofHVour7DmT7xy7cnJ9"
#define kGtAppSecret  @"1VX09PPTcz7fdHBNYZVeB2"

//#define kGtAppId      @"bA8VREs20O83tJSR23Q2w4"
//#define kGtAppKey     @"J7erlQojfG6L4Fli5I3kz1"
//#define kGtAppSecret  @"9CI81CHleC6R4KyDvQYK35"

@interface AppDelegate ()<GeTuiSdkDelegate,BMKGeneralDelegate,CLLocationManagerDelegate>
{
    NSDictionary *_launchDict;
    BMKMapManager *_mapManager;
//    ViewController *_firstView;
    UINavigationController *_navigation;
    NSDate *_pushDate;
    
    CLGeocoder *_coder;
    //存储上一次的位置
    CLLocationManager *_manager;
//    NSTimer *_timer;
}
@end

@implementation AppDelegate

//如果应用程序没有存活，点击推送打开程序，那么会在 launchOptions 中加入一对 key-value，value 就是当前激活的推送对象。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    _launchDict = [[NSDictionary alloc]initWithDictionary:launchOptions];
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];
    
    // 注册APNS
    [self registerUserNotification];
    
    
    [UMSocialData setAppKey:@"564572b9e0f55a38dd001e6c"];
    
    
    [UMSocialWechatHandler setWXAppId:@"wx0d70fda19b5c107c" appSecret:@"bac3ef447782aa76059af754510d84ca" url:@"http://www.incardata.com.cn"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105263986" appKey:@"sjj2sjhLIqtjmcfL" url:@"http://www.incardata.com.cn"];
    
//    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"439118116" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"qQxUcaGNCZfeFmhB8EHWVvgt" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults  removeObjectForKey:@"homeOrder"];
    
   
//    CLShareViewController *firstView = [[CLShareViewController alloc]init];
//    CLHomeOrderViewController *firstView = [[CLHomeOrderViewController alloc]init];
//    CLAddOrderSuccessViewController *firstView = [[CLAddOrderSuccessViewController alloc]init];
//    PoiSearchDemoViewController *firstView = [[PoiSearchDemoViewController alloc]init];
//    CLCertifyFailViewController *firstView = [[CLCertifyFailViewController alloc]init];
//    CLWorkOverViewController *firstView = [[CLWorkOverViewController alloc]init];
//    CLCooperateFailViewController *firstView = [[CLCooperateFailViewController alloc]init];
//    CLCooperatingViewController *firstView = [[CLCooperatingViewController alloc]init];
//    GFNoIndentViewController *firstView = [[GFNoIndentViewController alloc]init];
    
//    _navigation = [[UINavigationController alloc]initWithRootViewController:firstView];
    //********************* 光法页面 **********************
//    GFMyMessageViewController *messageVC = [[GFMyMessageViewController alloc] init];
    
    GFSignInViewController *signInVC = [[GFSignInViewController alloc] init];
//    CLMoreViewController *moreVC = [[CLMoreViewController alloc] init];

    _navigation = [[UINavigationController alloc]initWithRootViewController:signInVC];


//    GFMyMessageViewController *messageVC = [[GFMyMessageViewController alloc] init];
//    GFSignInViewController *signInVC = [[GFSignInViewController alloc] init];
//    CLMoreViewController *moreVC = [[CLMoreViewController alloc] init];

//    _navigation = [[UINavigationController alloc]initWithRootViewController:firstView];


    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    if ([userDefaultes objectForKey:@"autoken"]) {
        //1.创建定位管理对象
        _manager=[[CLLocationManager alloc]init];
        _coder=[[CLGeocoder alloc]init];
        _manager.distanceFilter=kCLDistanceFilterNone;//实时更新定位位置
        _manager.desiredAccuracy=kCLLocationAccuracyBest;//定位精确度
        if([_manager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_manager requestAlwaysAuthorization];
        }
        //该模式是抵抗程序在后台被杀，申明不能够被暂停
        _manager.pausesLocationUpdatesAutomatically=NO;
        //3.设置代理
        _manager.delegate=self;
        //4.开始定位
        [_manager startUpdatingLocation];
    }

    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];

    _navigation.navigationBarHidden = YES;
    _window.rootViewController = _navigation;
    [_window makeKeyAndVisible];
    
    
    
   
    
    
    return YES;
}




#pragma mark-CLLocationManager代理方法
//定位失败时调用的方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败了%@",error);
}
//定位成功调用的的方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
//    NSLog(@"－－－－－");
    
    
    if(locations.count>0)
    {
        //        获取位置信息
        CLLocation *loc=[locations lastObject];
        //        获取经纬度的结构体
        CLLocationCoordinate2D coor=loc.coordinate;
        CLLocation *location=[[CLLocation alloc]initWithLatitude:coor.latitude longitude:coor.longitude];
        
        NSString *URLString = [NSString stringWithFormat:@"http://api.map.baidu.com/geoconv/v1/?ak=FPzmlgz02SERkbPsRyGOiGfj&coords=%f,%f",coor.longitude,coor.latitude];
        __block NSMutableDictionary *locationDictionary = [[NSMutableDictionary alloc]init];
        [GFHttpTool getCoordsURLString:URLString success:^(id responseObject) {
//            NSLog(@"－－－－请求成功－－－%@--",responseObject);
            if ([responseObject[@"status"] integerValue] == 0) {
                NSArray *resultArray = responseObject[@"result"];
                NSDictionary *resultDictionary = resultArray[0];
                locationDictionary[@"lng"] = resultDictionary[@"x"];
                locationDictionary[@"lat"] = resultDictionary[@"y"];
                [_coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                    CLPlacemark *pmark=[placemarks firstObject];
                    NSString *state = pmark.addressDictionary[@"State"];
                    NSString *city = pmark.addressDictionary[@"City"];
                    NSString *subLocality = pmark.addressDictionary[@"SubLocality"];
                    NSString *street = pmark.addressDictionary[@"Street"];
                    
                    locationDictionary[@"province"] = state;
                    locationDictionary[@"city"] = city;
                    locationDictionary[@"district"] = subLocality;
                    locationDictionary[@"street"] = street;
//                    NSLog(@"-----location---%@---",locationDictionary);
                    [GFHttpTool PostReportLocation:locationDictionary success:^(id responseObject) {
                        
                        NSLog(@"－－－－上传实时位置成功－－－%@－－－-----%@--",responseObject,responseObject[@"message"]);
                        if ([responseObject[@"result"] integerValue] == 1) {
                            [_manager stopUpdatingLocation];
                            [_manager performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:60];
                        }
                        
                        
                    } failure:^(NSError *error) {
                        
//                        NSLog(@"上传实时位置失败---%@---",error);
                        
                    }];
                }];
            }
        } failure:^(NSError *error) {
            
        }];
        
        
        
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
        if([CLLocationManager significantLocationChangeMonitoringAvailable])
        {
//            ViewController *vc=(ViewController *)self.window.rootViewController;
            [_manager stopUpdatingLocation];
            [_manager startMonitoringSignificantLocationChanges];
        }
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
        if([CLLocationManager significantLocationChangeMonitoringAvailable])
        {
//            ViewController *vc=(ViewController *)self.window.rootViewController;
            [_manager stopMonitoringSignificantLocationChanges];
            [_manager startUpdatingLocation];
        }
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
        UIUserNotificationType types = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:clientId forKey:@"clientId"];
}
/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}


#pragma mark - 个推通知响应方法
/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId {
    // [4]: 收到个推消息
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
    NSString *msg = [NSString stringWithFormat:@" payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>前台>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    [GeTuiSdk sendFeedbackMessage:90001 taskId:taskId msgId:aMsgId];
    if (!offLine) {
        NSData *JSONData = [payloadMsg dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        
        
        if ([responseJSON[@"action"]isEqualToString:@"NEW_ORDER"] || [responseJSON[@"action"]isEqualToString:@"INVITE_PARTNER"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if ([[userDefaults objectForKey:@"homeOrder"]isEqualToString:@"YES"]) {
                
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NEW_ORDER" object:self userInfo:responseJSON];
                
                //            CLHomeOrderViewController *orderView = [[CLHomeOrderViewController alloc]init];
                //            [self.window.rootViewController presentViewController:orderView animated:YES completion:nil];
                
            }else{
                UILocalNotification*notification = [[UILocalNotification alloc] init];
                if (nil != notification)
                {
                    notification.fireDate = [NSDate date];
                    _pushDate = [NSDate date];
                    NSLog(@"----_pushDate-%@--%@-----",_pushDate,[NSDate date]);
                    notification.alertTitle = @"车邻邦";
                    notification.alertBody = responseJSON[@"title"];
                    notification.userInfo = @{@"dictionary":payloadMsg};
                    
                    AudioServicesPlaySystemSound(1307);
                    NSLog(@"发出通知吧－－－%@--",notification.userInfo);
                    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
                }
            }
        }else if ([responseJSON[@"action"]isEqualToString:@"VERIFICATION_FAILED"] || [responseJSON[@"action"]isEqualToString:@"VERIFICATION_SUCCEED"]||[responseJSON[@"action"]isEqualToString:@"INVITATION_ACCEPTED"]){
            UILocalNotification*notification = [[UILocalNotification alloc] init];
            if (nil != notification)
            {
                notification.fireDate = [NSDate date];
                _pushDate = [NSDate date];
                NSLog(@"----_pushDate-%@--%@-----",_pushDate,[NSDate date]);
                notification.alertTitle = @"车邻邦";
                notification.alertBody = responseJSON[@"title"];
                notification.userInfo = @{@"dictionary":payloadMsg};
                AudioServicesPlaySystemSound(1307);
                [[UIApplication sharedApplication]scheduleLocalNotification:notification];
            }
            
        }else if ([responseJSON[@"action"]isEqualToString:@"INVITATION_REJECTED"]){
            UILocalNotification*notification = [[UILocalNotification alloc] init];
            if (nil != notification)
            {
                notification.fireDate = [NSDate date];
                _pushDate = [NSDate date];
                NSLog(@"----_pushDate-%@--%@-----",_pushDate,[NSDate date]);
                notification.alertTitle = @"车邻邦";
                notification.alertBody = responseJSON[@"title"];
                AudioServicesPlaySystemSound(1307);
                [[UIApplication sharedApplication]scheduleLocalNotification:notification];
            }
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"NEW_ORDER" object:self userInfo:@{@"INVITATION_REJECTED":@"INVITATION_REJECTED"}];
        }
    }
    
    
    
//    else if ([responseJSON[@"action"]isEqualToString:@"INVITE_PARTNER"]){
//        UILocalNotification*notification = [[UILocalNotification alloc] init];
//        if (nil != notification)
//        {
//            notification.fireDate = [NSDate date];
//            _pushDate = [NSDate date];
//            notification.alertTitle = @"车邻邦";
//            notification.alertBody = responseJSON[@"title"];
//            AudioServicesPlaySystemSound(1307);
//            [[UIApplication sharedApplication]scheduleLocalNotification:notification];
//        }
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// 收到的推送消息还是要存储起来的，用来查看历史订单不用存储到数据库中吧
    
}












/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
#pragma mark - 后台运行调用的方法
    NSLog(@"\n>>>[Receive ------ RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    completionHandler(UIBackgroundFetchResultNewData);
    
//    NSLog(@"json----%@--",userInfo[@"json"]);
    NSData *JSONData = [userInfo[@"json"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"----responseJSON----%@---",responseJSON);
    if ([responseJSON[@"action"] isEqualToString:@"NEW_ORDER"]||[responseJSON[@"action"]isEqualToString:@"INVITE_PARTNER"]) {
        if (![[userDefaults objectForKey:@"homeOrder"]isEqualToString:@"YES"]) {
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            CLHomeOrderViewController *homeOrderView = [[CLHomeOrderViewController alloc]init];
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeOrderView];
            navigation.navigationBarHidden = YES;
            window.rootViewController = navigation;
        }
#warning --发通知
        [self performSelector:@selector(after:) withObject:responseJSON afterDelay:1.0];
    }
    

}


//当应用程序存活并收到推送的时候。
//如果应用程序正在前台使用，直接调用这个方法，不产生提示。
//如果应用程序在后台，会产生提示。如果点击推送的消息打开应用程序，那么会调用这个方法。如果点击 icon 打开应用程序，就不会调用这个方法。
//如果应用程序没有存活，会产生提示，但是无论通过那种方式启动应用程序，都不会调用这个方法。如果我们需要处理收到的通知消息，我们需要使用上面的方法。
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //系统提供给我们用来处理收到推送后操作的方法。
//    NSLog("-----%@-----%@---",_pushDate,[NSDate date]);
    
    
    long time = (long)[[NSDate date] timeIntervalSince1970] - [_pushDate timeIntervalSince1970];
//    NSLog(@"---time--%@----",notification.userInfo);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (0 < time && notification.userInfo) {
         NSLog(@"消息来了a－－%@",notification.userInfo);
        NSData *JSONData = [notification.userInfo[@"dictionary"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        
        if ([responseJSON[@"action"]isEqualToString:@"NEW_ORDER"] || [responseJSON[@"action"]isEqualToString:@"INVITE_PARTNER"]) {
        
            if ([userDefaults objectForKey:@"autoken"]) {
                if (![[userDefaults objectForKey:@"homeOrder"]isEqualToString:@"YES"]) {
                    UIWindow *window = [UIApplication sharedApplication].delegate.window;
                    
                    CLHomeOrderViewController *homeOrderView = [[CLHomeOrderViewController alloc]init];
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeOrderView];
                    navigation.navigationBarHidden = YES;
                    window.rootViewController = navigation;
                }
#warning --发送通知
                
                [self performSelector:@selector(after:) withObject:responseJSON afterDelay:1.0];
                
            }
        }else if ([responseJSON[@"action"]isEqualToString:@"VERIFICATION_SUCCEED"] || [responseJSON[@"action"]isEqualToString:@"VERIFICATION_FAILED"]){
            NSLog(@"认证消息");
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            GFSignInViewController *signin = [[GFSignInViewController alloc]init];
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:signin];
            navigation.navigationBarHidden = YES;
            window.rootViewController = navigation;
            
            
        }
        
        
        
    }
    
    
}

- (void)after:(NSDictionary *)responseJSON{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NEW_ORDER" object:self userInfo:responseJSON];
}

-(void)btnClick:(UIButton *)button{
    [[button superview] removeFromSuperview];
    NSLog(@"移走view");
}

@end
