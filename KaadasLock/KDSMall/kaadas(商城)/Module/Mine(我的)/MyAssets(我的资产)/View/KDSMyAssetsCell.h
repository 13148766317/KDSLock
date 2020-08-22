//
//  KDSMyAssetsCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSMyAssetsModel.h"
typedef NS_ENUM(NSInteger,KDSMyAssetsEventType){
    KDSMyAssetsEvent_earning,//明细
    KDSMyAssetsEvent_getMoney//提现
};

@protocol KDSMyAssetsCellDelegate <NSObject>
-(void)myAssetsCellEvent:(KDSMyAssetsEventType)type;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyAssetsCell : UITableViewCell
@property (nonatomic,strong)KDSMyAssetsModel   * assetsModel;
@property (nonatomic,weak)id <KDSMyAssetsCellDelegate> delegate;
+(instancetype)myAssetsCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
