//
//  KDSMineInfoCell.h
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KDSMineInfoEventType){
    KDSMineInfoEvent_message,//消息提醒
    KDSMineInfoEvent_setting,//设置
    KDSMineInfoEvent_icon,   //头像
    KDSMineInfoEvent_QRCode  //二维码
};

@protocol KDSMineInfoCellDelegate <NSObject>
-(void)mineInfoCellEventType:(KDSMineInfoEventType)type;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMineInfoCell : UITableViewCell
@property (nonatomic,weak)id <KDSMineInfoCellDelegate> delegate;
+(instancetype)MineInfoWithTableView:(UITableView *)tableView;
-(void)refreshData;
@end

NS_ASSUME_NONNULL_END
