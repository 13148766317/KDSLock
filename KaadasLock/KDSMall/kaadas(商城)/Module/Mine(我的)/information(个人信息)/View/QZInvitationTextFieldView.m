//
//  QZInvitationTextFieldView.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/23.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZInvitationTextFieldView.h"

@interface QZInvitationTextFieldView ()<UITextFieldDelegate>
@property (nonatomic,strong)UILabel                * titleLabel;

@property (nonatomic,assign)QZDividingLinePosition    position;
@end

@implementation QZInvitationTextFieldView

@synthesize text = _text;

-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder linePositon:(QZDividingLinePosition)position{
    _position = position;
    if (self = [super init]) {
        
        _edit = YES;
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FCFCFC"];
        
        _titleLabel = [KDSMallTool createLabelString:title textColorString:@"#212121" font:15];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(textFieldWidth, 30));
        }];
        
        
        _textField = [[UITextField alloc]init];
        _textField.placeholder = placeholder;
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor hx_colorWithHexRGBAString:@"#212121"];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(15);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
        }];
        
    }
    return self;
}

-(void)setText:(NSString *)text{
    _text = text;
    _textField.text = _text;
}
-(NSString *)text{
    return _textField.text;
}
//文本颜色
-(void)setTextColor:(NSString *)textColor{
    _textColor = textColor;
    _textField.textColor = [UIColor hx_colorWithHexRGBAString:_textColor];
}

//文本大小
-(void)setFont:(CGFloat)font{
    _font = font;
    _textField.font = [UIFont systemFontOfSize:_font];
}

//title颜色
-(void)setTitleColor:(NSString *)titleColor{
    _titleColor = titleColor;
    _titleLabel.textColor = [UIColor hx_colorWithHexRGBAString:_titleColor];
}

//是否禁止输入文本
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return _edit;
}




#pragma mark - 画分割线
-(void)drawRect:(CGRect)rect{
    
    [[UIColor hx_colorWithHexRGBAString:@"#ECECEC"] set];
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    switch (_position) {
        case QZDividingLine_NO:{
            
        }
            break;
        case QZDividingLine_TOP:{
            //上
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(rect.size.width, 0)];
            path.lineWidth = 1;
            [path stroke];
        }
            break;
        case QZDividingLine_BOTTOM:{
            //下
            [path moveToPoint:CGPointMake(0, rect.size.height - 0.7)];
            [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - 0.7)];
            path.lineWidth = 0.7;
            [path stroke];
        }
            break;
        case QZDividingLine_ALL:{
            //上
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(rect.size.width, 0)];
            path.lineWidth = 1;
            [path stroke];
            //下
            [path moveToPoint:CGPointMake(0, rect.size.height - 0.7)];
            [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - 0.7)];
            path.lineWidth = 0.7;
            [path stroke];
        }
            break;
            
        default:
            break;
    }
    
   
    
   
}

@end
