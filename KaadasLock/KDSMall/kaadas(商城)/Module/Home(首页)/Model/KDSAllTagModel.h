//
//  KDSAllTagModel.h
//  kaadas
//
//  Created by 中软云 on 2019/5/28.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSAllTagModel : NSObject
@property (nonatomic,strong)NSArray    * city;//城市
@property (nonatomic,strong)NSArray    * hot_key;//热门搜索
@property (nonatomic,strong)NSArray    * NEWtype;//资讯
@property (nonatomic,strong)NSArray    * indent_type;//订单类别
@property (nonatomic,strong)NSArray    * after_sales_service;
@property (nonatomic,strong)NSArray   * activity_product_satatus;//
@property (nonatomic,strong)NSArray   * comment_type;////评价类型
@property (nonatomic,strong)NSArray   * activity_status;
@property (nonatomic,strong)NSArray   * refund_type;//退款原因
@end

//@interface KDSTagModel1 : NSObject
//@property (nonatomic,copy)NSString      * value;
//@property (nonatomic,copy)NSString      * key;
//@end

NS_ASSUME_NONNULL_END
