//
//  KDSPWDTextView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSPWDTextView.h"

@interface KDSPWDTextView ()

@end

@implementation KDSPWDTextView
@synthesize text = _text;


-(void)setText:(NSString *)text{
    _text = text;
    _textField.text = _text;
}

-(NSString *)text{
    return [KDSMallTool checkISNull:_textField.text];
}

-(instancetype)initWithTitle:(NSString *)title palceHolder:(NSString *)placeHolder{
    if (self = [super init]) {
        
        UILabel * titleLb = [KDSMallTool createLabelString:title textColorString:@"#333333" font:15];
        [self addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(70);
        }];
        
        //竖直分割线
        UIView * verticalView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self addSubview:verticalView];
        [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLb.mas_right).mas_offset(5);
            make.width.mas_equalTo(dividinghHeight);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(15);
        }];
        
        //输入框
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.placeholder = placeHolder;
        _textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(verticalView.mas_right).mas_offset(20);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(35);
            make.right.mas_equalTo(-15);
        }];
        
        //底部分割线
        UIView * dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self addSubview:dividingView];
        [dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
    }
    
    return self;
}

@end
