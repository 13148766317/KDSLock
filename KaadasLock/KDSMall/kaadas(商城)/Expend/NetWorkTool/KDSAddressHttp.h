//
//  KDSAddressHttp.h
//  kaadas
//
//  Created by 中软云 on 2019/5/30.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSAddressHttp : NSObject
//获取收货地址信息分页列表
+(void)userAddressListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
