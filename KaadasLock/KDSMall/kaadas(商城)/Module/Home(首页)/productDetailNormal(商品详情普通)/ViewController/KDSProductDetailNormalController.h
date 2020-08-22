//
//  KDSProductDetailNormalController.h
//  kaadas
//
//  Created by 中软云 on 2019/6/20.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"
#import "KDSSecondPartModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSProductDetailNormalController : KDSBaseController
//@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,strong)KDSSecondPartRowModel   * rowModel;
@end

NS_ASSUME_NONNULL_END
