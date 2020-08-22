//
//  KDSCheckUploadHttp.m
//  kaadas
//
//  Created by 中软云 on 2019/7/15.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSCheckUploadHttp.h"

@implementation KDSCheckUploadHttp

//根据数字分类编码找到所有的key-value
+(void)getListValueWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getListValue paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json[@"data"]);
        }else{
            success(NO,json[@"msg"]);
        }
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
    
    
}
@end
