//
//  KDSAfterSaleModel.h
//  kaadas
//
//  Created by 中软云 on 2019/8/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSAfterSaleModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray <DetailModel *>   * list;
@end

NS_ASSUME_NONNULL_END
