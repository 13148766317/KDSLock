//
//  KDSEarningDetailModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSEarningMonthModel,KDSEarningDayModel;

@interface KDSEarningDetailModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray  <KDSEarningMonthModel *> * list;
@end


@interface KDSEarningMonthModel : NSObject
@property (nonatomic,copy)NSString      * date;
@property (nonatomic,strong)NSMutableArray  <KDSEarningDayModel *> * list;
@end


@interface KDSEarningDayModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * orderNo;
@property (nonatomic,copy)NSString      * money;
//directOne直接收益,directTwo间接收益,pearlReward介绍收益,getMoney提现 ,moneyTransferFees手续费
@property (nonatomic,copy)NSString      * commissionType;
@property (nonatomic,copy)NSString      * commissionTypeCN;
//余额
@property (nonatomic,copy)NSString      * balance;
@property (nonatomic,copy)NSString      * createId;
@property (nonatomic,copy)NSString      * createTime;
@property (nonatomic,copy)NSString      * daytime;
@property (nonatomic,copy)NSString      * parentCode;
@property (nonatomic,copy)NSString      * remark;
@property (nonatomic,copy)NSString      * selfCode;
@property (nonatomic,copy)NSString      * levelIndex;


@end

NS_ASSUME_NONNULL_END
