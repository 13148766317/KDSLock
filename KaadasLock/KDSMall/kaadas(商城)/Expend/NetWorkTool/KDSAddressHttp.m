//
//  KDSAddressHttp.m
//  kaadas
//
//  Created by 中软云 on 2019/5/30.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSAddressHttp.h"
#import "KDSAddressListModel.h"


@implementation KDSAddressHttp
//获取收货地址信息分页列表
+(void)userAddressListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:addresslist paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        
        if (code == 1) {
            KDSAddressListModel * model = [KDSAddressListModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
    
}
@end
