//
//  KDSMineHttp.h
//  kaadas
//
//  Created by 中软云 on 2019/5/29.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSMineHttp : NSObject
//获取用户个人信息接口
+(void)mineInfoWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//获取验证码
+(void)getCodeWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//修改用户信息
+(void)updateUserInfoWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure getInfo:(void (^)(BOOL isSuccess))getInfo;
//设置密码
+(void)setPassWordWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//绑定微信
+(void)bingWechatWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//绑定手机号
+(void)bingPhoneNumberWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//绑定邀请码
+(void)binginviteCodeWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//获取我的帖子分页列表
+(void)myInvitationPageWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//获取我的帖子的回复分页列表
+(void)invitationReplyPageWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//门店获取分页列表
+(void)shopAppListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//我的收藏 列表
+(void)myCollectionListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//批量取消收藏
+(void)cancelCollectByIdsWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//我的足迹 列表
+(void)myFootPrintListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//删除足迹
+(void)deleteFootPrintWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//门店详情
+(void)shopAppDetailWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//提交反馈
+(void)feedbackSaveWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//我的资产
+(void)myAssetsWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//我的资产详情
+(void)myAssetsDetailWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//我的团队
+(void)myTeamWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//收益明细
+(void)earnDetailsWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//我的团队人数
+(void)myTeamCountWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//我的任务（进行时）
+(void)myTaskongoingWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//我的任务（完成时）
+(void)myTaskCompleteWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//激活优惠券
+(void)activationCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//获取我的优惠券
+(void)getMyCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//获取过期的优惠券
+(void)getMyPastDueCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//在线客服服务
+(void)onlineServiceWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//积分明细
+(void)interfralDetailWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

+(void)myBargainListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
