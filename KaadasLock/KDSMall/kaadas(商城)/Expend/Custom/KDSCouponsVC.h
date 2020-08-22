//
//  KDSCouponsVC.h
//  kaadas
//
//  Created by 中软云 on 2019/7/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSCoupon1Model.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^KDSCouponsSelectBlock)(NSString * selectCouponID, KDSCoupon1Model * model);

@interface KDSCouponsVC : UIViewController
+(instancetype)showWithcouponID:(NSString *)couponID  data:(NSMutableArray *)dataArray selectBlock:(KDSCouponsSelectBlock)selectBlock;
@end

NS_ASSUME_NONNULL_END
