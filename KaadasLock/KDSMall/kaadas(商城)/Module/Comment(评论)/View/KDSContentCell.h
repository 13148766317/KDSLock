//
//  KDSContentCell.h
//  kaadas
//
//  Created by 中软云 on 2019/7/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSEvaliateModel.h"

@protocol KDSContentCellDelegate <NSObject>
-(void)contentCellDelegateWithModel:(KDSEvaliateModel *_Nullable)model indexPath:(NSIndexPath *_Nullable)indexPath;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSContentCell : UITableViewCell
@property (nonatomic,strong)KDSEvaliateModel   * model;
@property (nonatomic,weak)id <KDSContentCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath  * indexPath;
+(instancetype)contentCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
