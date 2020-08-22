//
//  KDSInformationBaseCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSInformationBaseCell : UITableViewCell
@property (nonatomic,strong)UILabel       * titleLb;
@property (nonatomic,strong)UIImageView   * arrowImageView;
@property (nonatomic,strong)UIView        * dividingView;
@property (nonatomic,strong)UILabel       * detailLabel;

@property (nonatomic,copy)NSString        * titleString;
@property (nonatomic,copy)NSString        * detailString;

+(instancetype)informationBaseCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
