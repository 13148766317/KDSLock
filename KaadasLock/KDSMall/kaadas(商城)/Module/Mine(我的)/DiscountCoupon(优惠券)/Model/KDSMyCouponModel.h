//
//  KDSMyCouponModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/11.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSMyCouponRowModel;

@interface KDSMyCouponModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray <KDSMyCouponRowModel *>* list;
@end

@interface KDSMyCouponRowModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
// 过期时间
@property (nonatomic,copy)NSString      * expirationDate;
 //开始时间
@property (nonatomic,copy)NSString      * startDate;
// 优惠券状态coupon_status_used
@property (nonatomic,copy)NSString      * state;
// string 折扣
@property (nonatomic,copy)NSString      * remark;//满减劵
// 使用条件
@property (nonatomic,copy)NSString      * couponCondition;
 // 优惠金额
@property (nonatomic,copy)NSString      * couponValue;

@property (nonatomic,copy)NSString      * couponSourceCN;//coupon_status_no_use
@property (nonatomic,copy)NSString      * couponSource;//coupon_sources_shop
@property (nonatomic,copy)NSString      * couponTypeCN;
@property (nonatomic,copy)NSString      * createDate;
@property (nonatomic,copy)NSString      * publishQty;
@property (nonatomic,copy)NSString      * stateCN;
@property (nonatomic,copy)NSString      * remainQty;
@property (nonatomic,copy)NSString      * couponType;//coupon_type_full_subtraction
@property (nonatomic,copy)NSString      * useQty;
@property (nonatomic,copy)NSString      * createBy;

@end

NS_ASSUME_NONNULL_END
