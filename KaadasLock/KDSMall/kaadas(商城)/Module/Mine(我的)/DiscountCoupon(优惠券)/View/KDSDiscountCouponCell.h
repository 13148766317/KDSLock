//
//  KDSDiscountCouponCell.h
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSMyCouponModel.h"

@protocol KDSDiscountCouponCellDelegate <NSObject>
-(void)discountCouponCellUserButtonClickIndexPath:(NSIndexPath *_Nullable)indexPath;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSDiscountCouponCell : UITableViewCell
@property (nonatomic,strong)KDSMyCouponRowModel   * rowModel;
@property (nonatomic,weak)id <KDSDiscountCouponCellDelegate> delegate;
//是否为过期的优惠券
@property(nonatomic,assign)BOOL   overdue;
@property (nonatomic,strong)NSIndexPath   * indexPath;
+(instancetype)discountCouponCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
