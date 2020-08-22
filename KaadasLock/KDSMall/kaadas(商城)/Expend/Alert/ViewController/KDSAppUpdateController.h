//
//  KDSAppUpdateController.h
//  kaadas
//
//  Created by 中软云 on 2019/8/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSSystemUpdateModel.h"
typedef void(^APPUpdateBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface KDSAppUpdateController : UIViewController
+(instancetype)showModel:(KDSSystemUpdateModel *)model UpdateBlock:(APPUpdateBlock)updateBlock;
@end

NS_ASSUME_NONNULL_END
