//
//  KDSFootPrintListModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/3.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDSMyCollectRowModel.h"
NS_ASSUME_NONNULL_BEGIN

@class KDSFootPrintRowModel;
@interface KDSFootPrintListModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSMutableArray <KDSFootPrintRowModel *>   * list;
@end

@interface KDSFootPrintRowModel : NSObject
@property (nonatomic,copy)NSString      * date;
@property (nonatomic,strong)NSMutableArray  <KDSMyCollectRowModel *> * list;
@end

NS_ASSUME_NONNULL_END
