//
//  QZPWDTextfildview.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZPWDTextfildview.h"
#import "UITextField+Length.h"

@interface QZPWDTextfildview ()
@property (nonatomic,strong)UIButton     *  pwdEyeButton;
@property (nonatomic,strong) UITextField * textField;
@end

@implementation QZPWDTextfildview
-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder{
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _openPassword = NO;
        //title控件
        UILabel * titleLabel = [KDSMallTool createLabelString:title textColorString:@"#212121" font:15];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(textFieldWidth, 30));
        }];
      
        
        //密码显示隐藏button
        _pwdEyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pwdEyeButton addTarget:self action:@selector(pwdEyeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _pwdEyeButton.selected = NO;
        [_pwdEyeButton setImage:[UIImage imageNamed:@"icon_hide_login"] forState:UIControlStateNormal];
        [_pwdEyeButton setImage:[UIImage imageNamed:@"icon_display_login"] forState:UIControlStateSelected];
        [self addSubview:_pwdEyeButton];
        [_pwdEyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right);
            make.size.mas_equalTo(CGSizeMake(40, 40 * 38 / 26));
        }];
        
        //输入框控件
        _textField = [[UITextField alloc]init];
        _textField.placeholder = placeholder;
        _textField.secureTextEntry = YES;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor hx_colorWithHexRGBAString:@"#212121"];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).mas_offset(15);
            make.right.mas_equalTo(self.pwdEyeButton.mas_left).mas_offset(-10);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
        }];
    }
    return self;
}

-(void)setMaxCharacters:(NSInteger)maxCharacters{
    _maxCharacters = maxCharacters;
    [_textField setMaxLen:_maxCharacters];
}

- (NSString *)text{
    if ([KDSMallTool checkISNull:_textField.text].length > 0) {
        return _textField.text;
    }else{
        return @"";
    }
}
-(void)setOpenPassword:(BOOL)openPassword{
    _openPassword = openPassword;
    _textField.secureTextEntry = !openPassword;
    _pwdEyeButton.selected = openPassword;
    
    //密文明文更换时候的光标偏移
    NSString *text = _textField.text;
    _textField.text = @" ";
    _textField.text = text;
}

-(void)pwdEyeButtonClick:(UIButton *)button{
    _textField.secureTextEntry = button.selected;
    button.selected = !button.selected;
    
    //密文明文更换时候的光标偏移
    NSString *text = _textField.text;
    _textField.text = @" ";
    _textField.text = text;
}

//
-(void)drawRect:(CGRect)rect{
    
    [[UIColor hx_colorWithHexRGBAString:@"#ECECEC"] set];
    //第一条分割线
    CGFloat lineHeight = 1.0f;
    UIBezierPath * dividingPath = [UIBezierPath bezierPath];
    [dividingPath moveToPoint:CGPointMake(0, rect.size.height - lineHeight)];
    [dividingPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - lineHeight)];
    dividingPath.lineWidth = lineHeight;
    [dividingPath stroke];
    
}

@end
