//
//  KDSHomeHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSHomeHeaderViewDelegate <NSObject>

-(void)homeHeaderViewBGClick:(NSInteger)section;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSHomeHeaderView : UITableViewHeaderFooterView
@property (nonatomic,weak)id <KDSHomeHeaderViewDelegate> delegate;
@property (nonatomic,assign)NSInteger     section;
@property (nonatomic,copy)NSString      * titleString;
+(instancetype)homeHeaderViewWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
