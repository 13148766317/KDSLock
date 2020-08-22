//
//  KDSSpreadCell.h
//  kaadas
//
//  Created by 中软云 on 2019/7/1.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSSpreadCellDelegate <NSObject>

-(void)spreadCellButtonClick;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSSpreadCell : UITableViewCell
@property(nonatomic,weak) id <KDSSpreadCellDelegate> delegate;
+(instancetype)spreadCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
