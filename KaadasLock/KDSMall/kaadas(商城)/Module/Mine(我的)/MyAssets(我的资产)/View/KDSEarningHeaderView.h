//
//  KDSEarningHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSEarningDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSEarningHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong)KDSEarningMonthModel   * monthModel;
+(instancetype)earningHeaderWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
