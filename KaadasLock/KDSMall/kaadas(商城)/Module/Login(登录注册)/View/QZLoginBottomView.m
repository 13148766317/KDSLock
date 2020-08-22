//
//  QZLoginBottomView.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZLoginBottomView.h"

@interface QZLoginBottomView ()
@property (nonatomic,assign)QZLoginType  loginType;
@end

@implementation QZLoginBottomView

-(instancetype)initWithLoginType:(QZLoginType)logintype{
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _loginType = logintype;
        switch (logintype) {
            case login_account:{//账号登录
                [self createAccountUI];
            }
                break;
            case login_VerificationCode:{//验证码登录
                [self createVerificationCodeUI];
            }
                break;
                
            default:
                break;
        }
    }
    
    return self;
}
-(void)setLoginType:(QZLoginType)loginType{
    _loginType = loginType;
    [self setNeedsDisplay];
}

#pragma mark - 密码登录界面   button点击事件
-(void)accountButtonClick:(UIButton *)button{
    QLLoginButtonType  buttonType = -1;
    switch (button.tag) {
        case 0:{//验证码登录
            buttonType = button_verificationCodeType;
        }
            break;
        case 1:{//注册账号
            buttonType = button_registerAccountType;
        }
            break;
        case 2:{//忘记密码
            buttonType = button_forgetPasswordType;
        }
            break;
        default:
            break;
    }
    if ([_delegate respondsToSelector:@selector(loginBottomViewButtonType:)]) {
        [_delegate loginBottomViewButtonType:buttonType];
    }
}


#pragma mark - 验证码登录界面 button点击事件
-(void)verificationCodeButtonClick:(UIButton *)button{
    QLLoginButtonType  buttonType = -1;
    switch (button.tag) {
        case 0://密码登录
            buttonType = button_accountLoginType;
            break;
        case 1://注册账号
            buttonType = button_registerAccountType;
            break;
        default:
            break;
    }
    
    if ([_delegate respondsToSelector:@selector(loginBottomViewButtonType:)]) {
        [_delegate loginBottomViewButtonType:buttonType];
    }
}

#pragma mark - 创建账号登录UI
-(void)createAccountUI{
    //创建验证码登录，注册账号、忘记密码button
    NSArray * buttonTitleArr = @[@"验证码登录",@"注册账号",@"忘记密码"];
    CGFloat buttonWidth =  (KSCREENWIDTH - 2 * 27 - 2 * 2) / buttonTitleArr.count;
    for (int i = 0; i < buttonTitleArr.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#212121"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i;
        [button addTarget:self action:@selector(accountButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0).mas_offset(i *(buttonWidth));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(buttonWidth, 30));
        }];
    }
}

#pragma mark - 创建验证码登录UI
-(void)createVerificationCodeUI{
    
    //创建 密码登录、注册账号button
    NSArray * buttonTtileArr = @[@"密码登录",@"注册账号"];
    for (int i = 0; i < buttonTtileArr.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTtileArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#212121"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i;
        [button addTarget:self action:@selector(verificationCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            //密码登录 布局
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.mas_centerX).mas_offset(-20);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(80, 30));
            }];
        }else{
            //注册账号 布局
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_centerX).mas_offset(20);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(80, 30));
            }];
        }
    }
}

//绘制分割线
- (void)drawRect:(CGRect)rect{
    
    [[UIColor hx_colorWithHexRGBAString:@"#ECECEC"] set];
    
    //分割线
    CGFloat linewidth = 2.0f;
    CGFloat lineheight = 16.0f;
    UIBezierPath * dividingPath = [UIBezierPath bezierPath];
    dividingPath.lineWidth = linewidth;
    
    switch (_loginType) {
        case login_account:{//账号登录
            //第一个分割线
            [dividingPath moveToPoint:CGPointMake((rect.size.width - 2 *linewidth)/3, (rect.size.height - lineheight)/2)];
            [dividingPath addLineToPoint:CGPointMake((rect.size.width - 2 *linewidth)/3, (rect.size.height - lineheight)/2 + lineheight)];
            [dividingPath stroke];
            //第二个分割线
            [dividingPath moveToPoint:CGPointMake((rect.size.width - 2 *linewidth)/3 * 2, (rect.size.height - lineheight)/2)];
            [dividingPath addLineToPoint:CGPointMake((rect.size.width - 2 *linewidth)/3 * 2, (rect.size.height - lineheight)/2 + lineheight)];
            [dividingPath stroke];
        }
            
            break;
        case login_VerificationCode:{//验证码登录
            [dividingPath moveToPoint:CGPointMake((rect.size.width - linewidth)/2, (rect.size.height - lineheight)/2)];
            [dividingPath addLineToPoint:CGPointMake((rect.size.width - linewidth)/2, (rect.size.height - lineheight)/2 + lineheight)];
            [dividingPath stroke];
        }
            
            break;
        default:
            break;
    }
    
}

@end
