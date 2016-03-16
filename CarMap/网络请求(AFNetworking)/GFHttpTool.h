//
//  GFHttpTool.h
//  GFHttpTool(AFNetworking)
//
//  Created by 陈光法 on 15/12/15.
//  Copyright © 2015年 陈光法. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFHttpTool : NSObject

+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 登录
+ (void)signInPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 获取验证码
+ (void)codeGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 注册
+ (void)verifyPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 忘记秘密
+ (void)forgetPwdPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 更改密码
+ (void)changePwdPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 个人信息
+ (void)messageGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 修改银行卡
+ (void)bankCardPost:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 账单
+ (void)billGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 订单列表
+ (void)indentGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;











// 我要认证
+ (void)certifyPostParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 上传头像
+ (void)headImage:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 获取订单列表
+ (void)getOrderListDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 获取订单列表
+ (void)signinParameters:(NSDictionary *)parameters Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 上传证件照
+ (void)idPhotoImage:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 获取认证信息
+ (void)getCertificateSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 查找合伙人
+ (void)getSearch:(NSString *)string Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 添加小伙伴
+ (void)postAddPerson:(NSDictionary *)orderDic Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 抢单
+ (void)postOrderId:(NSInteger )orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 抢单
+ (void)postOrderStart:(NSDictionary *)orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



// 上传工作前照片
+ (void)PostImageWorkBefore:(NSData *)image orderId:(NSInteger )orderId imageNumber:(NSInteger)imageNumber success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)PostImageForWork:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 接受或拒绝订单邀请
+ (void)PostAcceptOrderId:(NSInteger )orderId accept:(NSString *)accept success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 获取订单工作项
+ (void)GetWorkItemsOrderTypeId:(NSInteger )TypeId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 提交工作前照片
+ (void)PostPhotoForBeforeOrderId:(NSInteger )orderId URLs:(NSString *)URLs success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 获取订单详情
+ (void)getOrderDetailOrderId:(NSInteger )orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 施工完成
+ (void)PostOverDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;




@end
