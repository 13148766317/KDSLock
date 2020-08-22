//
//  KDSEditInfoController.h
//  kaadas
//
//  Created by 中软云 on 2019/5/16.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"

typedef NSString * _Nonnull(^KDSInfo)(int a);

typedef void(^KDSEditInfo)(NSString * _Nullable str);

NS_ASSUME_NONNULL_BEGIN

@interface KDSEditInfoController : KDSBaseController
@property (nonatomic,copy)NSString      * text;
@property (nonatomic,copy)NSString      * titleText;
@property (nonatomic,copy)KDSEditInfo     editInfo;
@end

NS_ASSUME_NONNULL_END
