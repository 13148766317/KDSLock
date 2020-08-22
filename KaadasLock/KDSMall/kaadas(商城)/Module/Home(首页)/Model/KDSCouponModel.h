//
//  KDSCouponModel.h
//  kaadas
//
//  Created by 中软云 on 2019/7/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSCouponModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * money;//券金额
@property (nonatomic,assign)BOOL          status;//领取状态  0 未领取  1已领取
@end

NS_ASSUME_NONNULL_END
