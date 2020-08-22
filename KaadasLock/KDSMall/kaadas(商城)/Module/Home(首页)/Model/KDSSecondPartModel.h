//
//  KDSSecondPartModel.h
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class KDSSecondPartRowModel;

@interface KDSSecondPartModel : NSObject
@property (nonatomic,copy)NSString      * moduleKey;
@property (nonatomic,assign)NSInteger     showCount;
@property (nonatomic,strong)NSArray     <KDSSecondPartRowModel *> * list;
@property (nonatomic,copy)NSString      * moduleName;
@end


@interface KDSSecondPartRowModel : NSObject
//tuila   lingdong
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * logo;
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,copy)NSString      * skuName;
@property (nonatomic,copy)NSString      * price;
@property (nonatomic,copy)NSString      * businessType;


//product_type_crowd  众筹
@property (nonatomic,assign)NSInteger     agentProductId;
@property (nonatomic,assign)NSInteger     productId;
@property (nonatomic,copy)NSString      * crowdMoney;
@property (nonatomic,copy)NSString      * saleMoney;
@property (nonatomic,assign)NSInteger     count;
@property (nonatomic,assign)NSInteger     purchaseNumber;
@property (nonatomic,assign)NSInteger     activityProductId;
@property (nonatomic,copy)NSString      * percentage;

//已支持
@property (nonatomic,assign)NSInteger     saleQty;

//product_type_group 拼团
@property (nonatomic,copy)NSString      * oldPrice;
@property (nonatomic,copy)NSString      * beginTime;
@property (nonatomic,copy)NSString      * endTime;
@property (nonatomic,copy)NSString      * status;


//product_type_seckill秒杀
@property (nonatomic,copy)NSString      * agentProductIds;


@property (nonatomic,assign)double      second;

@property (nonatomic,assign)BOOL        flg;//是否已砍价 默认否

//砍价
@property (nonatomic,assign)NSInteger     customerBargainId;
@property (nonatomic,copy)NSString      * maxPrice;

@end


NS_ASSUME_NONNULL_END
