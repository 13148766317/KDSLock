//
//  KDSProductListModel.h
//  kaadas
//
//  Created by 中软云 on 2019/5/31.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSProductListRowModel;
@interface KDSProductListModel : NSObject
@property (nonatomic,assign)NSInteger          total;
@property (nonatomic,strong)NSMutableArray  <KDSProductListRowModel *> * list;
@end


@interface KDSProductListRowModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,copy)NSString      * price;
@property (nonatomic,copy)NSString      * logo;
@property (nonatomic,copy)NSString      * businessType;
@end

NS_ASSUME_NONNULL_END
