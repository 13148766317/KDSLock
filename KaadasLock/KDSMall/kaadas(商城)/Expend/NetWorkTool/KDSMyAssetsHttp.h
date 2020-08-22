//
//  KDSMyAssetsHttp.h
//  kaadas
//
//  Created by 中软云 on 2019/7/23.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyAssetsHttp : NSObject
//app提现
+(void)withdrawalMoneyrWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//商户提现说明
+(void)withdrawRemarkWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
