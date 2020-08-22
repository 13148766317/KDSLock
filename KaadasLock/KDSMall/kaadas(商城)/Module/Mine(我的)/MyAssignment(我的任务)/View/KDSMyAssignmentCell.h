//
//  KDSMyAssignmentCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/20.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSMyTaskOnGoingmodel.h"
#import "KDSmyTaskFinishModel.h"

typedef NS_ENUM(NSInteger,KDSAssignmentCellType){
    KDSAssignmentCellType_proceed,//进行中
    KDSAssignmentCellType_complete//已完成
};

@protocol KDSMyAssignmentCellDelegate <NSObject>
-(void)myAssignmentButtonClickIndexPath:(NSIndexPath *_Nullable)indexPath;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyAssignmentCell : UITableViewCell
@property (nonatomic,strong)KDSMyTaskOnGoingRowmodel   * rowModel;
@property (nonatomic,strong)KDSmyTaskFinishRowModel   * finishModel;
@property (nonatomic,weak)id <KDSMyAssignmentCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,assign)KDSAssignmentCellType        cellType;
+(instancetype)myAssignmentCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
