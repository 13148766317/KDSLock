//
//  KDSNetworkManager.h
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>


//请求方法枚举
typedef NS_ENUM(NSInteger,HttpMethod){
    POST = 0,
    GET
};

//请求成功block回调
typedef void(^SuccessBlock)(NSInteger code,id _Nullable json);
//请求失败block回调
typedef void(^FailBlock)(NSError * _Nullable error);

typedef void (^UploadProgress)(NSProgress * _Nullable uploadProgress);

NS_ASSUME_NONNULL_BEGIN

@interface KDSNetworkManager : NSObject

//单利
+(instancetype)sharedInstance;

/**  上传图片
 POST请求
 @param image 上传的UIImage
 */
+(void)POSTUploadDatawithPics:(UIImage *)image
                     progress:(UploadProgress)progress
                      success:(SuccessBlock)success
                      failure:(FailBlock)failure;
/**  上传图片 多张
 POST请求
 @param imageArray 上传的UIImage数组
 */
+(void)POSTUploadMoreDatawithPics:(NSArray <UIImage *> *)imageArray
                         progress:(UploadProgress)progress
                          success:(SuccessBlock)success
                          failure:(FailBlock)failure;
/** 数据的任务
 POST请求
 @param serverUrlString  请求URL字符串
 @param paramsDict       请求参数
 @param success          成功block
 @param failure          失败block
 */
+(void)POSTRequestBodyWithServerUrlString:(NSString *)serverUrlString
                               paramsDict:(id)paramsDict
                                  success:(SuccessBlock)success
                                  failure:(FailBlock)failure;

@end

NS_ASSUME_NONNULL_END
