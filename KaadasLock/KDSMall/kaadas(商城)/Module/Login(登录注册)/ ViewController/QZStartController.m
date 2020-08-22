//
//  QZStartController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/12.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZStartController.h"
#import "QZRegisterController.h"
#import "QZAccountLoginController.h"
#import "QZVerifyCodeLoginController.h"
//#import "KDSProgressHUD.h"

@interface QZStartController ()

@end

@implementation QZStartController

- (void)viewDidLoad {
    [super viewDidLoad];
   //创建UI
    [self createUI];
}

#pragma mark - 登录事件
-(void)loginButtonClick{

    QZVerifyCodeLoginController  * verifyCodeloginController = [[QZVerifyCodeLoginController alloc]init];
    [self.navigationController pushViewController:verifyCodeloginController animated:YES];
}

#pragma mark - 注册事件
-(void)registerButtonClick{
    

    QZRegisterController  * registerController = [[QZRegisterController alloc]init];
    [self.navigationController pushViewController:registerController animated:YES];
}

#pragma mark - 创建UI
-(void)createUI{
    //隐藏导航栏
//    self.jz_navigationBarHidden = YES;
  
    //渐变背景颜色
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = [UIScreen mainScreen].bounds;
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 0.5);
    gl.colors = @[(__bridge id)[UIColor hx_colorWithHexRGBAString:@"#FF6A78"].CGColor,
                  (__bridge id)[UIColor hx_colorWithHexRGBAString:@"#f36a5f"].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [self.view.layer addSublayer:gl];
    
    NSArray * qizhiArray = [NSArray arrayWithObjects:@"Q",@"I",@"Z",@"H",@"I", nil];
    CGFloat labely = 45.0f;
    CGFloat labelWidth = KSCREENWIDTH /  qizhiArray.count;
    CGFloat labelhHeight = 25.0f;
    
    for (int i = 0 ; i <qizhiArray.count ; i++) {
        UILabel * label = [KDSMallTool createLabelString:qizhiArray[i] textColorString:@"#FFFFFF" font:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0).mas_offset(i * labelWidth);
            make.top.mas_equalTo(labely);
            make.size.mas_equalTo(CGSizeMake(labelWidth, labelhHeight));
        }];
    }
    
    //logo
    UIImageView * logoImageView = [[UIImageView alloc]init];
    UIImage * logoimage = [UIImage imageNamed:@"启动页logo"];
    logoImageView.image = logoimage;
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(132);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake((KSCREENWIDTH - 2 * 40), (KSCREENWIDTH - 2 * 40) * logoimage.size.height / logoimage.size.width));
    }];

    CGFloat buttonheight = 44.0f;
    //登录
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#F36A5F"] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
    loginButton.layer.cornerRadius = 5;
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(buttonheight);
        make.width.mas_equalTo(KSCREENWIDTH / 2 - 30 - 10);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-50);
    }];

    //注册
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#F36A5F"] forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
    registerButton.layer.cornerRadius= 5 ;
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(buttonheight);
        make.width.mas_equalTo(loginButton.mas_width);
        make.top.mas_equalTo(loginButton.mas_top);
    }];

}

@end
