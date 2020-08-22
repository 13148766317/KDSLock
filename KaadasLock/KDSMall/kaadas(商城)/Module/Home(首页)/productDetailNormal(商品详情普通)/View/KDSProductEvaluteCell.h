//
//  KDSProductEvaluteCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSProductEvaluateModel.h"

@protocol KDSProductEvaluteCellDelagete <NSObject>

-(void)evaluateCellImageViewClick:(NSIndexPath *_Nullable)cellIndexPath imageIndex:(NSInteger)imageIndex imageViewArray:(NSArray *_Nullable)iamgeViewArray;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductEvaluteCell : UITableViewCell
@property (nonatomic,strong)KDSProductEvaluateRowModel  * rowModel;
//隐藏顶部的分割线
@property (nonatomic,assign)BOOL            hiddenBoldDividing;
@property (nonatomic,assign)NSInteger       count;
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,weak)id <KDSProductEvaluteCellDelagete> delegate;
+(instancetype)productEvaluteCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
