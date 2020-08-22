//
//  KDSNetworkMonitor.h
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSNetworkMonitor : NSObject
//单利
+(instancetype)sharedInstance;
-(void)startNetworkMonitoring;
//是否有网络
-(BOOL)isNetworkReachable;
//获取网络类型
-(AFNetworkReachabilityStatus)networkStatus;
@end

NS_ASSUME_NONNULL_END
