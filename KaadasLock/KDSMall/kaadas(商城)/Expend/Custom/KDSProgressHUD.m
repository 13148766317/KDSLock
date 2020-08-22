//
//  KDSProgressHUD.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/26.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "KDSProgressHUD.h"

@implementation KDSProgressHUD
//普通文字提示
+ (void)showTextOnly:(NSString *)title toView:(UIView * _Nullable)view completion: (void (^)(void))completion{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [KDSProgressHUD showHUDMode:MBProgressHUDModeText Title:title toView:view];
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:1.0f];
    hud.completionBlock = completion;
}

//普通加载
+(void)showHUDTitle:(NSString *)title toView:(UIView * _Nullable)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [KDSProgressHUD showHUDMode:MBProgressHUDModeIndeterminate Title:title toView:view];
}

//失败提示
+ (void)showFailure:(NSString *)title toView:(UIView * _Nullable)view completion: (void (^)(void))completion{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:view animated:YES];
    [KDSProgressHUD showTextOnly:title toView:view completion:completion];
}

//成功提示
+ (void)showSuccess:(NSString *)title toView:(UIView * _Nullable)view completion: (void (^)(void))completion{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [KDSProgressHUD showHUDMode:MBProgressHUDModeText Title:title toView:view];
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:1.0f];
    hud.completionBlock = completion;
}

//隐藏提示
+ (void)hideHUDtoView:(UIView * _Nullable)view animated:(BOOL)animated
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+ (MBProgressHUD *)showHUDMode:(MBProgressHUDMode)mode Title:(NSString *)title toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = mode;
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.offset = CGPointMake(0, 0);//动画的上下左右偏移量
//    hud.minSize = CGSizeMake(KSCREENWIDTH, 10);
    return hud;
    
}
@end
