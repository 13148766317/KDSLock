//
//  KDSMyAssetsModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyAssetsModel : NSObject
//累计收益;
@property (nonatomic,copy)NSString      * allMoney;
//今日佣金
@property (nonatomic,copy)NSString      * todayMoney;
//可提现余额
@property (nonatomic,copy)NSString      * monthMoney;
//本月佣金
@property (nonatomic,copy)NSString      * balance;
@end

NS_ASSUME_NONNULL_END
