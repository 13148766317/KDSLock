//
//  KDSMessageCenterCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/23.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSSytemMsgNumModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSMessageCenterCell : UITableViewCell
//@property (nonatomic,copy)NSString      * titleString;
//@property (nonatomic,copy)NSString      * imageString;
@property (nonatomic,strong)KDSSytemMsgNumModel   * model;
+(instancetype)messageCenterCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
