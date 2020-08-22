//
//  KDSWithdrawalDesModel.h
//  kaadas
//
//  Created by 中软云 on 2019/7/26.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSWithdrawalDesModel : NSObject
//可提现金额
@property (nonatomic,copy)NSString      * balance;
//银行卡号
@property (nonatomic,copy)NSString      * bankcard;
//提现说明
@property (nonatomic,copy)NSString      * remark;
@end

NS_ASSUME_NONNULL_END
