//
//  QZLoginBottomView.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,QZLoginType) {
    login_VerificationCode, //验证码登录
    login_account           //账号登录
};

typedef NS_ENUM(NSInteger,QLLoginButtonType){
    button_verificationCodeType, //验证码登录
    button_accountLoginType,     //密码登录
    button_registerAccountType,  //注册账号
    button_forgetPasswordType    //忘记密码
};


@protocol QZLoginBottomViewDelegate <NSObject>

-(void)loginBottomViewButtonType:(QLLoginButtonType)buttonType;

@end

NS_ASSUME_NONNULL_BEGIN

@interface QZLoginBottomView : UIView
@property (nonatomic,weak)id <QZLoginBottomViewDelegate> delegate;
-(instancetype)initWithLoginType:(QZLoginType)logintype;
@end

NS_ASSUME_NONNULL_END
