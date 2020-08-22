//
//  KDSEvaluateTagHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/6/28.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSEvaluateTagHeaderViewDelegate <NSObject>
-(void)evaluateTagHeaderViewButtonClick:(NSInteger)buttonTag;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSEvaluateTagHeaderView : UITableViewHeaderFooterView
@property (nonatomic,weak)id <KDSEvaluateTagHeaderViewDelegate> delegate;
@property (nonatomic,strong)NSArray         * titleArray;
@property (nonatomic,assign)NSInteger         selectIndex;
+(instancetype)evaluateTagHeaderViewWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
