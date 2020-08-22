//
//  JavaNetClass.m
//  Rent3.0
//
//  Created by Apple on 2018/7/18.
//  Copyright © 2018年 whb. All rights reserved.
//

#import "JavaNetClass.h"
#define APPERROR @"-1"
@implementation JavaNetClass
+(void)JavaNetRequestWithPort:(NSString *)str andPartemer:(NSDictionary *) dic Success:(SuccessRespondBlock)successResponse{
    
    NSURL* baseURL = [NSURL URLWithString:baseuUrl];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];//设置超时时间
    manager.requestSerializer.timeoutInterval = 6.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
    response.removesKeysWithNullValues = YES;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.requestSerializer.HTTPShouldHandleCookies = YES;

    
#ifdef ContentType2
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentType2];
#endif
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript",@"text/plain", nil];
    

    NSString *astr =  [NSString stringWithFormat:@"%@%@",baseuUrl,str];
    NSLog(@"请求接口:%@ " , astr);
    NSMutableDictionary * newDict = [NSMutableDictionary dictionary];
    [newDict setValue:@"ios" forKey:@"device"];
    [newDict addEntriesFromDictionary:dic];
    NSLog(@"请求参数:%@ " , newDict);
    [manager POST:[NSString stringWithFormat:@"%@%@",baseuUrl ,str] parameters:newDict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject1=%@" ,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败返回=%@" ,error);
        if(error.code==-1009){
            NSDictionary *codeDic=@{@"errCode":@"-1009",@"msg":@"网络未连接!"};
            successResponse(codeDic);
        }else{
            NSDictionary *codeDic=@{@"errCode":APPERROR,@"msg":@"未知错误!"};
            successResponse(codeDic);
        }
    }];
    
}




@end
