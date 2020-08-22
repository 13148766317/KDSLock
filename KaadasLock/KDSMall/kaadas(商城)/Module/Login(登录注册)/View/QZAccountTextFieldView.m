//
//  QZAccountTextFieldView.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/13.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZAccountTextFieldView.h"

@interface QZAccountTextFieldView ()

@end

@implementation QZAccountTextFieldView
@synthesize text = _text;

-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder{
    if (self = [super init]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        
        UILabel * titleLabel = [KDSMallTool createLabelString:title textColorString:@"#212121" font:15];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(textFieldWidth, 30));
        }];
        
        
        _textField = [[UITextField alloc]init];
        
        _textField.placeholder = placeholder;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor hx_colorWithHexRGBAString:@"#212121"];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).mas_offset(15);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
        }];
       
    }
    return self;
}

-(void)setKeyBoardType:(UIKeyboardType)keyBoardType{
    _keyBoardType = keyBoardType;
    _textField.keyboardType =  _keyBoardType;
}

-(void)responder{
    [_textField becomeFirstResponder];
}

#pragma mark -  getter方法
-(NSString *)text{
    if (_textField.text.length > 0) {
        return _textField.text;
    }else{
      return  @"";
    }
}
#pragma mark - setter
-(void)setText:(NSString *)text{
    _text = text;
    _textField.text = _text;
}


-(void)setMaxCharacters:(NSInteger)maxCharacters{
    _maxCharacters = maxCharacters;
    [_textField setMaxLen:_maxCharacters];
}

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
