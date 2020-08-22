//
//  KDSSeckillTwoItemCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//限时秒杀

#import <UIKit/UIKit.h>

@protocol KDSSeckillTwoItemCellDelegate <NSObject>
-(void)seckillTwoItemCellButtonClck:(NSIndexPath *_Nullable)indexPath buttonTag:(NSInteger)buttonTag;
@end


NS_ASSUME_NONNULL_BEGIN
   
@interface KDSSeckillTwoItemCell : UITableViewCell
@property (nonatomic,weak)id <KDSSeckillTwoItemCellDelegate> delegate;
@property (nonatomic,strong)NSArray   * array;
@property (nonatomic,strong)NSIndexPath   * indexPath;
+(instancetype)seckillTwoItemCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
