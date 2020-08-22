//
//  KDSMyAssetsHttp.m
//  kaadas
//
//  Created by 中软云 on 2019/7/23.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyAssetsHttp.h"
#import "KDSWithdrawalDesModel.h"

@implementation KDSMyAssetsHttp
//app提现
+(void)withdrawalMoneyrWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:withdrawalMoney paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
//商户提现说明
+(void)withdrawRemarkWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:withdrawRemark paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSWithdrawalDesModel * model = [KDSWithdrawalDesModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
@end
