//
//  KDSPayTableCell.h
//  kaadas
//
//  Created by 中软云 on 2019/6/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDSPayTableCell : UITableViewCell
@property (nonatomic, strong)PayTypeModel *payTypeModel;
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,assign)NSInteger     selectIndex;
+(instancetype)payTableViewCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
