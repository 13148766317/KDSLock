//
//  KDSActivateView.m
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "KDSActivateView.h"

@interface KDSActivateView ()
@property(nonatomic,strong)UITextField * textField;

@end


@implementation KDSActivateView
@synthesize text = _text;

-(void)activationButtonClick{
    if ([_delegate respondsToSelector:@selector(activateViewActivationButtonClick:)]) {
        [_delegate activateViewActivationButtonClick:_textField.text];
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIButton * activateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        activateButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
        activateButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [activateButton setTitle:@"激活优惠券" forState:UIControlStateNormal];
        [activateButton addTarget:self action:@selector(activationButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:activateButton];
        [activateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 35));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];


        UIView * textFieldBG = [[UIView alloc]init];
        textFieldBG.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"333333"].CGColor;
        textFieldBG.layer.borderWidth = 1;
        [self addSubview:textFieldBG];
        [textFieldBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(activateButton.mas_left);
            make.height.mas_equalTo(activateButton.mas_height);
        }];
        
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"请输入激活码";
        [textFieldBG addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.right.mas_equalTo(textFieldBG);
        }];
        
    }
    return self;
}


-(NSString *)text{
    return _textField.text;
}


-(void)setText:(NSString *)text{
    _text = text;
    _textField.text = _text;
}
@end
