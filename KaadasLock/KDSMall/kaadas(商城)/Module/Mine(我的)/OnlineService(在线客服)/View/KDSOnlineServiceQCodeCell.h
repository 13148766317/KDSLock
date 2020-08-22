//
//  KDSOnlineServiceQCodeCell.h
//  kaadas
//
//  Created by 中软云 on 2019/7/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSOnlineServiceQCodeCell : UITableViewCell
@property (nonatomic,copy)NSString      * qrCode;
+(instancetype)onlineServiceQCodeCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
