//
//  KDSProductDetailEvaluateCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/22.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSProductEvaluateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSProductDetailEvaluateCell : UITableViewCell
@property (nonatomic,strong)KDSProductEvaluateRowModel   * rowModel;
//隐藏顶部的分割线
@property (nonatomic,assign)BOOL            hiddenBoldDividing;
@property (nonatomic,assign)NSInteger       count;
+(instancetype)producDetailtEvaluteCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
