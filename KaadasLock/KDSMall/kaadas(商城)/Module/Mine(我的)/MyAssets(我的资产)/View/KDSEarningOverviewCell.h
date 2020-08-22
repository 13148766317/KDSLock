//
//  KDSEarningOverviewCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KDSMyAssetsDetailModel.h"

@protocol KDSEarningOverviewCellDelegate <NSObject>

-(void)earningOverViewCellSegmentButtonClick:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSEarningOverviewCell : UITableViewCell
@property (nonatomic,strong)KDSMyAssetsDetailModel   * assetsDetail;
@property (nonatomic,weak)id <KDSEarningOverviewCellDelegate> delegate;
+(instancetype)earningOverViewWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
