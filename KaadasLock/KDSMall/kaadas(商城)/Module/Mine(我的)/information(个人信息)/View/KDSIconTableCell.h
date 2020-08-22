//
//  KDSIconTableCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSInformationBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDSIconTableCell : KDSInformationBaseCell
@property (nonatomic,strong)UIImageView   * iconImageView;
+(instancetype)iconCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
