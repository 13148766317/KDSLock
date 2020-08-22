//
//  KDSHomePageHttp.h
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSHomePageHttp : NSObject
#pragma mark - 首页购物车、系统数据
+(void)getShopCartAndSysNumberWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark -  1.获取轮播图，视频，分类 
+(void)getFirstPartParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 2.获取灵动系列，推拉系列，活动
+(void)getSecondPartWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 3.搜索
+(void)getFirstSearchWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 获取所有标签
+(void)getAllAllKeyValueWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 获取商品列表
+(void)getProductListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 查询个活动列表 (秒杀 团购 众筹 灵动)
+(void)getFirstAllWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 查询个活动列表 (秒杀 团购 众筹 灵动)
+(void)getChildListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

#pragma mark - 新人券 未登录
+(void)getNotokenCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 新人券 已登录
+(void)getCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

#pragma mark - 砍价详情
+(void)bargainWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 砍价流水 列表
+(void)getBargainRecordWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
#pragma mark - 发起砍价
+(void)startBargainRecordWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

#pragma mark -  前端获取系统升级
+(void)systemUpgradeAppsuccess:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
