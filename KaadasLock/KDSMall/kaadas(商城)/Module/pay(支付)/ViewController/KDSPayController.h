//
//  KDSPayController.h
//  kaadas
//
//  Created by 中软云 on 2019/6/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayTypeModel.h"

typedef NS_ENUM(NSInteger,PayResultCodeType){
    PayResultCodeType_success,//支付成功
    PayResultCodeType_fail,   //支付失败
    PayResultCodeType_Cancel  //用户取消
};

typedef void (^KDSPayOkButtonClick)(PayChannelType payCannel);

typedef void (^KDSPayResultBlock)(PayResultCodeType recustCode);;
typedef void(^KDSCancelButtonClick)(void);

NS_ASSUME_NONNULL_BEGIN

@interface KDSPayController : UIViewController
+(instancetype)showPay:(NSString *)priceString orderNo:(NSString *)orderNo  payResult:(KDSPayResultBlock)payResult cancelButtonClick:(KDSCancelButtonClick)cancelButtonClick;

+(instancetype)showPay:(NSString *)priceString okButtonClick:(KDSPayOkButtonClick)okButtonClick cancelButtonClick:(KDSCancelButtonClick)cancelButtonClick;
@end

NS_ASSUME_NONNULL_END
