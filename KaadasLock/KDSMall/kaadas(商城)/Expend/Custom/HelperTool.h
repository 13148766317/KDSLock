//
//  HelperTool.h
//  kaadas
//
//  Created by 中软云 on 2019/6/19.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDSTabBarController.h"
#import "ios-ntp.h"

NS_ASSUME_NONNULL_BEGIN

@interface HelperTool : NSObject

@property (nonatomic,strong)KDSTabBarController   * tableBarVC;
@property (nonatomic,strong)NetworkClock         * clock;
//是否token失效
@property (nonatomic,assign)BOOL     isUnToken;
@property (nonatomic,assign)BOOL     isUpload;
@property (nonatomic,assign)BOOL     isHomeCoupon;
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
