//
//  KDSProductCategoryController.h
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"
#import "KDSFirstPartModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSProductCategoryController : KDSBaseController
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * titleStr;
@property (nonatomic,assign)BOOL          isActivity;
@property (nonatomic,copy)NSString      * type;
 
@end

NS_ASSUME_NONNULL_END
