//
//  KDSMyTeamDetailCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSMyTeamModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyTeamDetailCell : UITableViewCell
@property (nonatomic,strong)KDSMyTeamRowModel   * rowModel;
+(instancetype)myTeamDetailCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
