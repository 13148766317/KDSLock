//
//  KDSMineUnlockAmountCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/10.
//  Copyright © 2019 kaadas. All rights reserved.
//待解锁金额

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KDSMineUnlockAmountEventType){
    KDSUnlockAmount_question, //问号事件
    KDSUnlockAmount_invitation//去邀请好友
};

@protocol KDSMineUnlockAmountCellDelegate <NSObject>
-(void)mineUnlockAmountCellEventClick:(KDSMineUnlockAmountEventType)type;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMineUnlockAmountCell : UITableViewCell
@property (nonatomic,weak)id <KDSMineUnlockAmountCellDelegate> delegate;
+(instancetype)mineUnlockAmountCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
