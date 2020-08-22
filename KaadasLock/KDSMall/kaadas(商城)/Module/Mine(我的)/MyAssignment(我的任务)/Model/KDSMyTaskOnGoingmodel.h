//
//  KDSMyTaskOnGoingmodel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class KDSMyTaskOnGoingRowmodel;

@interface KDSMyTaskOnGoingmodel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray  <KDSMyTaskOnGoingRowmodel *>  * list;
@end


@interface KDSMyTaskOnGoingRowmodel : NSObject
// stirng 任务名称
@property (nonatomic,copy)NSString      * name;
// int 任务需要的数量
@property (nonatomic,assign)NSInteger    conditionQty;
// int 用户完成的数量
@property (nonatomic,assign)NSInteger    finishQty;
// int 用户未完成的数量
@property (nonatomic,assign)NSInteger    notFinishQty;
 // string 图片
@property (nonatomic,copy)NSString      * logo;

@end

NS_ASSUME_NONNULL_END
