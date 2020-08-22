//
//  KDSBindingPhoneNumController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/15.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBindingPhoneNumController.h"
#import "KDSPWDTextView.h"
#import "KDSMineHttp.h"
//#import <JPUSHService.h>

@interface KDSBindingPhoneNumController ()
@property (nonatomic,strong)UIScrollView   * scrollView;
@property (nonatomic,strong)UIView   * svContentView;
//手机
@property (nonatomic,strong)KDSPWDTextView   * phoneTextView;
//验证码
@property (nonatomic,strong)KDSPWDTextView   * verificationCodeView;
//获取验证码button
@property (nonatomic,strong)UIButton          * getCodeButton;
//倒计时的最大秒数
@property (nonatomic,assign)NSInteger         allSeconds;
//定时器
@property (nonatomic,strong)NSTimer          * timer;

@end

@implementation KDSBindingPhoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    //创建UI
    [self createUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HelperTool shareInstance].isHomeCoupon = NO;
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"绑定手机";
    
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
    
    //手机号
    _phoneTextView = [[KDSPWDTextView alloc]initWithTitle:@"手机" palceHolder:@"填写手机号"];
    [_phoneTextView.textField setMaxLen:11];
    [_svContentView addSubview:_phoneTextView];
    [_phoneTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(65);
        make.height.mas_equalTo(50);
    }];
    
    
    //验证码
    _verificationCodeView = [[KDSPWDTextView alloc]initWithTitle:@"验证码" palceHolder:@"填写验证码"];
    [_svContentView addSubview:_verificationCodeView];
    [_verificationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.mas_equalTo(self.phoneTextView);
        make.top.mas_equalTo(self.phoneTextView.mas_bottom).mas_offset(20);
        make.right.mas_equalTo(-100);
    }];
    
    
    UIView * dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
    [_scrollView addSubview:dividingView];
    [dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.verificationCodeView);
        make.height.mas_equalTo(dividinghHeight);
        make.right.mas_equalTo(self.phoneTextView.mas_right);
    }];
    
    //验证码button
    CGFloat getCodeButtonH = 30;
    _getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getCodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_getCodeButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#ca2128"] forState:UIControlStateNormal];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    //边框
    _getCodeButton.layer.cornerRadius = getCodeButtonH / 2;
    _getCodeButton.layer.masksToBounds = YES;
    _getCodeButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"].CGColor;
    _getCodeButton.layer.borderWidth = 0.7;
    //添加事件
    [_getCodeButton addTarget:self action:@selector(getCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_svContentView addSubview:_getCodeButton];
    [_getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.verificationCodeView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, getCodeButtonH));
    }];
    
    //确定button
    UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    okButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [okButton setTitle:@"确 定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_svContentView addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.verificationCodeView.mas_bottom).mas_offset(70);
    }];
    
    [_svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(KSCREENWIDTH);
        make.bottom.mas_equalTo(okButton.mas_bottom).mas_offset(50);
    }];
}

#pragma mark - 确定点击事件
-(void)okButtonClick{
  
    [self.view endEditing:NO];
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
  
    //验证手机号
    if (_phoneTextView.textField.text.length <= 0) {
        [self showToastError:phoneISULL];
        return;
    }
    if (![RegexUitl checkTelNumber:_phoneTextView.textField.text]) {
        [self showToastError:phoneWrong];
        return;
    }
    
    //验证码验证
    if (_verificationCodeView.textField.text.length <= 0) {
        [self showToastError:codeISNull];
        return;
    }
    
//    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * paramDictionary = @{
        @"params": @{@"tel":[KDSMallTool checkISNull:_phoneTextView.textField.text],       //绑定手机号
          @"code":[KDSMallTool checkISNull:_verificationCodeView.textField.text]  //获取的验证码
        },
        @"token":[KDSMallTool checkISNull:userToken]
    };
    
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSMineHttp bingPhoneNumberWithParams:paramDictionary success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            //修改本地f缓存
            QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
            userModel.tel = [KDSMallTool checkISNull:_phoneTextView.textField.text];
            [QZUserArchiveTool saveUserModelWithMode:userModel];
            
            NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
            NSDictionary * dictionary = @{
                                          @"params":@{},
                                          @"token":[KDSMallTool checkISNull:userToken]
                                          };
            //获取用户详情
            __weak typeof(self)weakSelf = self;
            [KDSMineHttp mineInfoWithParams:dictionary  success:^(BOOL isSuccess, id  _Nonnull obj) {
                
            } failure:^(NSError * _Nonnull error) {
                
            }];
            //推送
//            //移除所有tag
//            [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//                NSLog(@"删除tag");
//                QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
//                NSLog(@"tellll:%@",userModel.tel);
//                //如果有绑定手机号添加tag
//                if ([KDSMallTool checkISNull:userModel.tel].length > 0 ) {
//                    [JPUSHService addTags:[NSSet setWithObjects:[KDSMallTool checkISNull:userModel.tel], nil] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//                        NSLog(@"添加tag");
//                    } seq:0];
//                }
//            } seq:0];
            
            [KDSProgressHUD showTextOnly:@"手机号绑定成功" toView:weakSelf.view completion:^{
                if (weakSelf.coupon) {//判断是否从现金券进来
                    WebViewController * webView = [[WebViewController alloc]init];
                    webView.url = [NSString stringWithFormat:@"%@coupon?token=%@",webBaseUrl,[KDSMallTool checkISNull:userToken]];
        
                    webView.title = @"新人福利";
                    webView.rightButtonHidden = YES;
                    [self.navigationController pushViewController:webView animated:YES];
                
                    NSArray * vcArray = self.navigationController.viewControllers;
                    NSMutableArray * newVCArray = [NSMutableArray array];
                    for (UIViewController * vc in vcArray) {
                        if (![vc isKindOfClass:[KDSBindingPhoneNumController class]]) {
                            [newVCArray addObject:vc];
                        }
                    }

                    self.navigationController.viewControllers = newVCArray;
                }else{
                   [self backButtonClick];
                }
            }];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{
                
            }];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    }];
}


#pragma mark - 获取验证码 事件
-(void)getCodeButtonClick{
   
    if (_phoneTextView.textField.text.length <= 0) {
        [self showToastError:phoneISULL];
        return;
    }
    if (![RegexUitl checkTelNumber:_phoneTextView.textField.text]) {
        [self showToastError:phoneWrong];
        return;
    }
    
    //禁止button点击
    _getCodeButton.enabled = NO;
    _allSeconds = 60;
    //开始定时器
    self.timer.fireDate = [NSDate date];
    
    NSDictionary * dictionaryParam = @{@"params":
                                           @{
                                               @"tel":[KDSMallTool checkISNull:_phoneTextView.textField.text]  //用户手机号
                                           }
                                       };
    
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSMineHttp getCodeWithParams:dictionaryParam success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
    
    
}
-(void)showToastError:(NSString *)msg{
    [KDSProgressHUD showFailure:msg toView:self.view completion:^{
        
    }];
}
#pragma mark - 返回事件
-(void)backButtonClick{
    NSLog(@"viewControllers:%@",self.navigationController.viewControllers);
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}
#pragma mark - 停止计时器
-(void)stopTimer{
    //停止计时器 ，下次开启时间为未来
    _timer.fireDate =[NSDate distantFuture];
    _allSeconds = 0;
    [self countdownTimer];
}

#pragma mark - 定时器 调用方法
-(void)countdownTimer{
    if (_allSeconds == 0) {
        _allSeconds = 60;
        //停止计时器 ，下次开启时间为未来
        _timer.fireDate =[NSDate distantFuture];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeButton.enabled = YES;
//        [_getCodeButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#F36A5F"] forState:UIControlStateNormal];
//        _getCodeButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#F36A5F"].CGColor;
        [_getCodeButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#ca2128"] forState:UIControlStateNormal];
        _getCodeButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"].CGColor;
        _getCodeButton.layer.borderWidth = 0.8f;
    }else{
        [_getCodeButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#999999"] forState:UIControlStateNormal];
        _getCodeButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#999999"].CGColor;
        _getCodeButton.layer.borderWidth = 0.8f;
        [_getCodeButton setTitle:[NSString stringWithFormat:@"%lus重新获取",(unsigned long)_allSeconds] forState:UIControlStateNormal];
        _allSeconds --;
    }
}
#pragma mark - 定时器懒加载
-(NSTimer *)timer{
    if (_timer == nil) {
        _timer  =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _timer.fireDate = [NSDate distantFuture];
    }
    return _timer;
}
#pragma mark -  解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self.timer  invalidate];
        self.timer = nil;
    }
}
@end
