//
//  KDSProductEvaluateModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSProductEvaluateRowModel;
@interface KDSProductEvaluateModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray  <KDSProductEvaluateRowModel *> * list;
@end

@interface KDSProductEvaluateRowModel : NSObject
//是否匿名评论
@property (nonatomic,assign)BOOL      isAnonymous;
//评论人图像
@property (nonatomic,copy)NSString      * logo;

@property (nonatomic,copy)NSString      * imgs;
//评论内容
@property (nonatomic,copy)NSString      * content;
//评价分数
@property (nonatomic,assign)NSInteger     score;
//产品属性
@property (nonatomic,copy)NSString      * productLabels;
 //用户id
@property (nonatomic,assign)NSInteger     customerId;
//产品id
@property (nonatomic,assign)NSInteger     productId;
// 用户名
@property (nonatomic,copy)NSString      * userName;
// 用户评论上传的图片
@property (nonatomic,strong)NSArray     * urls;
// 评论时间
@property (nonatomic,copy)NSString      * createDate;


@end

NS_ASSUME_NONNULL_END
