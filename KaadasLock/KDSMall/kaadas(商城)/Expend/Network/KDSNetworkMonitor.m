//
//  KDSNetworkMonitor.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSNetworkMonitor.h"

@interface KDSNetworkMonitor ()
@property (nonatomic,assign)BOOL                            isReachable;
@property (nonatomic,assign)AFNetworkReachabilityStatus     networkStatus;
@end

@implementation KDSNetworkMonitor
//单利
+(instancetype)sharedInstance{
    static KDSNetworkMonitor * sharedIntance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedIntance = [[KDSNetworkMonitor alloc]init];
    });
    return sharedIntance;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _isReachable = YES;
        [self startNetworkMonitoring];
    }
    
    return self;
}

-(void)startNetworkMonitoring{
    AFNetworkReachabilityManager  * afnetworkManager = [AFNetworkReachabilityManager sharedManager];
    
    __weak typeof(self)weakSelf = self;
    [afnetworkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                weakSelf.isReachable = NO;
                weakSelf.networkStatus = AFNetworkReachabilityStatusNotReachable;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                weakSelf.isReachable = YES;
                weakSelf.networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                weakSelf.isReachable = YES;
                weakSelf.networkStatus =  AFNetworkReachabilityStatusReachableViaWWAN;
                break;
            }
            default:
                weakSelf.networkStatus =  AFNetworkReachabilityStatusUnknown;
                weakSelf.isReachable = NO;
                break;
        }
    }];
    [afnetworkManager startMonitoring];
}
//是否有网络
-(BOOL)isNetworkReachable{
    [self startNetworkMonitoring];
    return _isReachable;
}
//获取网络类型
-(AFNetworkReachabilityStatus)networkStatus{
    [self startNetworkMonitoring];
    return  _networkStatus;
}
@end
