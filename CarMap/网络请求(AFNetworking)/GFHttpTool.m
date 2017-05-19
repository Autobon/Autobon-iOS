//
//  GFHttpTool.m
//  GFHttpTool(AFNetworking)
//
//  Created by 陈光法 on 15/12/15.
//  Copyright © 2015年 陈光法. All rights reserved.
//*** 网络请求 ****

#import "GFHttpTool.h"
#import "AFNetworking.h"
#import "GFTipView.h"
#import "Reachability.h"
#import "GFAlertView.h"



//NSString *const prefixURL = @"http://121.40.219.58:8000/api/mobile";
//NSString* const HOST = @"http://121.40.219.58:8000/api/mobile";
//NSString* const PUBHOST = @"http://121.40.219.58:8000/api";



//NSString *const prefixURL = @"http://10.0.12.168:12345/api/mobile";
//NSString* const HOST = @"http://10.0.12.168:12345/api/mobile";
//NSString* const PUBHOST = @"http://10.0.12.168:12345/api";

//新的正式服务器
NSString *const prefixURL = @"http://47.93.17.218:12345/api/mobile";
NSString* const HOST = @"http://47.93.17.218:12345/api/mobile";
NSString* const PUBHOST = @"http://47.93.17.218:12345/api";



@implementation GFHttpTool

// 模版
+ (void)getWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
    
        NSString *suffixURL = @"";
        NSString *url = [NSString stringWithFormat:@"%@%@", prefixURL, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}
+ (void)postWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
    
        NSString *suffixURL = @"";
        NSString *url = [NSString stringWithFormat:@"%@%@", prefixURL, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }

}

//------------------------------------------------------------------------------------------
//++++++++++++++++++++++++++++++++++  陈光法网络请求  ++++++++++++++++++++++++++++++++++++++++
//------------------------------------------------------------------------------------------
// 登录
// 二期
+ (void)signInWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"正在登陆..."];
        
        // 拼接地址
        NSString *url = [NSString stringWithFormat:@"%@/technician/v2/login", HOST];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
            
            
            if(success) {
                [aView removeFromSuperview];
                
                success(responseObject);
                
//                NSLog(@"===%@", responseObject);
                
                if([responseObject[@"status"] integerValue] == 1) {
                
                    // 更新个推ID
                    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
                    NSString *token = [userDefaultes objectForKey:@"autoken"];
                    [manager2.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
                    NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/pushId",HOST];
                    NSString *pushId = [userDefaultes objectForKey:@"clientId"];
                    [manager2 POST:URLString parameters:@{@"pushId":pushId} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
//                        NSLog(@"个推ID更新成功－－%@",responseObject);
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                        NSLog(@"---更新失败了－－%@",error);
                    }];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            
            //            NSLog(@"失败了－－%@",error);
            if(failure) {
                
                
                
                failure(error);
            }
        }];
        
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}
// 获取验证码
// 二期
+ (void)codeGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"请求中..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        // 拼接地址
        NSString *url = [NSString stringWithFormat:@"%@/pub/v2/verifySms", PUBHOST];
        
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}
// 注册
// 二期
+ (void)verifyPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    if ([GFHttpTool isConnectionAvailable]) {
        
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        // 拼接地址
        NSString *url = [NSString stringWithFormat:@"%@/technician/v2/register", HOST];
        
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            
            if(success) {
                
                [aView removeFromSuperview];
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            
            
            if(failure) {
                
                [aView removeFromSuperview];
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}
// 忘记秘密
// 二期
+ (void)forgetPwdPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        // 拼接地址
        NSString *url = [NSString stringWithFormat:@"%@/technician/v2/resetPassword?phone=%@&password=%@&verifySms=%@", HOST, parameters[@"phone"], parameters[@"password"], parameters[@"verifySms"]];
        
        [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(success) {
                
                [aView removeFromSuperview];
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            
            if(failure) {
                
                [aView removeFromSuperview];
                failure(error);
            }
        }];
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}
// 更改密码
// 二期
+ (void)changePwdPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        // 拼接地址
        NSString *url = [NSString stringWithFormat:@"%@/technician/v2/changePassword?oldPassword=%@&newPassword=%@", HOST, parameters[@"oldPassword"], parameters[@"newPassword"]];
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
//        NSLog(@"修改密码的请求地址：%@", url);
        [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(success) {
                
                [aView removeFromSuperview];
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                [aView removeFromSuperview];
                
                failure(error);
            }
        }];
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}
// 个人信息
// 二期
+ (void)messageGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        // 拼接地址
        //        NSString *url = [NSString stringWithFormat:@"%@/technician", HOST];
        NSString *url = [NSString stringWithFormat:@"%@/technician/v2/me", HOST];
        
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                
                [aView remove];
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                [aView removeFromSuperview];
                
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}
// 修改银行卡
+ (void)bankCardPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        
        
        //        NSLog(@"\n$$$$$$$$$$$\n\n\n\n  %@  \n\n\n\n$$$$$$$$", parameters);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
//        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        // 拼接地址
        NSString *url = [NSString stringWithFormat:@"%@/technician/v2/changeBankCard?bank=%@&bankAddress=%@&bankCardNo=%@", HOST, parameters[@"bank"], parameters[@"bankAddress"], parameters[@"bankCardNo"]];
//        NSLog(@"====%@", url);
        
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [manager PUT:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(success) {
                
                [aView removeFromSuperview];
                
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                [aView removeFromSuperview];
                
                failure(error);
            }
        }];
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}
// 账单
// 二期
+ (void)billGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        //        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        //        NSLog(@"----token---%@--",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        // 拼接地址
        NSString *url = [NSString stringWithFormat:@"%@/technician/bill", HOST];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
//        NSLog(@"--账单列表字典--%@", parameters);
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                
                //                [aView removeFromSuperview];
                
                success(responseObject);
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                //                [aView removeFromSuperview];
                
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}
// 账单详情
// 二期
+ (void)billDetailsGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        
        //        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
//        NSLog(@"-parameters[@\"billd\"]---%@", parameters[@"billd"]);
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        //        NSLog(@"----token---%@--",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        // 拼接地址
        NSString *url = [NSString stringWithFormat:@"%@/technician/bill/v2/%@/order", HOST, parameters[@"billd"]];
//        NSLog(@"-parameters[@\"billd\"]---%@---%@", parameters[@"billd"], url);
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                //                [aView removeFromSuperview];
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                //                [aView removeFromSuperview];
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}
// 订单列表
+ (void)indentGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        
        //        NSLog(@"token----%@---",token);
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        // 拼接地址
        NSString *url;
        if([parameters[@"curUrlId"] integerValue] == 0) {
            url = [NSString stringWithFormat:@"%@/technician/order/listMain", HOST];
        }else {
            url = [NSString stringWithFormat:@"%@/technician/order/listSecond", HOST];
        }
        
        
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

// 我的订单
// 二期
+ (void)orderGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = parameters[@"url"];
        NSString *url = [NSString stringWithFormat:@"%@%@", prefixURL, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}
// 订单详情
// 二期
+ (void)orderDDGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = @"/technician/v2/order/";
        NSString *url = [NSString stringWithFormat:@"%@%@%@", prefixURL, suffixURL, parameters[@"id"]];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}

//------------------------------------------------------------------------------------------
//++++++++++++++++++++++++++++++++++  李孟龙网络请求  ++++++++++++++++++++++++++++++++++++++++
//------------------------------------------------------------------------------------------
#pragma mark - 上传认证信息
// 二期
+ (void)certifyPostParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"上传中..."];
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //申明请求的数据是json类型
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/certificate",HOST];
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
            if(success) {
                [aView removeFromSuperview];
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
}
// 上传头像
// 二期
+ (void)headImage:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"正在上传..."];
        
        //    NSData *headData = UIImageJPEGRepresentation(image, 0.5);
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        

        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/avatar",HOST];
        
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            
            [formData appendPartWithFileData:image name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                
                [aView removeFromSuperview];
                
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                [aView removeFromSuperview];
                
                failure(error);
            }
        }];
        
#warning -  网络请求超时
        //    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        //    manager.requestSerializer.timeoutInterval = 15.f;
        //    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        
        
        
        //    NSLog(@"－Cookie－%@--",token);
        
        //    NSDictionary *dictionary = @{@"file":image};
        //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //    NSLog(@"--URLString--%@---headData--%@--",URLString,image);
        //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        
        
        //    UIImage *imageName = [UIImage imageNamed:@"icon.png"];
        //    NSData *imageData = UIImageJPEGRepresentation(imageName, 0.3);
        //     NSDictionary *dictionary = @{@"file":imageData};
        //    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        
        //    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon.png"]];
        //    [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
        //        NSLog(@"成功－3333333333－%@",responseObject[@"message"]);
        //        if(success) {
        //            success(responseObject);
        //        }
        //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //        NSLog(@"---4444444444444-%@---",error);
        //        if(failure) {
        //            failure(error);
        //        }
        //    }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
}
#pragma mark - 上传证件照
// 二期
+ (void)idPhotoImage:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"正在上传..."];
        
        
        //    NSData *headData = UIImageJPEGRepresentation(image, 0.5);
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/idPhoto",HOST];
        
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:image name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                
                [aView removeFromSuperview];
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [aView removeFromSuperview];
            if(failure) {
                
                
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}
#pragma mark - 获取认证信息
// 二期
+ (void)getCertificateSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        //        NSLog(@"token--%@--",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
        
//        NSString *URLString = [NSString stringWithFormat:@"%@/technician",HOST];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/me", HOST];
        
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                
                [aView remove];
                
                
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"-----失败原因－－－%@-",error);
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                
                
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
}


// 获取主页未完成订单列表
// 二期
+ (void)getOrderListDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/order",HOST];

        [manager GET:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"请求成功了－11－－");
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"请求失败了－－－");
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if (failure) {
                failure(error);
            }
        }];
        
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
}


#pragma mark - 抢单
// 二期
+ (void)postOrderId:(NSInteger )orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
//                NSLog(@"token--%@--",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/order/take",HOST];
        
        
        [manager POST:URLString parameters:@{@"orderId":@(orderId)} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            [aView removeFromSuperview];
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}
//#pragma mark - 开始工作＊＊＊
// 二期
+ (void)workstartPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = @"/api/mobile/technician/construct/v2/start";
        NSString *url = [NSString stringWithFormat:@"%@%@", HOST, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
    
}
#pragma mark - 订单的详情
// 二期
+ (void)oederDDGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSString *suffixURL = @"/technician/v2/order/";
        NSString *url = [NSString stringWithFormat:@"%@%@%@", prefixURL, suffixURL,parameters[@"orderId"]];
//        NSLog(@"--请求的地址---%@", url);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
//        NSLog(@"---%@", url);
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [aView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                failure(error);
            }
        }];
        
    }else {
//        [aView removeFromSuperview];
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}
#pragma mark - 工作开始
// 二期
+ (void)postOrderStart:(NSDictionary *)orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        //        NSLog(@"token--%@--",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
//        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/start",HOST];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/v2/start",HOST];
        
        
        [manager POST:URLString parameters:orderId progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
}
#pragma mark - 签到接口
// 二期
+ (void)signinParameters:(NSDictionary *)parameters Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/v2/signIn",HOST];
        
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
            [aView removeFromSuperview];
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if (failure) {
                failure(error);
            }
        }];
        
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}
#pragma mark - 提交工作前照片
// 二期
+ (void)PostPhotoForBeforeOrderId:(NSInteger )orderId URLs:(NSString *)URLs success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"上传中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
//        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/beforePhoto",HOST];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/v2/beforePhoto",HOST];
        [manager POST:URLString parameters:@{@"orderId":@(orderId),@"urls":URLs} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"-----%@－－－－",responseObject[@"message"]);
            if(success) {
                
                [aView removeFromSuperview];
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"－－－－%@----",error);
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                [aView removeFromSuperview];
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
}
#pragma mark - 上传所有施工照片
// 二期
+ (void)PostImageForWork:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"上传中..."];
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
//        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/uploadPhoto",HOST];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/v2/uploadPhoto",HOST];

        
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:image name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                
                [aView removeFromSuperview];
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [aView removeFromSuperview];
            if(failure) {
                
                
                failure(error);
            }
        }];
        
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
    
}
#pragma mark - 施工完成的请求接口
// 二期
+ (void)PostOverDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        // 请求
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
//        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/finish",HOST];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/order/finish",HOST];
        
//        NSString *URLString = [NSString stringWithFormat:@"http://10.0.12.225/technician/v2/order/finish"];
        
        // 返回
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager PUT:URLString parameters:dictionary success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage]; // 获得响应头
//            NSLog(@"####################################\n---%@--",[cookieJar cookies]); // 获取响应头的数组
            
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage]; // 获得响应头
//            NSLog(@"####################################\n---%@--",[cookieJar cookies]); // 获取响应头的数组
            
//            NSLog(@"^^^^^++++^^^^^%@", task);
            
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            [aView removeFromSuperview];
            if(failure) {
                failure(error);
            }
        }];
        
        /*
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            [aView removeFromSuperview];
            if(failure) {
                failure(error);
            }
        }];
    */
    
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    

    

    
    
    
}



#pragma mark - 查找合伙人
+ (void)getSearch:(NSString *)string Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"查找中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        //        NSLog(@"token--%@--",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/search",HOST];
        
        
        [manager GET:URLString parameters:@{@"query":string} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"----responseObject--%@--",responseObject);
            if(success) {
                
                [aView removeFromSuperview];
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                [aView removeFromSuperview];
                
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
}
#pragma mark - 添加小伙伴
+ (void)postAddPerson:(NSDictionary *)orderDic Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"添加中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        //        NSLog(@"token--%@--",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/%@/invite/%@",HOST,orderDic[@"orderId"],orderDic[@"partnerId"]];
        
//        NSLog(@"URLString-----%@--",URLString);
        [manager POST:URLString parameters:orderDic progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                
                [aView removeFromSuperview];
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                
                [aView removeFromSuperview];
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
}



#pragma mark - 获取订单的工作项目
// 二期
+ (void)GetWorkItemsOrderTypeId:(NSInteger)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        //    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        //    NSString *token = [userDefaultes objectForKey:@"autoken"];
        //    NSLog(@"token--%@--",token);
        //    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
//        NSString *URLString = [NSString stringWithFormat:@"%@/pub/technician/workItems",PUBHOST];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/order/project/position/%ld",HOST, orderId];
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
}



// 获取订单详情
+ (void)getOrderDetailOrderId:(NSInteger )orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/%ld",HOST,orderId];
        
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
    
}


// 合伙人列表
// 二期
+ (void)addPeoListGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = @"/technician/v2";
        NSString *url = [NSString stringWithFormat:@"%@%@", prefixURL, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        
        
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}
// 搜索合伙人
// 二期
+ (void)searPeoGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = @"/technician/v2";
        NSString *url = [NSString stringWithFormat:@"%@%@", prefixURL, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        
        
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}

#pragma mark - 报告实时位置的方法
+ (void)PostReportLocation:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/reportLocation",HOST];
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
}



#pragma mark - 获取可接订单列表
// 二期
+ (void)getOrderListNewDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/v2/order/listNew",HOST];
        //        NSLog(@"-请求没有成功程序挂掉啦--token---%@---%@---%@-",manager,URLString,dictionary);
        //        [manager GET:URLString parameters:dictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //            NSLog(@"请求成功了－22－－");
        //            if (success) {
        //                success(responseObject);
        //            }
        //        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            NSLog(@"请求失败了－－－");
        //            if (failure) {
        //                failure(error);
        //            }
        //        }];
        
        [manager GET:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"请求成功了－11－－");
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"请求失败了－－－");
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if (failure) {
                failure(error);
            }
        }];
        
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
}



#pragma mark - 调用百度接口转换经纬度
+ (void)getCoordsURLString:(NSString *)URLString success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}


#pragma mark - 获取通知消息
+ (void)getMessageDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        //        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"获取中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/message",HOST];
        
        //        NSLog(@"dictionary----%@---",dictionary);
        [manager GET:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            [aView remove];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            [aView remove];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
}


#pragma mark - 放弃订单
// 二期
+ (void)postCancelOrder:(NSString *)orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        NSArray *arr = [orderId componentsSeparatedByString:@","];
        
        NSString *URLStrings = [NSString stringWithFormat:@"%@/technician/v2/order/%@/cancel%@",HOST,arr[0], arr[1]];
        
//        NSLog(@"URLString-----%@--",URLStrings);
        NSString *str = [URLStrings stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [manager PUT:str parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        /*
        [manager POST:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        */
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
}


//#pragma mark - 接受或者拒绝接受邀请的方法，，，没用了
+ (void)PostAcceptOrderId:(NSInteger )orderId accept:(NSString *)accept success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/%ld/invitation",HOST,(long)orderId];
        //        NSLog(@"token-可能是这里错了-%@-－－URLString--%@-",token,URLString);
        [manager POST:URLString parameters:@{@"accepted":accept} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"走出来了");
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"没有走出来－－－%@--",error);
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}

//#pragma mark - 上传工作前照片，，，没用
+ (void)PostImageWorkBefore:(NSData *)image orderId:(NSInteger )orderId imageNumber:(NSInteger)imageNumber success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"正在上传..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/uploadPhoto",HOST];
        
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager POST:URLString parameters:@{@"no":@(imageNumber),@"orderId":@(orderId),@"isBefore":@"true"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:image name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                
                [aView removeFromSuperview];
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                [aView removeFromSuperview];
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}



#pragma mark - 技师收藏商户
+ (void)favoriteCooperatorPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/favorite/cooperator/%@",HOST,parameters[@"cooperatorId"]];
        //        NSLog(@"token-可能是这里错了-%@-－－URLString--%@-",token,URLString);
        [manager POST:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"走出来了");
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"没有走出来－－－%@--",error);
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}


#pragma mark - 技师移除收藏商户
+ (void)favoriteCooperatorDeleteWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/favorite/cooperator/%@",HOST,parameters[@"cooperatorId"]];
        //        NSLog(@"token-可能是这里错了-%@-－－URLString--%@-",token,URLString);
        [manager DELETE:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"走出来了");
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"没有走出来－－－%@--",error);
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}


#pragma mark - 技师查询收藏商户列表
+ (void)favoriteCooperatorGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/favorite/cooperator",HOST];
        //        NSLog(@"token-可能是这里错了-%@-－－URLString--%@-",token,URLString);
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"走出来了");
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
            }else {
                [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}














#pragma mark - 判断网络连接情况
// 加号方法里只能够调用加号方法
+(BOOL)isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    
    return isExistenceNetwork;
}
#pragma mark - AlertView
+ (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withShowTimw:1.0];
    [tipView tipViewShow];
}

@end
