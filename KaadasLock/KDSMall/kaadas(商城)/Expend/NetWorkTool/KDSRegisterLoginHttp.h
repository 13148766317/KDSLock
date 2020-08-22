//
//  KDSRegisterLoginHttp.h
//  kaadas
//
//  Created by 中软云 on 2019/6/1.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSRegisterLoginHttp : NSObject
//登陆
+(void)loginWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;

//退出登录
+(void)loginOutWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
