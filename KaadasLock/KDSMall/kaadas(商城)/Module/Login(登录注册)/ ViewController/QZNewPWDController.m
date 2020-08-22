//
//  QZNewPWDController.m
//  test
//
//  Created by baohong on 19/3/14.
//  Copyright © 2019年 baohong. All rights reserved.
//

#import "QZNewPWDController.h"
#import "QZPWDTextfildview.h"
#import "QZButton.h"

//#import "QZRegisterAndLoginHttp.h"

@interface QZNewPWDController ()
//设置密码
@property (nonatomic,strong)QZPWDTextfildview * pwdTextfieldView;
//确认密码
@property (nonatomic,strong)QZPWDTextfildview * validationPWDView;
@end

@implementation QZNewPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建UI
    [self createUI];
}

-(void)OKButtonClick{
    
    [self.view endEditing:YES];
    
//    NSString * telString = [KDSMallTool checkISNull:_telString];
    NSString * password = [KDSMallTool checkISNull:_pwdTextfieldView.text];
    NSString * confirmPassword = [KDSMallTool checkISNull:_validationPWDView.text];
    //判断设置密码是否为空
//    if (password.length <= 0) {
//        [KDSProgressHUD showTextOnly:newPassWordIsNull toView:self.view completion:^{}];
//        return;
//    }
//    //判断确认密码是否为空
//    if (confirmPassword.length <= 0) {
//        [KDSProgressHUD showTextOnly:confirmPWDIsNull toView:self.view completion:^{}];
//        return;
//    }
//    //判断新密码和确认密码是否一致
//    if (![password isEqualToString:confirmPassword]) {
//        [KDSProgressHUD showTextOnly:newPWDNotSame toView:self.view completion:^{}];
//        return;
//    }
//    //验证新密码格式与位数
//    if (![RegexUitl checkPassword:password]) {
//        [KDSProgressHUD showTextOnly:passwordWrong toView:self.view completion:^{}];
//        return;
//    }
//    
//    //验证确认密码格式与位数
//    if (![RegexUitl checkPassword:confirmPassword]) {
//        [KDSProgressHUD showTextOnly:passwordWrong toView:self.view completion:^{}];
//        return;
//    }
//    
//    __weak typeof(self)weakSelf = self;
//    NSDictionary * dictParams = @{@"params":
//                                        @{
//                                            @"tel":_telString,  //(必填)(string) 手机号码
//                                            @"confirmPassword":confirmPassword,      //(必填)(string)确认密码
//                                            @"password":password   //(必填)(string)密码
//                                        }
//                                  };
//    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
//    [QZRegisterAndLoginHttp forgetPasswordWithParams:dictParams success:^(BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//            NSArray * viewControlls = self.navigationController.viewControllers;
//            NSLog(@"%@",viewControlls);
//            NSMutableArray * newVC = [NSMutableArray arrayWithObjects:viewControlls[0],viewControlls[1],viewControlls[2],[viewControlls lastObject], nil];
//            self.navigationController.viewControllers = (NSArray *)(newVC);
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
//    }];
    
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"忘记密码";
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    //设置密码
    _pwdTextfieldView = [[QZPWDTextfildview alloc]initWithTitle:@"  新密码" placeholder:@"请设置新登录密码"];
    _pwdTextfieldView.openPassword = NO;
    [self.view addSubview:_pwdTextfieldView];
    [_pwdTextfieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(40);
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
    QZButton * OKButton = [QZButton buttonWithType:UIButtonTypeCustom];
    [OKButton setTitle:@"确认" forState:UIControlStateNormal];
    OKButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [OKButton addTarget:self action:@selector(OKButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    OKButton.enabled = NO;
//    OKButton.alpha = 0.5f;
    [self.view addSubview:OKButton];
    [OKButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
