//
//  KDSSearchNavigation.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSearchNavigation.h"

@interface KDSSearchNavigation ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField   * textField;
@end

@implementation KDSSearchNavigation
@synthesize text = _text;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        
    
        UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
        searchButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        [self addSubview:searchButton];
        [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(50, 30));
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
        //搜索图片
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [self addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(searchButton.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(40, 30));
        }];
        
        //
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.placeholder = @"搜索产品";
        _textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySearch;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backButton.mas_right).mas_offset(10);
            make.right.mas_equalTo(searchButton.mas_left).mas_offset(-10);
            make.centerY.mas_equalTo(self.backButton.mas_centerY);
            make.height.mas_equalTo(30);
        }];
        
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        //分割线
        UIView * dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
//        dividingView.alpha = 0.1;
        [self addSubview:dividingView];
        [dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textField.mas_left);
            make.right.mas_equalTo(self.textField.mas_right);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(self.textField.mas_bottom).mas_offset(0);
        }];

    }
    return self;
}

//输入内容改变
-(void)textFieldDidChange:(id)sender{
    if ([_delegate respondsToSelector:@selector(textFieldChange:)]) {
        [_delegate textFieldChange:_textField.text];
    }
}

//键盘的返回事件
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldReturn:)]) {
        [_delegate textFieldReturn:textField.text];
    }
    return YES;
}

//清除输入内容
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(searchTextFieldShouldClear)]) {
        [_delegate searchTextFieldShouldClear];
    }
    return YES;
}

#pragma mark - 搜索事件
-(void)searchButtonClick{
    if ([_delegate respondsToSelector:@selector(searchNavigationSearchClick:)]) {
        [_delegate searchNavigationSearchClick:_textField.text];
    }
}

#pragma mark - getter
-(NSString *)text{
    return _textField.text;
}

#pragma mark - setter
-(void)setText:(NSString *)text{
    _text  = text;
    _textField.text = text;
}

@end
