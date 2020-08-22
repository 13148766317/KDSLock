//
//  KDSIntergralDetailModel.h
//  kaadas
//
//  Created by 中软云 on 2019/7/19.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSIntergralDetailRowModel;

@interface KDSIntergralDetailModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSMutableArray <KDSIntergralDetailRowModel *>  * list;
@end



@interface KDSIntergralDetailRowModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,assign)NSInteger     indentId;
@property (nonatomic,copy)NSString      * score;
@property (nonatomic,copy)NSString      * type;
@property (nonatomic,copy)NSString      * createBy;
@property (nonatomic,copy)NSString      * createDate;
@property (nonatomic,copy)NSString      * typeCN;
@end

NS_ASSUME_NONNULL_END
