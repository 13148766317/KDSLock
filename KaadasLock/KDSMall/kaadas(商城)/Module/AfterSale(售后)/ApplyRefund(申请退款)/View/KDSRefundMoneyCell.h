//
//  KDSRefundMoneyCell.h
//  kaadas
//
//  Created by 中软云 on 2019/8/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSRefundMoneyCell : UITableViewCell
@property (nonatomic,strong)UILabel   * priceLb;
+(instancetype)refundMoneyCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
