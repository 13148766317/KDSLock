//
//  KDSNavigationController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMallNC.h"

@interface KDSMallNC ()

@end

@implementation KDSMallNC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationBar.hidden = YES;
    //统一设置导航栏的字体颜色和大小
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"333333"],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"self.viewControllers:  %@",self.viewControllers);
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //返回按钮
//        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//        [backButton addTarget:self action:@selector(bacnButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        backButton.frame = CGRectMake(-20, 0, 50, 44);
//        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
//        UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
////        viewController.navigationItem.leftBarButtonItem = leftBarButton;
//        viewController.navigationItem.backBarButtonItem = leftBarButton;
    }
    [super pushViewController:viewController animated:animated];
}

//
//-(void)bacnButtonClick{
//    [self popViewControllerAnimated:YES];
//}
#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate{
    return [[self.viewControllers lastObject]shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self.viewControllers lastObject]supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}
@end
