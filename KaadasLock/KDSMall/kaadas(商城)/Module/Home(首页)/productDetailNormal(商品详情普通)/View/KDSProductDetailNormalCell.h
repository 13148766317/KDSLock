//
//  KDSProductDetailNormalCell.h
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSProductDetailModel.h"


NS_ASSUME_NONNULL_BEGIN
@protocol KDSProductDetailNormalCellDelegate <NSObject>
-(void)productDetailPreferentialButtonClick;
@end
@interface KDSProductDetailNormalCell : UITableViewCell
@property (nonatomic,copy)NSString      * productName;
@property (nonatomic,strong)KDSProductDetailModel   * detailModel;
@property (nonatomic,weak)id <KDSProductDetailNormalCellDelegate> delegate;
+(instancetype)productDetailNormalCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
