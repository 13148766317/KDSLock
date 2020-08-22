//
//  KDSSearchModel.h
//  kaadas
//
//  Created by 中软云 on 2019/5/28.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class KDSSearchRowModel;

@interface KDSSearchModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray  <KDSSearchRowModel *> * list;
@end

@interface KDSSearchRowModel : NSObject
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,copy)NSString      * price;
@property (nonatomic,copy)NSString      * logo;
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * logoImgCN;

@end


NS_ASSUME_NONNULL_END
