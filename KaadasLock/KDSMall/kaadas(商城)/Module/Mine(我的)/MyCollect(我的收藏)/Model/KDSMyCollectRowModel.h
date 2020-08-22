//
//  KDSMyCollectRowModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/3.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyCollectRowModel : NSObject
@property (nonatomic,assign)NSInteger     productId;
@property (nonatomic,copy)NSString      * price;
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,copy)NSString      * logo;
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,assign)BOOL          select;

@property (nonatomic,copy)NSString      * status;
@property (nonatomic,copy)NSString      * discountPrice;
@property (nonatomic,copy)NSString      * skuName;
@property (nonatomic,copy)NSString      * attributeComboKey;
@property (nonatomic,copy)NSString      * attributeComboName;
@property (nonatomic,copy)NSString      * lockStock;
@property (nonatomic,copy)NSString      * realStock;
@end

NS_ASSUME_NONNULL_END
