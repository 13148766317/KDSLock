//
//  KDSProdutDetailHttp.h
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,KDSProductDetailType){
    KDSProductDetailNormal,    //普通
    KDSProductDetailSeckill,   //秒杀
    KDSProductDetailGroup,     //团购
    KDSProductDetailCrowdfunding//众筹
};

@interface KDSProdutDetailHttp : NSObject

//商品详情
+(void)productDetailWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//商品评论
+(void)productEvaluateDetailWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//添加收藏
+(void)addCollectProductWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//取消收藏
+(void)cancelCollectProductWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//添加购物车
+(void)addShopCartProductWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
// 获取参数根据渠道商品id
+(void)getParameterAppWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
