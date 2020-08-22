//
//  QZRegisterPWDController.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
// 注册   设置密码

#import "QZBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QZRegisterPWDController : BaseDataLoadController
@property (nonatomic,copy)NSString * telString;
//@property (nonatomic,copy)NSString * codeString;

//@property (nonatomic,copy)NSString * invitationCode;
@property (nonatomic,copy)NSString * aToken;

@end

NS_ASSUME_NONNULL_END
