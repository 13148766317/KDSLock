//
//  KDSActivityMessageController.h
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"
typedef void (^KDSActivityMessageBlock)(BOOL success);
NS_ASSUME_NONNULL_BEGIN

@interface KDSActivityMessageController : KDSBaseController
@property (nonatomic,copy)KDSActivityMessageBlock      backBlock;
@end

NS_ASSUME_NONNULL_END
