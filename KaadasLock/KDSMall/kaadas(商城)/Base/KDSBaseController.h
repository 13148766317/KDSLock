//
//  KDSBaseController.h
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "KDSNavigationBar.h"
#import "QZEmptyButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDSBaseController : UIViewController
//没有数据控件
@property (nonatomic,strong)JXLayoutButton      *  emptyButton;;
@property (nonatomic,strong)KDSNavigationBar   * navigationBarView;
@end

NS_ASSUME_NONNULL_END
