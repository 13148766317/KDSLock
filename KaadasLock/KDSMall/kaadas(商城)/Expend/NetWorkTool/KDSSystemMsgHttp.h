//
//  KDSSystemMsgHttp.h
//  kaadas
//
//  Created by 中软云 on 2019/6/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSSystemMsgHttp : NSObject
// 消息数量
+(void)getSysMessageNumberWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
// 根据类型获取该类型下的消息列表
+(void)getSysMessageListByTypeWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
//
+(void)getSysMessageListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
