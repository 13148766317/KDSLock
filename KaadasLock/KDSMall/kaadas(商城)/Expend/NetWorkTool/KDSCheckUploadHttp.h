//
//  KDSCheckUploadHttp.h
//  kaadas
//
//  Created by 中软云 on 2019/7/15.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSCheckUploadHttp : NSObject
//根据数字分类编码找到所有的key-value
+(void)getListValueWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
