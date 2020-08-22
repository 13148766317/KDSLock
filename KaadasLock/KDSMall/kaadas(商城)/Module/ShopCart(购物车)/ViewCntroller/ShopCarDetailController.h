//
//  ShopCarDetailController.h
//  kaadas
//
//  Created by Apple on 2019/5/18.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ShopCarDetailController : BaseDataLoadController
@property(nonatomic,strong)NSMutableArray                * productIDArray;
@property (nonatomic,strong)NSDictionary                 * activityDict;
@property (nonatomic,assign)KDSProductDetailBottomType     type;


@end
NS_ASSUME_NONNULL_END
