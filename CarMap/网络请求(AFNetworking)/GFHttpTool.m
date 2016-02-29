//
//  GFHttpTool.m
//  GFHttpTool(AFNetworking)
//
//  Created by 陈光法 on 15/12/15.
//  Copyright © 2015年 陈光法. All rights reserved.
//*** 网络请求 ****

#import "GFHttpTool.h"
#import "AFNetworking.h"

NSString* const HOST = @"http://121.40.157.200:51234/api/mobile";


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
        [manager2 POST:URLString parameters:@{@"pushId":pushId} success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
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

// 认证
+ (void)certifyPostParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
   [manager.requestSerializer setValue:@"autoken=\"technician:RhuKuh6uB7TCm6HWSi/D2A==\"" forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/commitCertificate",HOST];
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
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if(success) {
            success(dictionary);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
    
   
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



// 上传证件照
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
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
        
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




+ (void)getOrderListSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/order/orderList",HOST];
    
    [manager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
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
    NSString *URLString = [NSString stringWithFormat:@"%@/construction/signIn",HOST];
    
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
    [manager.requestSerializer setValue:@"autoken=\"technician:RhuKuh6uB7TCm6HWSi/D2A==\"" forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/technician/getCertificate",HOST];
    
    
    [manager POST:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
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
    NSString *URLString = [NSString stringWithFormat:@"%@/order/addSecondTechId",HOST];
    
    
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


@end
