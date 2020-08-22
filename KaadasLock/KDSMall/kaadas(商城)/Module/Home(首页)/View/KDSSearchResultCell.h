//
//  KDSSearchResultCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSSearchModel.h"
#import "KDSProductListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSSearchResultCell : UITableViewCell
@property (nonatomic,strong)KDSSearchRowModel   * rowModel;
@property (nonatomic,strong)KDSProductListRowModel   * listRowModel;
+(instancetype)searchResultCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
