//
//  KDSNewPersonCouponsController.h
//  kaadas
//
//  Created by 中软云 on 2019/7/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSCouponModel.h"

typedef void(^KDSCouponsGetButtonClick)(void);
typedef void(^KDSCouponsCancelButtonClick)(void);

NS_ASSUME_NONNULL_BEGIN

@interface KDSNewPersonCouponsController : UIViewController
-(void)showVC:(UIViewController *)vc WithModel:(KDSCouponModel *)model getButtonClick:(KDSCouponsGetButtonClick)getButtonClick cancelButtonClick:(KDSCouponsGetButtonClick)canceClick;
+(instancetype)showCouponsWithModel:(KDSCouponModel *)model getButtonClick:(KDSCouponsGetButtonClick)getButtonClick cancelButtonClick:(KDSCouponsGetButtonClick)canceClick;
@end

NS_ASSUME_NONNULL_END
