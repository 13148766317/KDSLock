//
//  KDSBindInvitationCodeController.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/23.
//  Copyright © 2019 qizhi. All rights reserved.
// 绑定邀请码

#import "KDSBaseController.h"

typedef void(^KDSBindCodeSuccessBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface KDSBindInvitationCodeController : KDSBaseController
@property (nonatomic,copy)KDSBindCodeSuccessBlock  bindCodeSuccessBlock;
@end

NS_ASSUME_NONNULL_END
