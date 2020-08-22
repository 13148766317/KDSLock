//
//  KDSHomeMoreItemCell.h
//  kaadas
//
//  Created by 中软云 on 2019/8/26.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSHomeMoreItemCellDelegate <NSObject>
-(void)homeMoreItemCellButtonClick:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSHomeMoreItemCell : UITableViewCell
@property (nonatomic,weak)id <KDSHomeMoreItemCellDelegate> delegate;
+(instancetype)homeMoreItemWithTableView:(UITableView *)tableView dataArray:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
