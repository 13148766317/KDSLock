//
//  KDSProductParamCell.h
//  kaadas
//
//  Created by 中软云 on 2019/6/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductParamCell : UITableViewCell
@property (nonatomic,strong)NSDictionary   * dict;
+(instancetype)productParamCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
