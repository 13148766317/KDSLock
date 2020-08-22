//
//  WxLoginController.m
//  kaadas
//
//  Created by Apple on 2019/6/18.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "WxLoginController.h"
#import "CustomBtn.h"
#import "KDSBindingPhoneNumController.h"
#import "KDSMineHttp.h"
#import "QZAccountLoginController.h"
//#import "JPUSHService.h"

@interface WxLoginController ()
@property (nonatomic,strong)UIButton  * phoneLoginButton;
@property (nonatomic,strong)UILabel   * label1;
@end

@implementation WxLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([HelperTool shareInstance].isUpload) {
        self.navigationBarView.backTitle = @"登录";
    }else{
        self.navigationBarView.backTitle = @"微信登录";
    }

    UIImageView *logov = [[UIImageView alloc]init];
    logov.image = [UIImage imageNamed:@"logo_kaadas_login"];
    [self.view addSubview:logov];
    [logov mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(110);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIImageView *kdsv = [[UIImageView alloc]init];
    kdsv.image = [UIImage imageNamed:@"kaadass"];
    [self.view addSubview:kdsv];
    [kdsv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logov.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(121, 20));
        make.centerX.mas_equalTo(self.view);
    }];
                                                                                                    //- 60
    UIButton *btn = [[CustomBtn alloc]initWithBtnFrame:CGRectMake((KSCREENWIDTH-270)/2,KSCREENHEIGHT-44-59 , 270, 44) btnType:ButtonImageLeft titleAndImageSpace:10 imageSizeWidth:25 imageSizeHeight:21];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(wxloginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxAuthSuccess:) name:@"微信授权成功" object:nil];
    
    if ([HelperTool shareInstance].isUpload) {
        [btn setTitle:@"手机号码登录" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    }else{
        [btn setTitle:@"微信一键登录" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"logo_wechat_login"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#2DBE45"];
    }

    
//    CGFloat loginTextFont = 15.0f;
//    _phoneLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _phoneLoginButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
//    [_phoneLoginButton setTitle:@"手机号码登录" forState:UIControlStateNormal];
//    [_phoneLoginButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"ffffff"] forState:UIControlStateNormal];
//    _phoneLoginButton.titleLabel.font = [UIFont systemFontOfSize:loginTextFont];
//    [self.view addSubview:_phoneLoginButton];
//    [_phoneLoginButton addTarget:self action:@selector(phoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    _phoneLoginButton.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMinY(btn.frame) - 80, CGRectGetWidth(btn.frame), 44);
//
//
//    _label1 = [KDSMallTool createLabelString:@"或" textColorString:@"666666" font:18];
//    _label1.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_label1];
//    _label1.frame = CGRectMake(CGRectGetMinX(_phoneLoginButton.frame), CGRectGetMaxY(_phoneLoginButton.frame), CGRectGetWidth(_phoneLoginButton.frame), CGRectGetMinY(btn.frame)  - CGRectGetMaxY(_phoneLoginButton.frame));

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if ([HelperTool shareInstance].isUpload) {
//        _phoneLoginButton.hidden = NO;
//        _label1.hidden = NO;
//    }else{
//        _phoneLoginButton.hidden = YES;
//        _label1.hidden = YES;
//    }
}


#pragma mark - 登陆事件
-(void)phoneButtonClick{}

-(void)backButtonClick{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)wxloginAction{
    
    if ([HelperTool shareInstance].isUpload) {
        [HelperTool shareInstance].isHomeCoupon = YES;
        [self dismissViewControllerAnimated:YES completion:^{}];
        
        QZAccountLoginController * loginvc = [[QZAccountLoginController alloc]init];
        KDSTabBarController * tableBarVC = [HelperTool shareInstance].tableBarVC;
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableBarVC presentViewController:loginvc animated:YES completion:^{}];
        });
    }else{
        if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
            req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
            [WXApi sendReq:req];//发起微信授权请求
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请安装微信客户端" preferredStyle: UIAlertControllerStyleAlert];
            [alert addAction:[ UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alert animated:true completion:nil];
        }
    }
}

-(void)wxAuthSuccess:(NSNotification *)notic{
    NSString *wxAuthCode = [notic.object objectForKey:@"wxAuthCode"];
    NSDictionary * params = @{@"params":@{@"code":wxAuthCode}};
    [JavaNetClass JavaNetRequestWithPort:@"wxApp/login" andPartemer:params Success:^(id responseObject) {
        NSLog(@"微信openid获取结果=%@" ,responseObject);
        if ([self isSuccessData:responseObject]) {
            
            NSString *atoken = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"token"]];
            [userDefaults setObject:atoken forKey:USER_TOKEN];
            [userDefaults synchronize];
            
            if (self.loginBlock) {
                self.loginBlock();
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HOME_REFRESH_NOTIFICATION object:nil];
            NSString *tel = [KDSMallTool checkISNull: [[[responseObject objectForKey:@"data"] objectForKey:@"customer"] objectForKey:@"tel"]];
            if (tel.length <= 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self bangAction];
                });
            }else{
                //修改本地f缓存
                QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
                userModel.tel = [KDSMallTool checkISNull:tel];
                [QZUserArchiveTool saveUserModelWithMode:userModel];
//
                NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
                NSDictionary * dictionary = @{
                                              @"params":@{},
                                              @"token":[KDSMallTool checkISNull:userToken]
                                              };
                //获取用户详情
                [KDSMineHttp mineInfoWithParams:dictionary  success:^(BOOL isSuccess, id  _Nonnull obj) {
                   
                } failure:^(NSError * _Nonnull error) {
                    
                }];
                
                //推送
//                //移除所有tag
//                [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//                    NSLog(@"删除tag");
//                    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
//                    NSLog(@"tellll:%@",userModel.tel);
//                    //如果有绑定手机号添加tag
//                    if ([KDSMallTool checkISNull:userModel.tel].length > 0 ) {
//                        [JPUSHService addTags:[NSSet setWithObjects:[KDSMallTool checkISNull:userModel.tel], nil] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//                            NSLog(@"添加tag");
//                        } seq:0];
//                    }
//                } seq:0];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.navigationController.viewControllers.count > 1) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
//                        NSLog(@"viewControllers:%@",self.navigationController.viewControllers);
//                        NSArray * viewControllers = self.navigationController.viewControllers;
//                        if (viewControllers.count > 0) {
//                                [UIApplication sharedApplication].keyWindow.rootViewController = [[KDSTabBarController alloc]init];
//                        }else{
                            [self dismissViewControllerAnimated:YES completion:^{}];
//                        }
                    }
                });
            }
        }else{
            [self showToastError:[NSString stringWithFormat:@"%@" ,[responseObject objectForKey:@"msg"]]];
        }
    }];
    
}

-(void)bangAction{
    [HelperTool shareInstance].isHomeCoupon = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    KDSBindingPhoneNumController  * registerController = [[KDSBindingPhoneNumController alloc]init];
    KDSTabBarController * tableBarVC = [HelperTool shareInstance].tableBarVC;
    dispatch_async(dispatch_get_main_queue(), ^{
        [tableBarVC presentViewController:registerController animated:YES completion:^{
            
        }];
    });
    

}

@end
