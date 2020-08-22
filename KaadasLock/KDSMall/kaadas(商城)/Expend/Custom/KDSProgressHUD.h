//
//  KDSProgressHUD.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/26.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSProgressHUD : NSObject
//普通文字提示Ï
+ (void)showTextOnly:(NSString *)title toView:(UIView  * _Nullable)view completion: (void (^)(void))completion;

//普通加载
+ (void)showHUDTitle:(NSString *)title toView:(UIView * _Nullable)view;

//失败提示
+ (void)showFailure:(NSString *)title toView:(UIView * _Nullable )view completion: (void (^)(void))completion;

//成功提示
+ (void)showSuccess:(NSString *)title toView:(UIView * _Nullable)view completion: (void (^)(void))completion;
//隐藏提示
+ (void)hideHUDtoView:(UIView * _Nullable)view animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
