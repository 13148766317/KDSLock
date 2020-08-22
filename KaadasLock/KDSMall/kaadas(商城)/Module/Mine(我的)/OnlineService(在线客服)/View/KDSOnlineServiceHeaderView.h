//
//  KDSOnlineServiceHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/7/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KDSOnlineServiceButtonType){
    KDSOnlineServiceCall,//拨打电话
    KDSOnlineServiceQRCode//二维码
};

@protocol KDSOnlineServiceHeaderViewDelegate <NSObject>
-(void)onlineServiceHeaderViewButtonType:(KDSOnlineServiceButtonType)buttontype section:(NSInteger)section buttonSelect:(BOOL)buttonSelect;

@end
NS_ASSUME_NONNULL_BEGIN

@interface KDSOnlineServiceHeaderView : UITableViewHeaderFooterView
@property (nonatomic,weak)id <KDSOnlineServiceHeaderViewDelegate> delegate;
@property (nonatomic,assign)BOOL     arrowSelect;
@property (nonatomic,strong)NSDictionary   * dict;
@property (nonatomic,assign)NSInteger     section;
+(instancetype)onlineSericeHeaderWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
