//
//  KDSIntergralDetailCell.h
//  kaadas
//
//  Created by 中软云 on 2019/7/16.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSIntergralDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDSIntergralDetailCell : UITableViewCell
@property (nonatomic,strong)KDSIntergralDetailRowModel   * rowModel;
+(instancetype)interfralDetailCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
