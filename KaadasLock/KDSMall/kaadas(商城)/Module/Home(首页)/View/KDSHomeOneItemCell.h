//
//  KDSHomeOneItemCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSHomeOneItemCell : UITableViewCell
@property (nonatomic,assign)KDSProductType     prouctType;
@property (nonatomic,strong)NSArray   * array;
@property (nonatomic,strong)NSArray   * bargainArray;
+(instancetype)homeOneItemWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
