//
//  KDSNetworkManager.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSNetworkManager.h"
#import "KDSLoginViewController.h"

@interface KDSNetworkManager ()
@property (nonatomic,strong)AFHTTPSessionManager  *  httpSessionManger;
@end

static KDSNetworkManager * netWorkManager = nil;

@implementation KDSNetworkManager
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkManager = [[KDSNetworkManager alloc]init];
    });
    return netWorkManager;
}


/**  上传图片 一张
 POST请求
 @param image 上传的UIImage
 */
+(void)POSTUploadDatawithPics:(UIImage *)image
                     progress:(UploadProgress)progress
                      success:(SuccessBlock)success
                      failure:(FailBlock)failure{
    
    [[KDSNetworkManager sharedInstance] uploadDataWithImage:@[image] progress:progress success:success failure:failure];
}

/**  上传图片 多张
 POST请求
 @param imageArray 上传的UIImage数组
 */
+(void)POSTUploadMoreDatawithPics:(NSArray <UIImage *> *)imageArray
                     progress:(UploadProgress)progress
                      success:(SuccessBlock)success
                      failure:(FailBlock)failure{
    [[KDSNetworkManager sharedInstance] uploadDataWithImage:imageArray progress:progress success:success failure:failure];
}

- (void)uploadDataWithImage:(NSArray <UIImage *> *)imageArray
                   progress:(UploadProgress)progress
                    success:(SuccessBlock)success
                    failure:(FailBlock)failure{
    
    //判断是否有网络
    if (![[KDSNetworkMonitor sharedInstance] isNetworkReachable])  {
        NSError * urlError = [NSError errorWithDomain:@"网络连接不可用" code:NetWorkService_NoNetWork userInfo:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(urlError);
            }
        });
        return;
    }
    
    NSString * upurl =  [NSString stringWithFormat:@"%@commonApp/imgUpload",baseuUrl];
    NSLog(@"upurl:%@",upurl);
    [self.httpSessionManger POST:upurl parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imageArray.count; i++) {
            UIImage * image = (UIImage *)imageArray[i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png", str,i];
            
            NSData * data = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSInteger  codeNum = [responseObject[@"code"] integerValue];
            success(codeNum,responseObject);
            NSLog(@"上传图片：%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

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
                                  failure:(FailBlock)failure{
    [[KDSNetworkManager sharedInstance] requestBodyWithMethod:POST serverUrlString:serverUrlString paramsDict:paramsDict success:success failure:failure];
}

/** 数据的任务
 POST请求
 @param httpMethod       请求方法
 @param serverUrlString  请求URL字符串
 @param paramsDict       请求参数
 @param success          成功block
 @param failure          失败block
 */
-(void)requestBodyWithMethod:(HttpMethod)httpMethod
             serverUrlString:(NSString *)serverUrlString
                  paramsDict:(id)paramsDict
                     success:(SuccessBlock)success
                     failure:(FailBlock)failure{
    
    //先判断是否有网络
    if (![[KDSNetworkMonitor sharedInstance] isNetworkReachable])  {
        NSError * urlError = [NSError errorWithDomain:@"网络连接不可用" code:NetWorkService_NoNetWork userInfo:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(urlError);
            }
        });
        return;
    }
    //请求URL
    NSString * allUrlString = [NSString stringWithFormat:@"%@%@",baseuUrl,serverUrlString];
//    allUrlString = [allUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    NSLog(@"请求地址:%@\n请求参数:%@",allUrlString,paramsDict);
    
    NSMutableDictionary * newParamDict = [NSMutableDictionary dictionary];
    [newParamDict setValue:@"ios" forKey:@"device"];
    [newParamDict addEntriesFromDictionary:paramsDict];
     NSLog(@"请求地址:%@\n请求参数:%@",allUrlString,newParamDict);
    //    //把token添加到请求头里
    //    [self setHeaderWith];
    switch (httpMethod) {
        case POST:{
            
            NSURL * url = [NSURL URLWithString:allUrlString];
            NSMutableURLRequest  * request = [NSMutableURLRequest requestWithURL:url];
            NSData *postData = [NSJSONSerialization dataWithJSONObject:newParamDict options:0 error:nil];
            // 设置body
            [request setHTTPBody:postData];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            [[self.httpSessionManger dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                
            } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                if (error == nil) {
                    NSLog(@"请求成功url:%@\n:\n%@",url,responseObject);
                    NSInteger  codeNum = [responseObject[@"code"] integerValue];
                    success(codeNum,responseObject);
                    if (codeNum == 21 ) {//|| codeNum == 112
                        if ([HelperTool shareInstance].isUnToken) {
                            return;
                        }
                        //清空用户信息和token
                        [QZUserArchiveTool clearUserModel];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                        [[NSUserDefaults standardUserDefaults] synchronize];

                        [HelperTool shareInstance].isUnToken = YES; 
                        KDSTabBarController * tableBarVC = [HelperTool shareInstance].tableBarVC;
//                        WxLoginController * loginVC = [[WxLoginController alloc]init];
                        KDSLoginViewController * loginVC = [[KDSLoginViewController alloc]init];
                        KDSMallNC * nav = [[KDSMallNC alloc]initWithRootViewController:loginVC];
                        [tableBarVC presentViewController:nav animated:YES completion:^{}];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [HelperTool shareInstance].isUnToken = NO;
                        });
                    }
                }else{
                    NSLog(@"请求失败\n%@",error);
                    if (failure) {
                        NSError * serverError = [NSError errorWithDomain:@"服务器异常" code:NetWorkService_serviceError userInfo:nil];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failure(serverError);
                        });
                    }
                }
            }] resume];
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 懒加载
-(AFHTTPSessionManager *)httpSessionManger{
    if (_httpSessionManger == nil) {
        _httpSessionManger = [AFHTTPSessionManager manager];
        _httpSessionManger.requestSerializer = [AFHTTPRequestSerializer serializer];
        _httpSessionManger.requestSerializer.timeoutInterval = 60.0f;
        _httpSessionManger.responseSerializer = [AFJSONResponseSerializer serializer];
        _httpSessionManger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _httpSessionManger.securityPolicy.allowInvalidCertificates = YES;
        _httpSessionManger.securityPolicy.validatesDomainName = NO;
        _httpSessionManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    }
    return _httpSessionManger;
}

@end
