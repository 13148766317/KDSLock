//
//  KDSHomePageCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSFirstPartModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol KDSHomePageCellDelegate <NSObject>
-(void)homePageCellItemButtonClick:(NSInteger)index;
-(void)homePageCellMoreButtonClick;
 
@end

@interface KDSHomePageCell : UITableViewCell
@property (nonatomic,weak)id <KDSHomePageCellDelegate> delegate;
@property (nonatomic,strong)NSArray   * categoryArray;
+(instancetype)homePageCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
