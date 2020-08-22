//
//  KDSSettingsCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSSettingsCell : UITableViewCell
@property (nonatomic,copy)NSString      * titleString;
@property (nonatomic,assign)BOOL          hiddenArrow;
@property (nonatomic,assign)NSInteger     cacheSize;
@property (nonatomic,assign)BOOL          isClear;
+(instancetype)settingsCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
