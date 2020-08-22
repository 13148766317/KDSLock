//
//  OrderDetailController.h
//  kaadas
//
//  Created by Apple on 2019/5/17.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KDSOrderDetailType){
    KDSOrderDetail_pay,//支付
    KDSOrderDetail_waitInstall,//确认安装
    KDSOrderDetail_cancel,//取消订单
    
};

typedef void (^DetailBlock)(void);
//typedef void (^DetailBlockResult)(KDSOrderDetailType type,NSInteger indx);
typedef void (^DetailBlockResult)(KDSOrderDetailType type, KDSProductType productType, NSInteger indx);
@class DetailModel;
@interface OrderDetailController : BaseDataLoadController
@property (nonatomic,assign)NSInteger             index;
@property(nonatomic , strong)DetailModel       * detailmodel;
@property(nonatomic ,copy)DetailBlock            detailBlock;
@property (nonatomic,copy)DetailBlockResult      detailBlockResult;

//是否为活动商品
@property (nonatomic,assign)BOOL                activity;

@end
