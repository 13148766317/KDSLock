//
//  QZRegisterPWDController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZRegisterPWDController.h"
#import "QZPWDTextfildview.h"
#import "QZButton.h"
#import "KDSTabBarController.h"

@interface QZRegisterPWDController ()
//设置密码
@property (nonatomic,strong)QZPWDTextfildview * pwdTextfieldView;
//确认密码
@property (nonatomic,strong)QZPWDTextfildview * validationPWDView;
@end

@implementation QZRegisterPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}

#pragma mark - 跳过事件
-(void)skipButtonClick{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[KDSTabBarController alloc]init];
}

#pragma mark - 注册 事件
-(void)registerButton{
    
    [self.view endEditing:YES];
    
    if (_pwdTextfieldView.text.length < 1) {
        [self showToastError:setPasswordIsNull];
        return;
    }

    if (![RegexUitl checkPassword:_pwdTextfieldView.text]) {
        [self showToastError:passwordWrong];
        return;
    }

    if (_validationPWDView.text.length < 1) {
        [self showToastError:confirmPasswordIsNull];
        return;
    }

    if ( ![_pwdTextfieldView.text isEqualToString:_validationPWDView.text]) {
        [self showToastError:passwordNotSame];
        return;
    }
    NSDictionary * dic = @{ @"params":@{@"password":_pwdTextfieldView.text} ,@"token":self.aToken};
        [self submitDataWithBlock:setPassword partemer:dic Success:^(id responseObject) {
            NSLog(@"注册信息=%@" ,responseObject);
            if ([self isSuccessData:responseObject]) {
                [self  beginLogin];
            }
        }];
    
    
}

-(void)beginLogin{
    NSDictionary * dic = @{@"params":@{ @"userAccount":self.telString, @"password":_pwdTextfieldView.text} };
    [self submitDataWithBlock:passwordLogin partemer:dic Success:^(id responseObject) {
        NSLog(@"登录信息=%@" ,responseObject);
        if ([self isSuccessData:responseObject]) {
            NSString *atoken = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"token"]];
            [userDefaults setObject:atoken forKey:USER_TOKEN];
             [userDefaults synchronize];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[KDSTabBarController alloc]init];
        }
    }];
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"注册";
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
    //跳过
    UIButton * skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.frame = CGRectMake(0, 0, 45, 44);
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [skipButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#3C8AF3"] forState:UIControlStateNormal];
    skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    UIBarButtonItem * skipItem = [[UIBarButtonItem alloc]initWithCustomView:skipButton];
    [skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = skipItem;
    self.navigationBarView.rightItem = skipButton;
    
    
    //设置密码
    _pwdTextfieldView = [[QZPWDTextfildview alloc]initWithTitle:@"设置密码" placeholder:@"请设置登录密码"];
    _pwdTextfieldView.openPassword = NO;
    [self.view addSubview:_pwdTextfieldView];
    [_pwdTextfieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
//        make.top.mas_equalTo(35);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(35);
        make.height.mas_equalTo(45);
    }];
    
    //确认密码
    _validationPWDView = [[QZPWDTextfildview alloc]initWithTitle:@"确认密码" placeholder:@"再次输入密码以确认"];
    _validationPWDView.openPassword = NO;
    [self.view addSubview:_validationPWDView];
    [_validationPWDView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.pwdTextfieldView);
        make.top.mas_equalTo(self.pwdTextfieldView.mas_bottom).mas_offset(25);
        make.height.mas_equalTo(self.pwdTextfieldView.mas_height);
    }];
    
    
    //注册button
    QZButton * registerButton = [QZButton buttonWithType:UIButtonTypeCustom];
    [registerButton addTarget:self action:@selector(registerButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    registerButton.enabled = NO;
//    registerButton.alpha = 0.5f;
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.pwdTextfieldView);
        make.top.mas_equalTo(self.validationPWDView.mas_bottom).mas_offset(50);
        make.height.mas_equalTo(44);
    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
@end
