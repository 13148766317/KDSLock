//
//  KDSCoupon1Model.h
//  kaadas
//
//  Created by 中软云 on 2019/7/17.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSCoupon1Model : NSObject
@property (nonatomic,copy)NSString      * ID;
@property (nonatomic,copy)NSString      * state;
@property (nonatomic,copy)NSString      * couponSourceCN;
@property (nonatomic,copy)NSString      * couponSource;
@property (nonatomic,copy)NSString      * couponTypeCN;
@property (nonatomic,copy)NSString      * createDate;
@property (nonatomic,copy)NSString      * publishQty;
@property (nonatomic,copy)NSString      * stateCN;
@property (nonatomic,copy)NSString      * couponValue;
@property (nonatomic,copy)NSString      * expirationDate;
@property (nonatomic,copy)NSString      * remainQty;
@property (nonatomic,copy)NSString      * remark;
@property (nonatomic,copy)NSString      * couponCondition;
@property (nonatomic,copy)NSString      * startDate;
@property (nonatomic,copy)NSString      * couponType;
@property (nonatomic,copy)NSString      * useQty;
@property (nonatomic,copy)NSString      * createBy;

@property (nonatomic,assign)BOOL          select;
@end

NS_ASSUME_NONNULL_END
