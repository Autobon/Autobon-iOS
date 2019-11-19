//
//  GFHttpTool.h
//  GFHttpTool(AFNetworking)
//
//  Created by 陈光法 on 15/12/15.
//  Copyright © 2015年 陈光法. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFHttpTool : NSObject
+ (void)getWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
+ (void)postWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//------------------------------------------------------------------------------------------
//++++++++++++++++++++++++++++++++++  陈光法网络请求  ++++++++++++++++++++++++++++++++++++++++
//------------------------------------------------------------------------------------------
// 登录
+ (void)signInWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 获取验证码
+ (void)codeGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 注册
+ (void)verifyPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 忘记秘密
+ (void)forgetPwdPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 更改密码
+ (void)changePwdPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 个人信息
+ (void)messageGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 修改银行卡
+ (void)bankCardPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 账单
+ (void)billGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 账单详情
+ (void)billDetailsGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 订单列表
+ (void)indentGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 我的订单
// 二期
+ (void)orderGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 订单详情
// 二期
+ (void)orderDDGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;







//------------------------------------------------------------------------------------------
//++++++++++++++++++++++++++++++++++  陈光法网络请求  ++++++++++++++++++++++++++++++++++++++++
//------------------------------------------------------------------------------------------
// 我要认证
+ (void)certifyPostParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 上传头像
+ (void)headImage:(NSData *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 获取主页未完成订单列表
+ (void)getOrderListDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 签到
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
//上传工作照
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
// 报告实时位置
+ (void)PostReportLocation:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 调用百度接口转换经纬度
+ (void)getCoordsURLString:(NSString *)URLString success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 获取通知消息
+ (void)getMessageDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 获取可接订单列表
+ (void)getOrderListNewDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 放弃订单
+ (void)postCancelOrder:(NSString *)orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 订单详情（二期）
+ (void)oederDDGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 合伙人列表
// 二期
+ (void)addPeoListGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
// 搜索合伙人
// 二期
+ (void)searPeoGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



#pragma mark - 技师收藏商户
+ (void)favoriteCooperatorPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


#pragma mark - 技师移除收藏商户
+ (void)favoriteCooperatorDeleteWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


#pragma mark - 技师查询收藏商户列表
+ (void)favoriteCooperatorGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


#pragma mark - 技师新增提现申请
+ (void)cashApplyPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


#pragma mark - 获取学习园地文件列表
+ (void)adminStudyListGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



// 添加订单备注
+ (void)postOrderRemarkWithDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 查询团队列表
+ (void)getTechnicianTeamWithDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 查询团队成员
+ (void)getTechnicianTeamPeopleWithDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 查询团队详情
+ (void)getTechnicianTeamDetailWithDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 查询团队技师订单列表
+ (void)getTechnicianTeamPeopleOrderWithDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 获取订单可用报价产品
+ (void)getProductOfferWithOrderId:(NSString *)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 施工完成的请求接口
// 三期
+ (void)PostOverProductDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;




@end
