//
//  KDSBaseController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"
#import "KDSHomePageHttp.h"
#import "KDSSystemUpdateModel.h"
#import "KDSAppUpdateController.h"

@interface KDSBaseController ()
@end

@implementation KDSBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBaseUI];
    
}

-(void)createBaseUI{
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"F7F7F7"];
  
    //添加导航栏
    [self.view addSubview:self.navigationBarView];
    self.navigationBarView.action  = @selector(backButtonClick);
    self.navigationBarView.tagrget = self;
    
    [self.navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(MnavcBarH);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//     [self systemUpdateRequest];
}

//-(void)systemUpdateRequest{
//    [KDSHomePageHttp systemUpgradeAppsuccess:^(BOOL isSuccess, id  _Nonnull obj) {
//        if (isSuccess) {
//            KDSSystemUpdateModel  * model = (KDSSystemUpdateModel *)obj;
//            //程序版本号
//            NSString *  appShortVersion =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ;
////            //获取APP的 build版本
////            NSString *  appBuildVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//            if ([self appShortVersion:appShortVersion compareVersionNumberB:model.versionNumber] == NSOrderedAscending) {
//                [KDSAppUpdateController showModel:model UpdateBlock:^{
//                }];
//            }
//            NSLog(@"ppppppp-----：%ld",(long)[self appShortVersion:appShortVersion compareVersionNumberB:model.versionNumber])    ;
//        }else{
//
//        }
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
//}
//
//
///**
// 比对iOS版本号字符串大小
//
// @param versionA 只能是三段以内,英文字符"."分隔的,每段必须是非负整数的版本字符串
// @param versionB 只能是三段以内,英文字符"."分隔的,每段必须是非负整数的版本字符串
// @return 从A到B,结果 -1 升序, 0 相等, 1降序
// */
//- (NSComparisonResult)appShortVersion:(NSString *)versionA compareVersionNumberB:(NSString *)versionB {
//    NSArray *stringsA = [versionA componentsSeparatedByString:@"."];
//    NSArray *stringsB = [versionB componentsSeparatedByString:@"."];
//    NSComparisonResult result = NSOrderedSame;
//
//    for (int i = 0; i < 3; i++) {
//        NSInteger numberA = 0;
//        NSInteger numberB = 0;
//        if (i < stringsA.count) {
//            numberA = [(NSString *)stringsA[i] integerValue];
//        }
//
//        if (i < stringsB.count) {
//            numberB = [(NSString *)stringsB[i] integerValue];
//        }
//
//        if (numberA > numberB) {
//            result = NSOrderedDescending;
//            break;
//        }else if (numberA < numberB){
//            result = NSOrderedAscending;
//            break;
//        }
//    }
//
//    return result;
//}


-(void)rightButtonClick{
    NSLog(@"right");
}

#pragma mark - 返回事件
-(void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
-(JXLayoutButton *)emptyButton{
    if (_emptyButton == nil) {
        _emptyButton = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
        _emptyButton.layoutStyle = JXLayoutButtonStyleUpImageDownTitle;
        _emptyButton.userInteractionEnabled = YES;
        _emptyButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_emptyButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#9E9E9E" ] forState:UIControlStateNormal];
        [_emptyButton addTarget:self action:@selector(emptyDataButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        _emptyButton.hidden = YES;
        _emptyButton.frame = CGRectMake(0, 150, KSCREENWIDTH, KSCREENHEIGHT * 0.3);
    }
    
    return _emptyButton;
}

-(void)emptyDataButtonClick{
    
    
}
#pragma mark - 导航栏懒加载
- (KDSNavigationBar *)navigationBarView{
    if (_navigationBarView == nil) {
        _navigationBarView = [[KDSNavigationBar alloc]init];
    }
    return _navigationBarView;
}

//#pragma mark - 控制屏幕旋转方法
//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate{
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end
