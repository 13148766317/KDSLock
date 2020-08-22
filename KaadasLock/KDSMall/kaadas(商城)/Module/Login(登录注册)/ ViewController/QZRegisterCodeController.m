//
//  QZRegisterCodeController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZRegisterCodeController.h"
#import "QZRegisterPWDController.h"
#import "QZCodeTextfieldView.h"
#import "QZButton.h"

@interface QZRegisterCodeController ()<QZCodeTextfieldViewDelegate>
@property (nonatomic,strong)QZCodeTextfieldView * codeView;
@end

@implementation QZRegisterCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}

-(void)nextButtonClick{

    [self.view endEditing:YES];
    
    if (_codeView.text.length < 1) {
        [self showToastError:codeISNull];
        return;
    }
    NSDictionary * dic = @{ @"params":@{@"tel":self.telString,@"code":_codeView.text} };
    [self submitDataWithBlock:checkCode partemer:dic Success:^(id responseObject) {
        NSLog(@"验证码信息=%@" ,responseObject);
        if ([self isSuccessData:responseObject]) {
            NSString *token = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"token"]];
            [userDefaults setObject:token forKey:USER_TOKEN];
           [userDefaults synchronize];
            QZRegisterPWDController * pwdVC = [[QZRegisterPWDController alloc]init];
            pwdVC.aToken = token;
            pwdVC.telString = self.telString;
//            pwdVC.codeString = self.codeView.text;
//            pwdVC.invitationCode = self.invitationCode;
            [self.navigationController pushViewController:pwdVC animated:YES];
        }
    }];


}
-(NSString *)cuttingTelPhone:(NSString *)string{
    if (string.length < 11) {
        return string;
    }else{
        return [NSString stringWithFormat:@"%@  %@  %@",[_telString substringToIndex:3],[_telString substringWithRange:NSMakeRange(3, 4)],[_telString substringFromIndex:7]];
    }
}

#pragma mark - 创建UI
-(void)createUI{

    self.navigationBarView.backTitle = @"注册";
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
    
    UILabel * titleNamelabel = [KDSMallTool createLabelString:@"接收验证码手机" textColorString:@"#9E9E9E" font:12];
    [self.view addSubview:titleNamelabel];
    [titleNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(30);
    }];
  
    //手机号
    UILabel * phoneLabel = [KDSMallTool createbBoldLabelString:[self cuttingTelPhone:_telString] textColorString:@"#212121" font:18];
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
    self.codeView.delegate = self;
//    _codeView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FAFAFA"];
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

-(void)getCodeClick{
    
    NSDictionary * dic = @{ @"params":@{@"tel":self.telString} };
    [self submitDataWithBlock:getCode partemer:dic Success:^(id responseObject) {
        NSLog(@"验证码信息=%@" ,responseObject);
        
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
@end
