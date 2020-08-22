//
//  KDSEvaliateModel.h
//  kaadas
//
//  Created by 中软云 on 2019/7/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSEvaliateModel : NSObject
@property (nonatomic,copy)NSString      * qty;
@property (nonatomic,copy)NSString      * indentId;
@property (nonatomic,copy)NSString      * ID;
@property (nonatomic,copy)NSString      * price;
@property (nonatomic,copy)NSString      * productName;
@property (nonatomic,copy)NSString      * productLabels;
@property (nonatomic,copy)NSString      * productId;
@property (nonatomic,copy)NSString      * logo;

//产品评分
@property (nonatomic,assign)NSInteger     productScore;
//评论内容
@property (nonatomic,copy)NSString      * content;
//图片
@property (nonatomic,copy)NSString      * imgs;
@property (nonatomic,strong)NSMutableArray   * imagesArray;
//是否匿名
@property (nonatomic,copy)NSString      * isAnonymous;
//商品符合度未选
@property (nonatomic,assign)NSInteger     conformityScore;
//配送评分未选
@property (nonatomic,assign)NSInteger     dispatchingScore;
//安装满意度未选 
@property (nonatomic,assign)NSInteger     installScore;

//图片数组
@property (nonatomic,strong)NSArray    * imageArray;
@end

NS_ASSUME_NONNULL_END
