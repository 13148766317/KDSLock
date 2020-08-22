//
//  KDSMyTeamModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSMyTeamRowModel;

@interface KDSMyTeamModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray  <KDSMyTeamRowModel *> * list;
@end

@interface KDSMyTeamRowModel : NSObject
//ID
@property (nonatomic,assign)NSInteger     ID;
//标题
@property (nonatomic,copy)NSString      * logo;
//昵称
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,copy)NSString      * tel;
//会员数
@property (nonatomic,copy)NSString      * vipCount;
//直接粉丝
@property (nonatomic,copy)NSString      * fansCount;
 //直接下级数
@property (nonatomic,copy)NSString      * direct_one_count;
 //间接下级数
@property (nonatomic,copy)NSString      * direct_two_count;
@end

NS_ASSUME_NONNULL_END
