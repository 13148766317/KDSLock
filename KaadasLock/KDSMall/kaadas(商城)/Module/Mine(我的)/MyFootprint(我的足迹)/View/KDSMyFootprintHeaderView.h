//
//  KDSMyFootprintHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyFootprintHeaderView : UITableViewHeaderFooterView
@property (nonatomic,copy)NSString      * dataString;
+(instancetype)myFootPrintHeaderViewWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
