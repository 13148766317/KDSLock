//
//  KDSOrderMessageController.h
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"
typedef void(^KDSOrderMessageBackBlock)(BOOL success);

NS_ASSUME_NONNULL_BEGIN

@interface KDSOrderMessageController : KDSBaseController
@property (nonatomic,copy)KDSOrderMessageBackBlock      backBlock;
@end

NS_ASSUME_NONNULL_END
