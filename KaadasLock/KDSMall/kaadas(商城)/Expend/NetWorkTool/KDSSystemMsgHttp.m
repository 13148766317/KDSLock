//
//  KDSSystemMsgHttp.m
//  kaadas
//
//  Created by 中软云 on 2019/6/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSystemMsgHttp.h"
#import "KDSSytemMsgNumModel.h"
#import "KDSMessageModel.h"

@implementation KDSSystemMsgHttp

// 消息数量
+(void)getSysMessageNumberWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:systemMessageNumber paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            NSArray * array = [KDSSytemMsgNumModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            
            success(YES,array);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}


// 根据类型获取该类型下的消息列表
+(void)getSysMessageListByTypeWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:systemMessageListByType paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSMessageModel * model = [KDSMessageModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
// 
+(void)getSysMessageListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getSysMessageList paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSMessageModel * model = [KDSMessageModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}



@end
