//
//  QZBaseController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/11.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZBaseController.h"

@interface QZBaseController ()
@end

@implementation QZBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FAFAFA"];
    
}
//返回数据成功
-(Boolean)isSuccessData:(id)responseObject{
    NSString *errCode=[NSString stringWithFormat:@"%@", responseObject[@"code"]];
    return [errCode isEqualToString:@"1"];
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

#pragma mark -
-(QZEmptyButton *)emptyButton{
    if (_emptyButton == nil) {
        _emptyButton = [QZEmptyButton buttonWithType:UIButtonTypeCustom];
        _emptyButton.userInteractionEnabled = NO;
        [_emptyButton addTarget:self action:@selector(emptyDataButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _emptyButton.hidden = YES;
        _emptyButton.frame = CGRectMake(0, 100, KSCREENWIDTH, KSCREENHEIGHT * 0.35);
    }
    
    return _emptyButton;
}

-(void)emptyDataButtonClick{}

@end
