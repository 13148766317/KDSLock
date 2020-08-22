//
//  UIWindow+KDSRootVC.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "UIWindow+KDSRootVC.h"
//#import "QZGuideViewController.h"

#import "QZVerifyCodeLoginController.h"
#import "QZStartController.h"
#import "KDSMallNC.h"
//#import "WxLoginController.h"
#import "KDSTabBarController.h"


@implementation UIWindow (KDSRootVC)
-(void)setRootController{

//    //获取token
//    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    if (token == nil || [token isKindOfClass:[NSNull class]]) {//token为空  代表没有登录
//        //        QZNavigationController * nav = [[QZNavigationController alloc]initWithRootViewController:[[QZAccountLoginController alloc]init]];
////        KDSNavigationController * nav = [[KDSNavigationController alloc]initWithRootViewController:[[QZVerifyCodeLoginController alloc]init]];
////        KDSNavigationController * nav = [[KDSNavigationController alloc]initWithRootViewController:[[WxLoginController alloc]init]];
//
//        KDSNavigationController * nav = [[KDSNavigationController alloc]initWithRootViewController:[[KDSTabBarController alloc]init]];
//        self.rootViewController =  nav;
//    }else{
        self.rootViewController = [[KDSTabBarController alloc]init];
//    }
    
}

- (void)switchRootViewController
{
//    NSString *key = @"CFBundleVersion";
//    // 上一次的使用版本（存储在沙盒中的版本号）
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    // 当前软件的版本号（从Info.plist中获得）
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    
    //测试
    //    self.rootViewController = [[QZGuideViewController alloc] init];
    
    //真实
//    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        [self setRootController];
//    } else { // 这次打开的版本和上一次不一样，显示新特性
//        self.rootViewController = [[QZGuideViewController alloc] init];
//
//        // 将当前的版本号存进沙盒
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
}
@end
