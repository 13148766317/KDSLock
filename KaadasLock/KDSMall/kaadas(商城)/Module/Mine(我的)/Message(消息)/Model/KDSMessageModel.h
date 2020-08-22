//
//  KDSMessageModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSMessageRowModel;
@interface KDSMessageModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray  <KDSMessageRowModel *> * list;

@end

@interface KDSMessageRowModel : NSObject

@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,assign)NSInteger     senderId;
@property (nonatomic,copy)NSString      * senderType; //消息类型
@property (nonatomic,copy)NSString      * senderDate;
@property (nonatomic,copy)NSString      * content; //消息内容
@property (nonatomic,assign)NSInteger     reveicerId;
@property (nonatomic,copy)NSString      * reveicerType;
@property (nonatomic,copy)NSString      * readDate;
@property (nonatomic,assign)BOOL          markRead;//未读  0未读  1 已读
@property (nonatomic,copy)NSString      * messageType;
@property (nonatomic,assign)NSInteger     logicId;
@property (nonatomic,copy)NSString      * title; //标题
@property (nonatomic,copy)NSString      * logo;
@property (nonatomic,copy)NSString      * titleCN;
@property (nonatomic,copy)NSString      * messageTypeCN;

@end

NS_ASSUME_NONNULL_END
