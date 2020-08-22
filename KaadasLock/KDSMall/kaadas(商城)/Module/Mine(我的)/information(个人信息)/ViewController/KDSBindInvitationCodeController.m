//
//  QZBindInvitationCodeController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/23.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "KDSBindInvitationCodeController.h"
#import "QZInvitationTextFieldView.h"
#import "QZButton.h"
#import "KDSMineHttp.h"

@interface KDSBindInvitationCodeController ()<UITextFieldDelegate>
//输入框控件
@property (nonatomic,strong)QZInvitationTextFieldView * invitationTextfield;
@end

@implementation KDSBindInvitationCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}

#pragma mark - 绑定点击事件
-(void)bindButtonClick{
    
    [self.view endEditing:YES];
    
    //邀请码
    NSString * invitationString = [KDSMallTool checkISNull:_invitationTextfield.text];
    
    //验证邀请码是否为空
    if (invitationString.length <= 0) {
        [KDSProgressHUD showTextOnly:invitationISNull toView:self.view completion:^{}];
        return;
    }

    QZUserModel *userModel = [QZUserArchiveTool loadUserModel];
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    //判断是否绑定自己的邀请码
    if ([invitationString isEqualToString:[KDSMallTool checkISNull:userModel.randomCode]]) {
//        [QZBindAlertController bindAlertControllerWithTitle:@"" message:" AlertType:QZAlertTitleImageType];
        [KDSProgressHUD showTextOnly:@"该邀请码专用于你本人邀请其他新用户使用，本人不可绑定自己！请重新输入。" toView:self.view completion:^{
            
        }];
        return;
    }
    
    NSDictionary * paramsDict = @{@"params":@{@"inviteCode":[KDSMallTool checkISNull:invitationString] },  //邀请码
                                   @"token":[KDSMallTool checkISNull:userToken]
                                  };
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    
    [KDSMineHttp binginviteCodeWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            [KDSProgressHUD showTextOnly:@"邀请码绑定成功" toView:weakSelf.view completion:^{
                [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - 创建UI
-(void)createUI{
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F8F8F8"];
    self.navigationBarView.backTitle = @"绑定邀请码";
    
    //输入框控件
     _invitationTextfield = [[QZInvitationTextFieldView alloc]initWithTitle:@"邀请码" placeholder:@"请输入邀请码" linePositon:QZDividingLine_ALL];
    _invitationTextfield.textField.delegate = self;
    [self.view addSubview:_invitationTextfield];
    [_invitationTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(25);
        make.height.mas_equalTo(50);
    }];
    
//    //描述
//    UILabel * detailLabel = [KDSMallTool createLabelString:@"*填写邀请码，购买VIP即可享受365元/年的特权优惠活动" textColorString:@"#F36A5F" font:12];
//    detailLabel.numberOfLines = 0;
//    [self.view addSubview:detailLabel];
//    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo(self.invitationTextfield.mas_bottom).mas_offset(10);
//
//    }];
    
    //绑定button
    QZButton * bindButton = [QZButton buttonWithType:UIButtonTypeCustom];
    [bindButton addTarget:self action:@selector(bindButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bindButton setTitle:@"绑定" forState:UIControlStateNormal];
    [self.view addSubview:bindButton];
    [bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(self.invitationTextfield.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(44);
    }];
    
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;


}
@end
