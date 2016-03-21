//
//  GFHttpTool.m
//  GFHttpTool(AFNetworking)
//
//  Created by 陈光法 on 15/12/15.
//  Copyright © 2015年 陈光法. All rights reserved.
//*** 网络请求 ****

#import "GFHttpTool.h"
#import "AFNetworking.h"
#import "Reachability.h"




NSString* const HOST = @"http://121.40.157.200:12345/api/mobile";
NSString* const PUBHOST = @"http://121.40.157.200:12345/api";

@implementation GFHttpTool


// 登录
+ (void)signInPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
        
        if(success) {
            success(responseObject);
        }
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager2.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/pushId",HOST];
        NSString *pushId = [userDefaultes objectForKey:@"clientId"];
        [manager2 POST:URLString parameters:@{@"pushId":pushId} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            NSLog(@"个推ID更新成功－－%@",responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"---更新失败了－－%@",error);
        }];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败了－－%@",error);
        if(failure) {
            failure(error);
        }
    }];
}

// 获取验证码
+ (void)codeGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
}

// 注册
+ (void)verifyPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
}

// 忘记密码
+ (void)forgetPwdPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

// 更改密码
+ (void)changePwdPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
}

// 个人信息
+ (void)messageGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];

}

// 修改银行卡
+ (void)bankCardPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    NSLog(@"\n$$$$$$$$$$$\n\n\n\n  %@  \n\n\n\n$$$$$$$$", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
}

// 账单
+ (void)billGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
}

// 账单详情
+ (void)billDetailsGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
}

// 订单列表
+ (void)indentGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];

}




//NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//NSString *token = [userDefaultes objectForKey:@"autoken"];
//NSLog(@"token--%@--",token);
//[manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];









+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
}



+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];

}

#pragma mark - 上传认证信息
+ (void)certifyPostParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
   [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/certificate",HOST];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        } 
    }];
    
    
}


// 上传头像
+ (void)headImage:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
//    NSData *headData = UIImageJPEGRepresentation(image, 0.5);

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    
    
    
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/avatar",HOST];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        [formData appendPartWithFileData:image name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if(success) {
            success(dictionary);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
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
    
}



#pragma mark - 上传证件照
+ (void)idPhotoImage:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    //    NSData *headData = UIImageJPEGRepresentation(image, 0.5);
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/idPhoto",HOST];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:image name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if(success) {
            success(dictionary);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
    
   
    
}




+ (void)getOrderListDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    NSLog(@"---token---%@---",token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/listUnfinished",HOST];
    
    [manager GET:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)signinParameters:(NSDictionary *)parameters Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/signIn",HOST];
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 获取认证信息
+ (void)getCertificateSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    NSLog(@"token--%@--",token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician",HOST];
    
    
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-----失败原因－－－%@-",error);
        if(failure) {
            failure(error);
        }
    }];
    
    
    

}




#pragma mark - 查找合伙人
+ (void)getSearch:(NSString *)string Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    NSLog(@"token--%@--",token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/search",HOST];
    
    
    [manager GET:URLString parameters:@{@"query":string} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSLog(@"----responseObject--%@--",responseObject);
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

#pragma mark - 添加小伙伴
+ (void)postAddPerson:(NSDictionary *)orderDic Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    NSLog(@"token--%@--",token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/%@/invite/%@",HOST,orderDic[@"orderId"],orderDic[@"partnerId"]];
    
    
    [manager POST:URLString parameters:orderDic progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

#pragma mark - 抢单
+ (void)postOrderId:(NSInteger )orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    NSLog(@"token--%@--",token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/takeup",HOST];
    
    
    [manager POST:URLString parameters:@{@"orderId":@(orderId)} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

#pragma mark - 工作开始
+ (void)postOrderStart:(NSDictionary *)orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    NSLog(@"token--%@--",token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/start",HOST];
    
    
    [manager POST:URLString parameters:orderId progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
}


#pragma mark - 上传工作前照片
+ (void)PostImageWorkBefore:(NSData *)image orderId:(NSInteger )orderId imageNumber:(NSInteger)imageNumber success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
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
            success(dictionary);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

+ (void)PostImageForWork:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/uploadPhoto",HOST];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:image name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if(success) {
            success(dictionary);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

#pragma mark - 接受或者拒绝接受邀请的方法
+ (void)PostAcceptOrderId:(NSInteger )orderId accept:(NSString *)accept success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    NSLog(@"token--%@--",token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/%d/invitation",HOST,orderId];
    [manager POST:URLString parameters:@{@"accepted":accept} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
    
}


#pragma mark - 获取订单的工作项目
+ (void)GetWorkItemsOrderTypeId:(NSInteger )TypeId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSString *token = [userDefaultes objectForKey:@"autoken"];
//    NSLog(@"token--%@--",token);
//    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/pub/technician/workItems",PUBHOST];
    [manager GET:URLString parameters:@{@"orderType":@(TypeId)} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
}

#pragma mark - 提交工作前照片
+ (void)PostPhotoForBeforeOrderId:(NSInteger )orderId URLs:(NSString *)URLs success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/beforePhoto",HOST];
    [manager POST:URLString parameters:@{@"orderId":@(orderId),@"urls":URLs} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSLog(@"-----%@－－－－",responseObject[@"message"]);
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"－－－－%@----",error);
        if(failure) {
            failure(error);
        }
    }];
}


+ (void)getOrderDetailOrderId:(NSInteger )orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
 
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/%d",HOST,orderId];
    
    
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
}


#pragma mark - 施工完成的请求接口
+ (void)PostOverDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/construct/finish",HOST];
    [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSLog(@"-----%@－－－－",responseObject[@"message"]);
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"－－－－%@----",error);
        if(failure) {
            failure(error);
        }
    }];
    
    
}


#pragma mark - 报告实时位置的方法
+ (void)PostReportLocation:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/reportLocation",HOST];
//    NSLog(@"-----dicrionary---%@--",dictionary);
    [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
//        NSLog(@"-----%@－－－－",responseObject[@"message"]);
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"－－－－%@----",error);
        if(failure) {
            failure(error);
        }
    }];
    
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



@end
