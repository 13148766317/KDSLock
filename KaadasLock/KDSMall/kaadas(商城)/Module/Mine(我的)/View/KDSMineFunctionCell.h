//
//  KDSMineFunctionCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSMineFunctionCellDelegate <NSObject>
-(void)mineFunctionCellButtonClick:(NSInteger)buttonTag;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMineFunctionCell : UITableViewCell
@property (nonatomic,weak)id <KDSMineFunctionCellDelegate> delegate;
+(instancetype)mineFunctionCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
