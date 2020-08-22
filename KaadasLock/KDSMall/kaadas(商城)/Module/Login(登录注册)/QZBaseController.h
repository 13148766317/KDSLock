//
//  QZBaseController.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/11.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZEmptyButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QZBaseController : UIViewController
//没有数据控件
@property (nonatomic,strong)QZEmptyButton  *  emptyButton;;

-(Boolean)isSuccessData:(id)responseObject;

@end

NS_ASSUME_NONNULL_END
