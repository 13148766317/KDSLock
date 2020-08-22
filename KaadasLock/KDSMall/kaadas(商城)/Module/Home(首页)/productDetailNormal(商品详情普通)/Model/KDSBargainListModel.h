//
//  KDSBargainListModel.h
//  kaadas
//
//  Created by 中软云 on 2019/7/19.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KDSBargainListRowModel;

NS_ASSUME_NONNULL_BEGIN

@interface KDSBargainListModel : NSObject
@property (nonatomic,assign)NSInteger      total;
@property (nonatomic,strong)NSArray  <KDSBargainListRowModel *>  * list;
@property (nonatomic,assign)NSInteger      pageNo;
@property (nonatomic,assign)NSInteger      pageSize;


@end



@interface KDSBargainListRowModel : NSObject

@property (nonatomic,copy)NSString      * status;
@property (nonatomic,copy)NSString      * beginTime;
@property (nonatomic,copy)NSString      * ID;
@property (nonatomic,copy)NSString      * productId;
@property (nonatomic,copy)NSString      * price;
@property (nonatomic,copy)NSString      * activityProductId;
@property (nonatomic,copy)NSString      * endTime;
@property (nonatomic,copy)NSString      * businessType;
@property (nonatomic,assign)BOOL          flg;
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,copy)NSString      * logo;
@property (nonatomic,assign)NSInteger     customerBargainId;
@property (nonatomic,copy)NSString      * cutPrice;
@property (nonatomic,copy)NSString      * maxPrice;
@property (nonatomic,assign)NSInteger     sendNumber;

@end

NS_ASSUME_NONNULL_END
