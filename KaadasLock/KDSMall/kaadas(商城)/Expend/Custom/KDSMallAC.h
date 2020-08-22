//
//  QZAlertController.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/20.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
//取消block
typedef void (^CancelButtonAlertBlock)(void);

//确定block
typedef void (^OKButtonAlertBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface KDSMallAC : UIViewController
//title文字的颜色
@property (nonatomic,copy)NSString * titleColor;
//title文字font
@property (nonatomic,assign)CGFloat  titleFont;
//内容文字颜色
@property (nonatomic,copy)NSString * msgColor;
//内容文字font
@property (nonatomic,assign)CGFloat  msgFont;

+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message  okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle  OKBlock:(OKButtonAlertBlock)okBlock cancelBlock:(CancelButtonAlertBlock)cancel;
@end

NS_ASSUME_NONNULL_END
