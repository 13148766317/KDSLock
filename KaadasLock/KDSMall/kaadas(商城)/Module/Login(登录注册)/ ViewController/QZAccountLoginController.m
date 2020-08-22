//
//  QZAccountLoginController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZAccountLoginController.h"
#import "QZVerifyCodeLoginController.h"
#import "QZRegisterController.h"
#import "QZForgetPWDController.h"
#import "KDSTabBarController.h"

#import "QZLoginTopView.h"
#import "QZAccountTextFieldView.h"
#import "QZPWDTextfildview.h"
#import "QZLoginBottomView.h"
#import "QZButton.h"
#import "RegexUitl.h"
#import "KDSRegisterLoginHttp.h"
#import "KDSMineHttp.h"

@interface QZAccountLoginController ()
<
QZLoginBottomViewDelegate
>
//账号输入框
@property (nonatomic,strong)QZAccountTextFieldView * accountView;
//密码输入框
@property (nonatomic,strong)QZPWDTextfildview      * pwdTextfieldView;
//登录button
@property (nonatomic,strong)QZButton               * loginButton;

@end

@implementation QZAccountLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}

#pragma mark - 登录事件
-(void)loginButtonClick{
    [self.view endEditing:YES];
    
    if (_accountView.text.length < 1) {
        [self showToastError:phoneISULL];
        return;
    }
    if (![RegexUitl checkTelNumber:_accountView.text]) {
        [self showToastError:phoneWrong];
        return;
    }
    if (_pwdTextfieldView.text.length < 1) {
        [self showToastError:passwordISNull];
        return;
    }
    //验证密码
    if (![RegexUitl checkPassword:_pwdTextfieldView.text]) {
        [self showToastError:passwordWrong];
        return;
    }
    
    NSDictionary * dic = @{@"params":@{ @"userAccount":_accountView.text, @"password":_pwdTextfieldView.text} };
    
//    __weak typeof(self)weakSelf = self;
//    [KDSProgressHUD showHUDTitle:@"正在登陆" toView:self.view];
//    [KDSRegisterLoginHttp loginWithParams:dic success:^(BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//            [UIApplication sharedApplication].keyWindow.rootViewController = [[KDSTabBarController alloc]init];
//        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
//    }];
//
    
    [self submitDataWithBlock:passwordLogin partemer:dic Success:^(id responseObject) {
        NSLog(@"登录信息=%@" ,responseObject);
        if ([self isSuccessData:responseObject]) {
            NSString *atoken = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"token"]];
            [userDefaults setObject:atoken forKey:USER_TOKEN];
            [userDefaults synchronize];
//            [UIApplication sharedApplication].keyWindow.rootViewController = [[KDSTabBarController alloc]init];
//            if (self.navigationController.viewControllers ) {
//
//            }
            [self dismissViewControllerAnimated:YES completion:^{}];
            
            NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
            NSDictionary * dictionary = @{
                                          @"params":@{},
                                          @"token":[KDSMallTool checkISNull:userToken]
                                          };
            //获取用户详情
            [KDSMineHttp mineInfoWithParams:dictionary  success:^(BOOL isSuccess, id  _Nonnull obj) {
                
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }
    }];
  
}

#pragma mark - QZLoginBottomViewDelegate
-(void)loginBottomViewButtonType:(QLLoginButtonType)buttonType{
    switch (buttonType) {
        case button_verificationCodeType:{ //验证码登录
            //            QZVerifyCodeLoginController  * verifyCodeLogin = [[QZVerifyCodeLoginController alloc]init];
            //            [self.navigationController pushViewController:verifyCodeLogin animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"验证码登录");
        }
            break;
        case button_registerAccountType:{//注册账号
            NSLog(@"注册账号");
            QZRegisterController * registervc = [[QZRegisterController alloc]init];
            [self.navigationController pushViewController:registervc animated:YES];
        }
            break;
        case button_forgetPasswordType:{//忘记密码
            NSLog(@"忘记密码");
            QZForgetPWDController * forgetPWDVC = [[QZForgetPWDController alloc]init];
            [self.navigationController pushViewController:forgetPWDVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 创建UI
-(void)createUI{
    //    self.jz_navigationBarHidden = YES;
    self.navigationBarView.hidden = YES;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
    QZLoginTopView  * topLogoView = [[QZLoginTopView alloc]init];
    [self.view addSubview:topLogoView];
    [topLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(KSCREENHEIGHT / 4.5);
    }];
    
    //账号输入框
    _accountView = [[QZAccountTextFieldView alloc]initWithTitle:@"手机号" placeholder:@"请输入手机号码"];
    _accountView.maxCharacters = 11;
    _accountView.textField.text = [KDSMallTool loadAccount];
    [self.view addSubview:_accountView];
    _accountView.keyBoardType = UIKeyboardTypeNumberPad;
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(topLogoView.mas_bottom).mas_equalTo(30);
        make.height.mas_equalTo(45);
    }];
    
    
    //密码输入框
    _pwdTextfieldView = [[QZPWDTextfildview alloc]initWithTitle:@"密码" placeholder:@"请输入登录密码"];
    _pwdTextfieldView.maxCharacters = 18;
    [self.view addSubview:_pwdTextfieldView];
    [_pwdTextfieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.accountView);
        make.top.mas_equalTo(self.accountView.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(self.accountView.mas_height);
    }];
    
    //登录button
    _loginButton = [QZButton buttonWithType:UIButtonTypeCustom];
    [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    _loginButton.enabled = NO;
    //    _loginButton.alpha = 0.6;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdTextfieldView.mas_bottom).mas_offset(50);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(44);
    }];
    
//    QZLoginBottomView * loginBottomView = [[QZLoginBottomView alloc]initWithLoginType:login_account];
//    loginBottomView.delegate = self;
//    [self.view addSubview:loginBottomView];
//    [loginBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.loginButton);
//        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(30);
//        make.height.mas_equalTo(35);
//    }];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HelperTool shareInstance].isHomeCoupon = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
@end
