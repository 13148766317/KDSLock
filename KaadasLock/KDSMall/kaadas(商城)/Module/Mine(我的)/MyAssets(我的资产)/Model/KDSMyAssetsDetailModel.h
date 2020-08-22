//
//  KDSMyAssetsDetailModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyAssetsDetailModel : NSObject
//直接收益
@property (nonatomic,copy)NSString      * earnLevelOne;
//间接收益
@property (nonatomic,copy)NSString      * earnLevelTwo;
//暂时没有
@property (nonatomic,copy)NSString      * earnTeam;
//介绍收益
@property (nonatomic,copy)NSString      * earnBole;
@end

NS_ASSUME_NONNULL_END
