//
//  KDSGetMoneyCell.h
//  kaadas
//
//  Created by 中软云 on 2019/6/19.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSWithdrawalDesModel.h"

@protocol KDSGetMoneyCellDelegate <NSObject>
@optional
-(void)getMoneyCell;

-(void)bindBankCardBgButtonClick;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSGetMoneyCell : UITableViewCell
@property (nonatomic,copy)NSString      * text;
@property (nonatomic,strong)KDSWithdrawalDesModel   * desModel;
@property (nonatomic,weak)id <KDSGetMoneyCellDelegate> delegate;
+(instancetype)getMoneyCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
