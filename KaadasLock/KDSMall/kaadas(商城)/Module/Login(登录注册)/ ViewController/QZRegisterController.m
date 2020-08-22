//
//  QZRegisterController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/12.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZRegisterController.h"
#import "QZAccountTextFieldView.h"
#import "QZButton.h"
#import "QZRightArrowButton.h"
#import "QZRegisterCodeController.h"
#import "QZAccountLoginController.h"
#import "QZVerifyCodeLoginController.h"
#import "QZRegisterController.h"
@interface QZRegisterController ()<UITextFieldDelegate>
//账号输入框
@property (nonatomic,strong)QZAccountTextFieldView * accountView;
//邀请码输入框
@property (nonatomic,strong)QZAccountTextFieldView * inviteCodeView;
@end

@implementation QZRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
    
}

#pragma mark - 下一步点击事件
-(void)nextButtonClick{
    
    //退出键盘
    [self.view endEditing:YES];
    
    if (_accountView.text.length < 1) {
        [self showToastError:phoneISULL];
        return;
    }
    if (![RegexUitl checkTelNumber:_accountView.text]) {
        [self showToastError:phoneWrong];
        return;
    }
    NSString * invitationCode = [KDSMallTool checkISNull:_inviteCodeView.text];

    NSDictionary * dic = @{ @"params":@{@"tel":_accountView.text,@"inviteCode":invitationCode} };
    [self submitDataWithBlock:checkPhone partemer:dic Success:^(id responseObject) {
        NSLog(@"手机号信息=%@" ,responseObject);
        __weak typeof(self)weakSelf = self;

        if ([self isSuccessData:responseObject]) {
            QZRegisterCodeController  * registercodevc = [[QZRegisterCodeController alloc]init];
            registercodevc.telString = weakSelf.accountView.text;
            registercodevc.invitationCode = weakSelf.inviteCodeView.text;
            [self.navigationController pushViewController:registercodevc animated:YES];
        }
        NSString *code = [NSString stringWithFormat:@"%@" ,[responseObject objectForKey:@"code"]];
        if ([code isEqualToString:@"600"]) {
            KDSMallAC * alert =  [KDSMallAC alertControllerWithTitle:@"" message:@"该号码已注册" okTitle:@"去登录" cancelTitle:@"重新输入" OKBlock:^{
                [weakSelf rightArrowButtonClick];
            } cancelBlock:^{
                weakSelf.accountView.text = @"";
                [weakSelf.accountView responder];
            }];
            alert.msgColor = @"#333333";
            alert.msgFont = 17.0f;

        }
    }];
    
    
}

#pragma mark - 已有账号，去登录 事件
-(void)rightArrowButtonClick{
   
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    
    
//        QZAccountLoginController * accountLoging = [[QZAccountLoginController alloc]init];
//        NSMutableArray  * viewControllers = [NSMutableArray array];
//
//        [viewControllers addObject:accountLoging];
//
//        [viewControllers addObject:[self.navigationController.viewControllers lastObject]];
//        self.navigationController.viewControllers = (NSArray *)viewControllers;
    
//    NSArray * viewControllers = self.navigationController.viewControllers;
//    NSMutableArray * newViewControllers = [NSMutableArray array];
//
//    for (KDSBaseController * vc in viewControllers) {
//        if ([vc isKindOfClass:[QZAccountLoginController class]]) {
//            [newViewControllers addObject:[viewControllers lastObject]];
//            break;
//        }else{
//            [newViewControllers addObject:vc];
//        }
//    }
//    self.navigationController.viewControllers = newViewControllers;
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toString.length > 0) {
        NSString *stringRegex = @"([0-9]\\d{0,7})?";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        BOOL flag = [phoneTest evaluateWithObject:toString];
        if (!flag) {
            return NO;
        }
    }
    
    return YES;
}
#pragma mark - 创建UI
-(void)createUI{
    
    //    self.jz_navigationBarHidden = NO;
    self.navigationBarView.backTitle = @"注册";
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
    //账号输入框
    _accountView = [[QZAccountTextFieldView alloc]initWithTitle:@"手机号" placeholder:@"请输入手机号码"];
    _accountView.maxCharacters = 11;
//    _accountView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FAFAFA"];
    [self.view addSubview:_accountView];
    _accountView.keyBoardType = UIKeyboardTypeNumberPad;
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(45);
    }];
    
    //邀请码输入框
    _inviteCodeView = [[QZAccountTextFieldView alloc]initWithTitle:@"邀请码" placeholder:@"请输入邀请码（选填）"];
    _inviteCodeView.textField.delegate = self;
    _inviteCodeView.maxCharacters = 8;
    _inviteCodeView.keyBoardType =  UIKeyboardTypeNumberPad;
//    _inviteCodeView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FAFAFA"];
    [self.view addSubview:_inviteCodeView];
    [_inviteCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.accountView);
        make.top.mas_equalTo(self.accountView.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(self.accountView.mas_height);
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
        make.top.mas_equalTo(self.inviteCodeView.mas_bottom).mas_offset(40);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(44);
    }];
    
    //已有账号，去登录  button
    QZRightArrowButton * rightArrowButton = [QZRightArrowButton buttonWithType:UIButtonTypeCustom];
    [rightArrowButton addTarget:self action:@selector(rightArrowButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightArrowButton];
    [rightArrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(nextButton.mas_right).mas_offset(-00);
        make.top.mas_equalTo(nextButton.mas_bottom).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(170, 35));
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}




-(void)backButtonClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[QZRegisterController class]]) {
            [controller dismissViewControllerAnimated:YES completion:^{
            }];
        }
    }
    
}





@end
