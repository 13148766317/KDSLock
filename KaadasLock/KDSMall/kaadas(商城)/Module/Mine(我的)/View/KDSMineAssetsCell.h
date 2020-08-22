//
//  KDSMineAssetsCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
//我的资产

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KDSMineAssetsEventType){
    KDSMineAssetsEvent_myAssets,       //我的资产
    KDSMineAssetsEvent_assignment,     //任务
    KDSMineAssetsEvent_discountCoupon, //优惠券
    KDSMineAssetsEvent_integral        //积分
};

@protocol KDSMineAssetsCellDelegate <NSObject>
-(void)mineAssetsCellEvent:(KDSMineAssetsEventType)type;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMineAssetsCell : UITableViewCell
-(void)refreshData;
@property (nonatomic,weak)id <KDSMineAssetsCellDelegate> delegate;
+(instancetype)mineAssetsCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
