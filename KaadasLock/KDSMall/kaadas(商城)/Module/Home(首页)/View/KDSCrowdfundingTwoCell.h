//
//  KDSCrowdfundingTwoCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
// 今日众筹

#import <UIKit/UIKit.h>

@protocol KDSCrowdfundingTwoCellDelegate <NSObject>
-(void)crowdfundingTwoCellButtonClick:(NSIndexPath *_Nullable)indexPath buttonTag:(NSInteger)buttonTag;
-(void)crowdfundingTwoCellCheckButtonClick:(NSIndexPath *_Nullable)indexPath buttonTag:(NSInteger)buttonTag;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSCrowdfundingTwoCell : UITableViewCell
@property (nonatomic,strong)NSArray   * array;
@property (nonatomic,weak)id <KDSCrowdfundingTwoCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath   * indexPath;
+(instancetype)crowdfundingTwoCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
