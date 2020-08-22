//
//  KDSMyFootPrintCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSMyCollectListModel.h"

@protocol KDSMyFootPrintCellDelegate <NSObject>
-(void)myFootPrictCellSelectButtonClick:(NSIndexPath *_Nonnull)indexPath isSelect:(BOOL)isSelect;
-(void)myFootPrictCellshopCaetButtonClick:(NSIndexPath * _Nonnull)indexPath;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyFootPrintCell : UITableViewCell
@property (nonatomic,strong)KDSMyCollectRowModel   * rowModel;
@property (nonatomic,strong)KDSMyCollectRowModel   * rowFootModel;
@property (nonatomic,weak)id <KDSMyFootPrintCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,assign)BOOL     editState;
+(instancetype)myFootPrintCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
