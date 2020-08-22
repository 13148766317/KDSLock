//
//  KDSProductCategoryHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSProductCategoryHeaderViewDelegate <NSObject>

-(void)productCategiryButtonClick:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductCategoryHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong)NSMutableArray   * categoryArray;
@property (nonatomic,weak)id <KDSProductCategoryHeaderViewDelegate> delegate;
@property (nonatomic,assign)NSInteger     selectIndex;
+(instancetype)productCategoryHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
