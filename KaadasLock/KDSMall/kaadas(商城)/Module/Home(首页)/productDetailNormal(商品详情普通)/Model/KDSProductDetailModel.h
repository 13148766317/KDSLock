//
//  KDSProductDetailModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSProductImageModel;
@interface KDSProductDetailModel : NSObject

@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,copy)NSString      * logo;
// 商品的属性组合名称
@property (nonatomic,copy)NSString      * attributeComboName;
// 原价
@property (nonatomic,copy)NSString      * oldPrice;
// 商品价格 //商品团购价
@property (nonatomic,copy)NSString      * price;
@property (nonatomic,copy)NSString      * productId;
//轮播图
@property (nonatomic,strong)NSArray   <KDSProductImageModel *>  * banners;
@property (nonatomic,strong)NSArray   <KDSProductImageModel *> * detailImgs;

#pragma-----普通商品
// 月统计
@property (nonatomic,assign)NSInteger     countNum;
 //1，已经收藏，0，未收藏
@property (nonatomic,assign)BOOL         colloctFlag;


#pragma mark - 活动  共有

// 已筹数量  //已经团购数
@property (nonatomic,copy)NSString      * saleQty;
//活动商品id
@property (nonatomic,assign)NSInteger     activityProductId;
@property (nonatomic,copy)NSString      * businessType;


#pragma-----众筹
// 总众筹金额
@property (nonatomic,copy)NSString      * crowdMoney;
// 已筹金额
@property (nonatomic,copy)NSString      * saleMoney;

// 百分率
@property (nonatomic,copy)NSString      * percentage;
@property (nonatomic,copy)NSString      * beginTime;
@property (nonatomic,copy)NSString      * endTime;

#pragma-----拼团
//成团人数
@property (nonatomic,copy)NSString      * maxQty;
@property (nonatomic,copy)NSString      * discount;
@property (nonatomic,copy)NSString      * status;


//false 代表也参加活动  true 代表未参加活动
//@property (nonatomic,assign)BOOL        flg;
//限购数量
@property (nonatomic,assign)NSInteger   restrictionQty;

//剩余限购数量
@property (nonatomic,assign)NSInteger   residueNum;

@property (nonatomic,assign)double     second;
@end


@interface KDSProductImageModel : NSObject
@property (nonatomic,copy)NSString      * imgUrl;
@property (nonatomic,assign)NSInteger     productId;



@end

NS_ASSUME_NONNULL_END
