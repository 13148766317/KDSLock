//
//  KDSGenderTableCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSGenderCellDelegate <NSObject>
-(void)genderCellSelect:(NSInteger)index;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSGenderTableCell : UITableViewCell
@property (nonatomic,weak)id <KDSGenderCellDelegate> delegate;
@property (nonatomic,assign)BOOL          hiddenDividing;
@property (nonatomic,copy)NSString      * titltString;
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,assign)NSInteger     selectIndex;
+(instancetype)genderCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
