//
//  KDSActivityOrderController.h
//  kaadas
//
//  Created by 中软云 on 2019/7/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDSActivityOrderController : BaseDataLoadController
@property (nonatomic,strong)NSDictionary   * dict;
//从该页面返回是否回到rootViewController
@property (nonatomic,assign)BOOL     backPopToRoot;
@end

NS_ASSUME_NONNULL_END
