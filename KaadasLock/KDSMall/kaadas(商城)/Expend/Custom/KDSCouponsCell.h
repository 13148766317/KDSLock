//
//  KDSCouponsCell.h
//  kaadas
//
//  Created by 中软云 on 2019/7/17.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSCoupon1Model.h"

@protocol KDSCouponsCellDelegate <NSObject>
-(void)couponsCellDelegate:(NSIndexPath *_Nullable)indexPath model:(KDSCoupon1Model *_Nullable)model;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSCouponsCell : UITableViewCell
@property (nonatomic,strong)KDSCoupon1Model   * model;
@property (nonatomic,strong)NSIndexPath       * indexPath;
@property (nonatomic,assign)NSInteger           selectIndex;
@property (nonatomic,copy)NSString            * couponID;

@property (nonatomic,weak)id <KDSCouponsCellDelegate> delegate;
+(instancetype)couponsCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
