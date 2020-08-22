//
//  NewOrderListCell.h
//  rent
//
//  Created by David on 2017/8/8.
//  Copyright © 2017年 whb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,OrderListButtonType){
    OrderListButton_afterSales,//申请售后
    OrderListButton_refund    // 申请退款
};

@protocol OrderListCellDelegate <NSObject>
-(void)orderListRightButtonClick:(NSIndexPath *)indexPath buttonType:(OrderListButtonType)buttonType;
@end

@class DetailModel;
@interface OrderListCell : UITableViewCell
@property (nonatomic,weak)id <OrderListCellDelegate> delegate;
@property (nonatomic, strong) UIImageView * picView;
@property (nonatomic, strong) UILabel * nameLab;
@property (nonatomic, strong) UILabel * descLab;
@property (nonatomic, strong) UILabel * priceLab;
@property (nonatomic, strong) UILabel * countLab;
@property(nonatomic ,strong)DetailModel *detailModel;
@property (nonatomic,strong)UIButton  * rightButton;
@property (nonatomic,strong)NSIndexPath   * indexPath;
@property (nonatomic,copy)NSString      * indentStatus;
@property (nonatomic,copy)NSString      * indentType;
@property (nonatomic,copy)NSString      * orderStatus;
@end
