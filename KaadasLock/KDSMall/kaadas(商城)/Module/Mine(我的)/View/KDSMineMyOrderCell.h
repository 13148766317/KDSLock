//
//  KDSMineMyOrderCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
// 全部订单

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KDSMyOrderEventType){
    KDSMyOrderEvent_allOrder,   //全部订单
    KDSMyOrderEvent_unPay,      //待支付
    KDSMyOrderEvent_unDelivery, //待发货
    KDSMyOrderEvent_unInstall,  //待安装
    KDSMyOrderEvent_unEvaluate, //待评价
    KDSMyOrderEvent_refundAfter //退款/售后
};


@protocol KDSMineOrderCellDelegate <NSObject>
-(void)mineOrderEventType:(KDSMyOrderEventType)type;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMineMyOrderCell : UITableViewCell
@property (nonatomic,weak)id <KDSMineOrderCellDelegate> delegate;
+(instancetype)mineMyOrderCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
