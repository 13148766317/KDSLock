//
//  QZRegisterCodeController.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//   注册 验证码

#import "KDSBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QZRegisterCodeController : BaseDataLoadController
@property (nonatomic,copy)NSString * telString;
@property (nonatomic,copy)NSString * invitationCode;
@end

NS_ASSUME_NONNULL_END
