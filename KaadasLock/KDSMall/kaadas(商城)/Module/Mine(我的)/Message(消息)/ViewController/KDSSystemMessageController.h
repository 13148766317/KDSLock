//
//  KDSSystemMessageController.h
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"

typedef void(^KDSSystemMessageBack)(BOOL success);
NS_ASSUME_NONNULL_BEGIN

@interface KDSSystemMessageController : KDSBaseController
@property (nonatomic,copy)KDSSystemMessageBack      backBlock;
@end

NS_ASSUME_NONNULL_END
