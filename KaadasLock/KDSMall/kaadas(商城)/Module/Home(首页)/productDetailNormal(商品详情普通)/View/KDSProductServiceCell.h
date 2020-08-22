//
//  KDSProductServiceCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSProductServiceCellDelegate <NSObject>

-(void)productServiceCellButtonClick:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductServiceCell : UITableViewCell
@property (nonatomic,weak)id <KDSProductServiceCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,copy)NSString      * titleString;
+(instancetype)productServiceCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
