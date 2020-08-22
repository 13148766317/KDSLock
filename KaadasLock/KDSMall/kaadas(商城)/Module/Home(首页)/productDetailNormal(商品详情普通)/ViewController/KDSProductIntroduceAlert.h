//
//  KDSProductIntroduceAlert.h
//  kaadas
//
//  Created by 中软云 on 2019/6/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,KDSProductIntroduceAlertType){
    KDSProductIntroduceAlert_parameter,// 产品参数
    KDSProductIntroduceAlert_serveice  //服务
};

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductIntroduceAlert : UIViewController
+(instancetype)productIntroduceShow:(KDSProductIntroduceAlertType)type dataArray:(NSMutableArray * _Nullable)dataArray;
@end

NS_ASSUME_NONNULL_END
