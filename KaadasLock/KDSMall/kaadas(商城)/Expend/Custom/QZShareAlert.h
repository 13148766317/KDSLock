//
//  QZShareAlert.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/25.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZBaseController.h"


typedef NS_ENUM(NSInteger,QZShareAlertType){
    QZShareAlertType_AudioaAndVideo,//音视频分享
    QZShareAlertType_Invitation,    //邀请专区分享
    QZShareAlertType_Ambassador,    //形象大使分享
};


typedef void (^QZShareButtonClickBlock)(QZShareButtonType type);

NS_ASSUME_NONNULL_BEGIN

@interface QZShareAlert : QZBaseController
+(void)shareAlertWithType:(QZShareAlertType)alertType ButtonClick:(QZShareButtonClickBlock)shareButtonClickBlock;
@end

NS_ASSUME_NONNULL_END
