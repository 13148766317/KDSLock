//
//  KDSProdutDetailHttp.m
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProdutDetailHttp.h"

#import "KDSProductDetailModel.h"
#import "KDSProductEvaluateModel.h"


@implementation KDSProdutDetailHttp
//商品详情
+(void)productDetailWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:productDetail paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        
        if (code == 1) {
//            switch (detailType) {
//                case KDSProductDetail_Normal:{
                    KDSProductDetailModel * model = [KDSProductDetailModel mj_objectWithKeyValues:json[@"data"]];
                    success(YES,model);
//                }
//                    break;
//                case KDSProductDetail_seckill:{
//
//                }
//                    break;
//                case KDSProductDetail_group:{
//
//                }
//                    break;
//                case KDSProductDetail_crowdfunding:{
//
//                }
//                    break;
//
//                default:
//                    break;
//            }
           
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//商品评论
+(void)productEvaluateDetailWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:productEvalutate paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSProductEvaluateModel * model = [KDSProductEvaluateModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//添加收藏
+(void)addCollectProductWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:addCollectProduct paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
//取消收藏
+(void)cancelCollectProductWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:cancelCollectProdcut paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//添加购物车
+(void)addShopCartProductWithParams:(NSDictionary *)dict productDetailType:(KDSProductDetailType)detailType success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:addShoppingCart paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

// 获取参数根据渠道商品id
+(void)getParameterAppWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getParameterApp paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            NSArray * array = json[@"data"];
            success(YES,array);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
@end
