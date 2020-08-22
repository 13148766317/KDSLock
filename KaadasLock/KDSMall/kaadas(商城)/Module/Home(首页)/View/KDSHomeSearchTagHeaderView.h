//
//  KDSHomeSearchTagHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSHomeSearchTagHeaderViewDelegate <NSObject>

-(void)honeSearchTagClick:(NSString *_Nullable)searchStr;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSHomeSearchTagHeaderView : UIView
@property (nonatomic,weak)id <KDSHomeSearchTagHeaderViewDelegate> delegate;
-(void)tagHeaderViewWithTableView:(UITableView *)tableView tagArray:(NSArray<NSString *> *)tagArray;
@end

NS_ASSUME_NONNULL_END
