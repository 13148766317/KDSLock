//
//  KDSHomeTwoItemCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KDSHomeTwoItemCellDelegate <NSObject>

-(void)homeTwoItemCellButtonClick:(NSIndexPath *)indexPath buttonTag:(NSInteger)buttonTag productType:(KDSProductType)productType;

@end

@interface KDSHomeTwoItemCell : UITableViewCell
@property (nonatomic,strong)NSArray   * array;
@property (nonatomic,weak)id <KDSHomeTwoItemCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,assign)KDSProductType     productType;
@property (nonatomic,strong)NSArray   * bargainArray;
+(instancetype)homeTwoItemWithTableView:(UITableView *)tableView;
  
@end

NS_ASSUME_NONNULL_END
