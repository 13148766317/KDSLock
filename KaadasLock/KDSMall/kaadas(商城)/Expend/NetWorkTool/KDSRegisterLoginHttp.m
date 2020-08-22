//
//  KDSRegisterLoginHttp.m
//  kaadas
//
//  Created by 中软云 on 2019/6/1.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSRegisterLoginHttp.h"
#import "KDSMineHttp.h"

@implementation KDSRegisterLoginHttp
//登陆
+(void)loginWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:passwordLogin paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            NSString *atoken = json[@"data"][@"token"];
            [userDefaults setObject:atoken forKey:USER_TOKEN];
            [userDefaults synchronize];
            
            success(YES,json);

            if (atoken) {
                //获取用户信息
                NSDictionary * dictionary = @{@"params":@{},
                                              @"token":atoken};
                [KDSMineHttp mineInfoWithParams:dictionary success:^(BOOL isSuccess, id  _Nonnull obj) {
                    
                } failure:^(NSError * _Nonnull error) {
                    
                }];
            }
        }else{
            success(NO,json[@"msg"]);
            
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//退出登录
+(void)loginOutWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:userLogout paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
@end
