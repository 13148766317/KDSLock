//
//  KDSGenderAlertController.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KDSGenderType){
    KDSGenderType_male, //男
    KDSGenderType_female//女
};


typedef void(^KDSGenderBlock)(KDSGenderType type);

NS_ASSUME_NONNULL_BEGIN

@interface KDSGenderAlertController : UIViewController
+(instancetype)genderAlertGender:(NSString *)gender resultBlock:(KDSGenderBlock)resultBlock;
@end

NS_ASSUME_NONNULL_END
