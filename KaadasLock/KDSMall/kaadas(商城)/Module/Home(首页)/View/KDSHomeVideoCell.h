//
//  KDSHomeVideoCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSFirstPartModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol KDSHomeVideoCellDelegate <NSObject>

-(void)videoTableCellVideoButtonClick:(NSIndexPath *)cellIndexPath videoIndex:(NSInteger)videoIndex videoView:(UIImageView *)videoView;

@end

@interface KDSHomeVideoCell : UITableViewCell
@property (nonatomic,weak)id <KDSHomeVideoCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath              * indexPath;
@property (nonatomic,strong)KDSFirstPartVideoModel   * videoModel;
+(instancetype)homeVideoCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
