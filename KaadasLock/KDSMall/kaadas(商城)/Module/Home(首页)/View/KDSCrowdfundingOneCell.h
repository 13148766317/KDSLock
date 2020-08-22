//
//  KDSCrowdfundingOneCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
// 今日众筹

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSCrowdfundingOneCell : UITableViewCell
@property (nonatomic,strong)NSArray   * array;
+(instancetype)crowdfundingOneCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
