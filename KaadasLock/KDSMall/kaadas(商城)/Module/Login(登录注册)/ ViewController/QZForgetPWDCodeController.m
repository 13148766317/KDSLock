//
//  QZForgetPWDCodeController.m
//  test
//
//  Created by baohong on 19/3/14.
//  Copyright © 2019年 baohong. All rights reserved.
//

#import "QZForgetPWDCodeController.h"
#import "QZNewPWDController.h"

//#import "QZRegisterAndLoginHttp.h"
#import "QZCodeTextfieldView.h"
#import "QZNewPWDController.h"
#import "QZButton.h"

@interface QZForgetPWDCodeController ()<QZCodeTextfieldViewDelegate>
@property (nonatomic,strong)QZCodeTextfieldView * codeView;
@end

@implementation QZForgetPWDCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}
#pragma mark - 获取验证码
-(void)getCodeClick{
    
   
//    NSDictionary * paramsDict = @{
//                                  @"device":@"4",
//                                  @"params":@{@"phone":[KDSMallTool checkISNull:_telString]}
//                                  };
//    __weak typeof(self)weakSelf = self;
//    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
//    [QZRegisterAndLoginHttp getCodeWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//
//        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{
//                [weakSelf.codeView stopTimer];
//            }];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
//            [weakSelf.codeView stopTimer];
//        }];
//    }];
}
#pragma mark - 下一步事件
-(void)nextButtonClick{
    [self.view endEditing:YES];

    
//    NSString * telSrting = [KDSMallTool checkISNull:_telString];
//    NSString * codeString = [KDSMallTool checkISNull:_codeView.text];
//
//    if (codeString.length <= 0) {
//        [KDSProgressHUD showTextOnly:codeISNull toView:self.view completion:^{}];
//        return;
//    }
//    NSDictionary * paramsDict = @{
//                                  @"params":
//                                      @{
//                                          @"tel":telSrting,
//                                          @"code":codeString
//                                          }
//                                  };
//    __weak typeof(self)weakSelf = self;
//    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
//    [QZRegisterAndLoginHttp forgetCheckCodeWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//            QZNewPWDController * pwdVC = [[QZNewPWDController alloc]init];
//            pwdVC.telString = weakSelf.telString;
//            [self.navigationController pushViewController:pwdVC animated:YES];
//        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
//    }];
//    [QZRegisterAndLoginHttp registerCheckCodeWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//            QZNewPWDController * pwdVC = [[QZNewPWDController alloc]init];
//            pwdVC.telString = weakSelf.telString;
//            [self.navigationController pushViewController:pwdVC animated:YES];
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
    UILabel * titleNamelabel = [KDSMallTool createLabelString:@"接收验证码手机" textColorString:@"#9E9E9E" font:12];
    [self.view addSubview:titleNamelabel];
    [titleNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(30);
    }];
    
    //手机号
    UILabel * phoneLabel = [KDSMallTool createbBoldLabelString:[self cuttingTelPhone:_telString] textColorString:@"#212121" font:20];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(titleNamelabel.mas_bottom).mas_offset(15);
    }];
    
    //分割底线
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    lineView.layer.cornerRadius = 1;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).mas_offset(15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(30, 2));
    }];
    
    //验证码输入框
    _codeView = [[QZCodeTextfieldView alloc]initWithTitle:@"验证码" placeholder:@"请输入验证码"];
//    _codeView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FAFAFA"];
    _codeView.delegate = self;
    [self.view addSubview:_codeView];
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.top.mas_equalTo(lineView.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(40);
    }];
    
    //下一步button
    QZButton * nextButton = [QZButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    nextButton.enabled = NO;
    //    nextButton.alpha = 0.5;
    [self.view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeView.mas_bottom).mas_offset(40);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(44);
    }];
    
    
    //进入页面就发送验证码
    [_codeView getCodeButtonClick];
}


-(NSString *)cuttingTelPhone:(NSString *)string{
    if (string.length < 11) {
        return string;
    }else{
        return [NSString stringWithFormat:@"%@  %@  %@",[_telString substringToIndex:3],[_telString substringWithRange:NSMakeRange(3, 4)],[_telString substringFromIndex:7]];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
@end
