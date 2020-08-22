//
//  KDSSeckillOneItemCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//限时秒杀

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSSeckillOneItemCell : UITableViewCell
@property (nonatomic,strong)NSArray   * array;  
+(instancetype)seckillOneItemCellWithTableView:(UITableView *)tableView;
@property (nonatomic,assign)NSInteger     timer;
@end
 
NS_ASSUME_NONNULL_END
