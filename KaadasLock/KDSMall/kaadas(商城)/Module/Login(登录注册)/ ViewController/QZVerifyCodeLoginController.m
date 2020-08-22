//
//  QZLoginController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/12.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZVerifyCodeLoginController.h"
#import "QZAccountLoginController.h"
#import "QZRegisterController.h"
//#import "QZTabBarController.h"
#import "KDSTabBarController.h"
#import "QZLoginTopView.h"
#import "QZAccountTextFieldView.h"
#import "QZCodeTextfieldView.h"
#import "QZLoginBottomView.h"
#import "QZButton.h"
//#import "QZRegisterAndLoginHttp.h"
#import "UITextField+Length.h"
@interface QZVerifyCodeLoginController ()
<
QZLoginBottomViewDelegate,
QZCodeTextfieldViewDelegate
>
//账号输入框
@property (nonatomic,strong)QZAccountTextFieldView * accountView;
//验证码输入框
@property (nonatomic,strong)QZCodeTextfieldView    * codeView;
//登录button
@property (nonatomic,strong)QZButton               * loginButton;
@end

@implementation QZVerifyCodeLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}

#pragma mark - 登录事件
-(void)loginButtonClick{
    [self.view endEditing:YES];
    
//    NSString *telString   = [QZTool checkISNull:_accountView.text];
//    NSString * codeString = [QZTool checkISNull:_codeView.text];
//   //验证手机号是否为空
//    if (telString.length <= 0) {
//        [KDSProgressHUD showFailure:phoneISULL toView:self.view completion:^{}];
//        return;
//    }
//   //验证验证码是否为空
//    if (codeString.length <= 0) {
//        [KDSProgressHUD showFailure:codeISNull toView:self.view completion:^{}];
//        return;
//    }
//
//    //验证手机号
//    if (![RegexUitl checkTelNumber:telString]) {
//        [KDSProgressHUD showTextOnly:phoneWrong toView:self.view completion:^{}];
//        return;
//    }

//    NSDictionary * paramsDict =  @{ @"params":
//                                            @{ @"userAccount":telString,
//                                               @"code":codeString
//                                              }
//                                  };
//    __weak typeof(self)weakSelf = self;
//    [KDSProgressHUD showHUDTitle:@"正在登录..." toView:weakSelf.view];
//    [QZRegisterAndLoginHttp codeLoginWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//            [MTA trackCustomKeyValueEvent:@"a_login" props:@{}];
//
//            [QZHelperTool shareInstance].isUnToken = NO;
//            [UIApplication sharedApplication].keyWindow.rootViewController = [[QZTabBarController alloc]init];
//            //保存登录名
//            [QZTool saveAccount:telString];
//        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
//    }];


    
}

#pragma mark - QZLoginBottomViewDelegate  底部密码登录、注册账号 代理
-(void)loginBottomViewButtonType:(QLLoginButtonType)buttonType{
    switch (buttonType) {
        case button_accountLoginType:{//密码登录
//            [self.navigationController popViewControllerAnimated:YES];
            QZAccountLoginController * accountVC = [[QZAccountLoginController alloc]init];
            [self.navigationController pushViewController:accountVC animated:YES];
        }
            break;
        case button_registerAccountType: {//注册账号
            QZRegisterController * registerVC = [[QZRegisterController alloc]init];
            [self.navigationController pushViewController:registerVC animated:YES];
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
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(topLogoView.mas_bottom).mas_equalTo(30);
        make.height.mas_equalTo(45);
    }];
    
    //验证码输入框
    _codeView = [[QZCodeTextfieldView alloc]initWithTitle:@"验证码" placeholder:@"请输入验证码"];
    _codeView.delegate = self;
    [self.view addSubview:_codeView];
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeView.mas_bottom).mas_offset(50);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(44);
    }];
    
    //密码登录  注册账号 控件
    QZLoginBottomView  * loginBottomView = [[QZLoginBottomView alloc]initWithLoginType:login_VerificationCode];
    loginBottomView.delegate = self;
    [self.view addSubview:loginBottomView];
    [loginBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.loginButton);
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(35);
    }];
    
}

-(void)getCodeClick{
    
//    NSString *telString = _accountView.text;
//    
//    if (telString.length <= 0) {
//        [KDSProgressHUD showTextOnly:phoneISULL toView:self.view completion:^{}];
//        //停止定时器
//        [_codeView stopTimer];
//        return;
//    }
//    
//    //验证手机号和密码
//    if (![RegexUitl checkTelNumber:telString]) {
//        [KDSProgressHUD showTextOnly:phoneWrong toView:self.view completion:^{}];
//        //停止定时器
//        [_codeView stopTimer];
//        return;
//    }
//    
//    NSDictionary * paramsDict = @{
//                                  @"device":@"4",
//                                  @"params":
//                                      @{
//                                          @"phone":telString
//                                          }
//                                  };
//    __weak typeof(self)weakSelf = self;
//    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
//    [QZRegisterAndLoginHttp getCodeWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//            
//        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
//            
//        }];
//    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}


@end
