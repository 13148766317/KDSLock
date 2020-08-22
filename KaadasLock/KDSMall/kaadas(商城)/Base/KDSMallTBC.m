//
//  KDSMallTBC.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMallTBC.h"
#import "KDSNavigationController.h"
#import "KDSHomeController.h"
#import "KDSMineController.h"
#import "WxLoginController.h"
#import "KDSMyQRCodeController.h"

@interface KDSMallTBC ()

@end

@implementation KDSMallTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabbar
    [self setTabbar];
    //添加控制器
    [self addAllViewControllers];
    [[HelperTool shareInstance] setTableBarVC:self];
}

#pragma mark - 设置tabbar
-(void)setTabbar{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"#333333"],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];

    //tabBar的颜色
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    // 关闭透明色
    [[UITabBar appearance] setTranslucent:NO];
}

#pragma mark - 添加控制器
-(void)addAllViewControllers{
    
    //首页
    [self setupChildVc:[[KDSHomeController alloc]init] title:@"首页" image:@"icon_home_search@2x" selectedImage:@"icon_home_sel"];

}
#pragma mark - 设置单个控制器属性
/**
 */
- (void)setupChildVc:(KDSBaseController *)child title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    child.tabBarItem.title = title;
    child.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    child.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     KDSNavigationController *nav = [[KDSNavigationController alloc]initWithRootViewController:child];
    [self addChildViewController:nav];
}

#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate{
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
