//
//  KDSProductDetailCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/22.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductDetailCell : UITableViewCell
@property (nonatomic,strong)UIImageView   * photoImageView;
@property (nonatomic, strong)UIButton     * btn;
+(instancetype)productDetailCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
