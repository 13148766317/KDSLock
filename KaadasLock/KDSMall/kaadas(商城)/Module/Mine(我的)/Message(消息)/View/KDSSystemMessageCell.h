//
//  KDSSystemMessageCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSSystemMessageCell : UITableViewCell
@property (nonatomic,strong)KDSMessageRowModel   * rowModel;
+(instancetype)systemMessageCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
