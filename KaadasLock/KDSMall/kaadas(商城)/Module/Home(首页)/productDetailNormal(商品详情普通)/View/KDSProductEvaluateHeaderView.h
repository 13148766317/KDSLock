//
//  KDSProductEvaluateHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSProductEvaluateHeaderViewDelegate <NSObject>

-(void)productEvaluateBgButtonClick;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductEvaluateHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong)UILabel   * titleLb;
@property (nonatomic,weak)id <KDSProductEvaluateHeaderViewDelegate> delegate;
+(instancetype)productEvaluteHeaderViewWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
