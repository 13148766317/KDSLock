//
//  KDSmyTaskFinishModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/11.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSmyTaskFinishRowModel;

@interface KDSmyTaskFinishModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray    <KDSmyTaskFinishRowModel *> * list;
@end


@interface KDSmyTaskFinishRowModel : NSObject
//任务名称
@property (nonatomic,copy)NSString      * name;
//任务需要的数量
@property (nonatomic,copy)NSString      * conditionQty;
//图片
@property (nonatomic,copy)NSString      * logo;
//完成时间
@property (nonatomic,copy)NSString      * finishTime;

@end

NS_ASSUME_NONNULL_END
