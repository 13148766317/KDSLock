//
//  KDSMyTeamCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSMyTeamCellDelegate <NSObject>
-(void)myTeamCellEvent;
-(void)myTeamCellTapClick:(NSInteger)index;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyTeamCell : UITableViewCell
@property (nonatomic,strong)NSDictionary   * dict;
@property (nonatomic,weak)id <KDSMyTeamCellDelegate> delegate;
+(instancetype)myTeamCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
