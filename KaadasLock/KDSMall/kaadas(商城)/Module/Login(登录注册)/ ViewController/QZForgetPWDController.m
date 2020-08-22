//
//  QZForgetPWDController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZForgetPWDController.h"
#import "QZForgetPWDCodeController.h"
#import "QZRegisterController.h"
//#import "QZAlertController.h"
#import "QZAccountTextFieldView.h"
#import "QZButton.h"

//#import "QZRegisterAndLoginHttp.h"


@interface QZForgetPWDController ()
//账号输入框
@property (nonatomic,strong)QZAccountTextFieldView * accountView;
//下一步button
@property (nonatomic,strong)QZButton               * nextButton;
@end

@implementation QZForgetPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建UI
    [self createUI];
}
#pragma mark - 下一步点击事件
-(void)nextButtonClick{
    //退出键盘
    [self.view endEditing:YES];

//    //账号
//    NSString * telString = [QZTool checkISNull:_accountView.text];
//    //验证手机号是否为空
//    if (telString.length <= 0) {
//        [KDSProgressHUD showTextOnly:phoneISULL toView:self.view completion:^{}];
//        return;
//    }
//    //验证是否为手机号手机号
//    if (![RegexUitl checkTelNumber:telString]) {
//        [KDSProgressHUD showTextOnly:phoneWrong toView:self.view completion:^{}];
//        return;
//    }
//
//    NSDictionary * paramsDict = @{@"params":
//                                      @{@"tel":telString,
//                                          @"inviteCode":@"" //(选填)(string) 邀请码(邀请码为8位系统生成的数字)
//                                          }
//                                  };
//    __weak typeof(self)weakSelf = self;
//    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
//
//    [QZRegisterAndLoginHttp forgetCheckTelWith:paramsDict success:^(NSInteger code, BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//                QZForgetPWDCodeController  * forgetPWDCodeVC = [[QZForgetPWDCodeController alloc]init];
//                forgetPWDCodeVC.telString = telString;
//                [self.navigationController pushViewController:forgetPWDCodeVC animated:YES];
//        }else{
//            if (code == 604) {
//                QZAlertController * alertVC = [QZAlertController alertControllerWithTitle:@"" message:@"该手机号还未注册" okTitle:@"去注册" cancelTitle:@"重新输入" OKBlock:^{
//
//                    QZRegisterController * registerVC = [[QZRegisterController alloc]init];
//                    [weakSelf.navigationController pushViewController:registerVC animated:YES];
//                } cancelBlock:^{
//
//                }];
//                alertVC.msgColor = @"#F36A5F";
//                alertVC.msgFont = 17.0;
//            }else{
//                [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
//            }
//
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
//    }];
    
//    [QZRegisterAndLoginHttp regesterCheckPhoneWithParams:paramsDict success:^(NSInteger code, BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//            QZAlertController * alertVC = [QZAlertController alertControllerWithTitle:@"" message:@"该手机号还未注册" okTitle:@"去注册" cancelTitle:@"重新输入" OKBlock:^{
//
//                QZRegisterController * registerVC = [[QZRegisterController alloc]init];
//                [weakSelf.navigationController pushViewController:registerVC animated:YES];
//            } cancelBlock:^{
//
//            }];
//            alertVC.msgColor = @"#F36A5F";
//            alertVC.msgFont = 17.0;
//        }else{
//            if (code == 600) {
//                QZForgetPWDCodeController  * forgetPWDCodeVC = [[QZForgetPWDCodeController alloc]init];
//                forgetPWDCodeVC.telString = telString;
//                [self.navigationController pushViewController:forgetPWDCodeVC animated:YES];
//            }else{
//                [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
//            }
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
//    }];
    
    
    
}

#pragma mark - 创建UI
-(void)createUI{
//    self.jz_navigationBarHidden = NO;
    self.navigationBarView.backTitle = @"忘记密码";
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    //账号输入框
    _accountView = [[QZAccountTextFieldView alloc]initWithTitle:@"手机号" placeholder:@"请输入注册手机号"];
    _accountView.maxCharacters = 11;
    [self.view addSubview:_accountView];
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(40);
    }];
    
    //下一步button
    _nextButton = [QZButton buttonWithType:UIButtonTypeCustom];
    [_nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    _nextButton.enabled = NO;
//    _nextButton.alpha = 0.6;
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:_nextButton];
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.accountView.mas_bottom).mas_offset(50);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(44);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
@end
