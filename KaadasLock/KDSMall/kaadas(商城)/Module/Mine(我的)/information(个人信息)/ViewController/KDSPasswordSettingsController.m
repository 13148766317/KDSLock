//
//  KDSPasswordSettingsController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSPasswordSettingsController.h"
#import "KDSPWDTextView.h"
#import "KDSMineHttp.h"


@interface KDSPasswordSettingsController ()
@property (nonatomic,strong)UIScrollView   * scrollView;
@property (nonatomic,strong)UIView   * svContentView;
//原密码
@property (nonatomic,strong)KDSPWDTextView   * oldPwdTextView;
//新密码
@property (nonatomic,strong)KDSPWDTextView   * NewPWDTextView;
//确认密码
@property (nonatomic,strong)KDSPWDTextView   * comfirmTextView;
@end

@implementation KDSPasswordSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建UI
    [self createUI];
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"密码设置";
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.right.bottom.left.mas_equalTo(self.view);
    }];
    
    
    _svContentView = [[UIView alloc]init];
    _svContentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
    [_scrollView addSubview:_svContentView];
    [_svContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(KSCREENWIDTH);
        make.height.mas_equalTo(1000);
    }];
    
    //原密码
    _oldPwdTextView = [[KDSPWDTextView alloc]initWithTitle:@"原密码" palceHolder:@"填写原密码"];
    [_svContentView addSubview:_oldPwdTextView];
    [_oldPwdTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(65);
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(-15);
    }];
    
    //新密码
    _NewPWDTextView = [[KDSPWDTextView alloc]initWithTitle:@"新密码" palceHolder:@"填写新密码"];
    [_svContentView addSubview:_NewPWDTextView];
    [_NewPWDTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.oldPwdTextView);
        make.top.mas_equalTo(self.oldPwdTextView.mas_bottom).mas_offset(20);
    }];
    
    //确认密码
    _comfirmTextView = [[KDSPWDTextView alloc]initWithTitle:@"确认密码" palceHolder:@"再次确认密码"];
    [_svContentView addSubview:_comfirmTextView];
    [_comfirmTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.NewPWDTextView);
        make.top.mas_equalTo(self.NewPWDTextView.mas_bottom).mas_offset(20);
    }];
    
    
    UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [okButton setTitle:@"完 成" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    okButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    [_svContentView addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.comfirmTextView.mas_bottom).mas_offset(70);
    }];
    
    [_svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(KSCREENWIDTH);
        make.bottom.mas_equalTo(okButton.mas_bottom).mas_offset(50);
    }];
    
    
}

-(void)okButtonClick{
      //原密码
    //新密码
    NSString * password = [KDSMallTool checkISNull:_NewPWDTextView.text];
    //确认密码
    NSString * confirmPassword = [KDSMallTool checkISNull:_comfirmTextView.text];
    //判断设置密码是否为空
    if (password.length <= 0) {
        [KDSProgressHUD showTextOnly:newPassWordIsNull toView:self.view completion:^{}];
        return;
    }
    //判断确认密码是否为空
    if (confirmPassword.length <= 0) {
        [KDSProgressHUD showTextOnly:confirmPWDIsNull toView:self.view completion:^{}];
        return;
    }
    //判断新密码和确认密码是否一致
    if (![password isEqualToString:confirmPassword]) {
        [KDSProgressHUD showTextOnly:newPWDNotSame toView:self.view completion:^{}];
        return;
    }
    //验证新密码格式与位数
    if (![RegexUitl checkPassword:password]) {
        [KDSProgressHUD showTextOnly:passwordWrong toView:self.view completion:^{}];
        return;
    }

    //验证确认密码格式与位数
    if (![RegexUitl checkPassword:confirmPassword]) {
        [KDSProgressHUD showTextOnly:passwordWrong toView:self.view completion:^{}];
        return;
    }
    
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * dictionaryParam = @{@"params":@{
                                                   @"oldPassword":[KDSMallTool checkISNull:_oldPwdTextView.text],   //(选填)(string) 旧密码
                                                   @"newPassword":[KDSMallTool checkISNull:_NewPWDTextView.text]    //(必填)(string)新密码
                                                  },
                                        @"token":[KDSMallTool checkISNull:userToken]
                                       };
    
    
    __weak typeof(self)weakSelf = self;
    [KDSMineHttp setPassWordWithParams:dictionaryParam success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            [KDSProgressHUD showTextOnly:@"密码修改成功" toView:weakSelf.view completion:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{
                
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}


@end
