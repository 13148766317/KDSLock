//
//  KDSProductIntroduceCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductIntroduceCell : UITableViewCell
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,copy)NSString      * titleString;
@property (nonatomic,copy)NSString      * detailString;
+(instancetype)ProductIntroducCelleWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
