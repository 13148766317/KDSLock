//
//  KDSOrderMessageCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSMessageModel.h"

@protocol KDSOrderMessageCellDelegate <NSObject>

-(void)orderMessageCellCheckDetailButtonClick:(NSIndexPath *_Nullable)indexPath;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSOrderMessageCell : UITableViewCell
@property (nonatomic,strong)KDSMessageRowModel   * rowModel;
@property (nonatomic,weak)id <KDSOrderMessageCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath   * indexPath;
+(instancetype)orderMessageCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
