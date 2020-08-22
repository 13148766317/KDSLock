//
//  KDSMyCollectListModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/3.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDSMyCollectRowModel.h"

NS_ASSUME_NONNULL_BEGIN

@class KDSMyCollectRowModel;
@interface KDSMyCollectListModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray  <KDSMyCollectRowModel *> * list;
@end


NS_ASSUME_NONNULL_END
