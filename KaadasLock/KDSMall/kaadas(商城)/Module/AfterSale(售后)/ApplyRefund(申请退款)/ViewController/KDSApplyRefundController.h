//
//  KDSApplyRefundController.h
//  kaadas
//
//  Created by 中软云 on 2019/8/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"
#import "DetailModel.h"

typedef void(^ApplyRefundSuccessBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface KDSApplyRefundController : KDSBaseController
@property(nonatomic,strong)NSString               * idStr;
@property(nonatomic,strong)NSString               * indentId;
@property (nonatomic,strong)NSDictionary          * infoDict;
@property (nonatomic,copy)ApplyRefundSuccessBlock   applyRefundSuccessBlock;
@end

NS_ASSUME_NONNULL_END
