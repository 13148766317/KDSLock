//
//  QZCodeTextfieldView.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/13.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZCodeTextfieldView.h"



@interface QZCodeTextfieldView ()
//输入框
@property (nonatomic,strong)UITextField     * textField;

//获取验证码button
@property (nonatomic,strong)UIButton       *  getCodeBtton;
//倒计时的最大秒数
@property (nonatomic,assign)NSInteger         allSeconds;
//定时器
@property (nonatomic,strong)NSTimer          * timer;



@end

@implementation QZCodeTextfieldView

#pragma mark - 获取验证码 事件
-(void)getCodeButtonClick{
    //禁止button点击
    _getCodeBtton.enabled = NO;
    _allSeconds = 60;
    //开始定时器
    self.timer.fireDate = [NSDate date];
    if ([self.delegate respondsToSelector:@selector(getCodeClick)]) {
        [self.delegate getCodeClick];
    }
    
}

#pragma mark -  解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self.timer  invalidate];
         self.timer = nil;
    }
}
#pragma mark - setter
-(NSString *)text{
    if ([KDSMallTool checkISNull:_textField.text].length > 0) {
        return _textField.text;
    }else{
        return @"";
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
        [_getCodeBtton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtton.enabled = YES;
        [_getCodeBtton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#CA2128"] forState:UIControlStateNormal];
        _getCodeBtton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#CA2128"].CGColor;
//        _getCodeBtton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _getCodeBtton.layer.borderWidth = 0.8f;
    }else{
        [_getCodeBtton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#999999"] forState:UIControlStateNormal];
        _getCodeBtton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#999999"].CGColor;
        _getCodeBtton.layer.borderWidth = 0.8f;
//        _getCodeBtton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ECECEC"];
        [_getCodeBtton setTitle:[NSString stringWithFormat:@"%lus重新获取",(unsigned long)_allSeconds] forState:UIControlStateNormal];
        _allSeconds --;
    }
}
-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder{
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        //创建title
        UILabel * titleLabel = [KDSMallTool createLabelString:title textColorString:@"#212121" font:15];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(textFieldWidth, 30));
        }];

        //创建获取验证码button
        CGFloat buttonWidth = 90.0f;
        CGFloat buttonheight = 28;
        _getCodeBtton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeBtton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtton.layer.cornerRadius = buttonheight / 2;
        _getCodeBtton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_getCodeBtton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#CA2128"] forState:UIControlStateNormal];
        _getCodeBtton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#CA2128"].CGColor;
        _getCodeBtton.layer.borderWidth = 0.8f;
        _getCodeBtton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        [_getCodeBtton addTarget:self action:@selector(getCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_getCodeBtton];
        [_getCodeBtton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonheight));
        }];
        
        //输入框
        _textField = [[UITextField alloc]init];
        _textField.placeholder = placeholder;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor hx_colorWithHexRGBAString:@"#212121"];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).mas_offset(15);
            make.right.mas_equalTo(self.getCodeBtton.mas_left).mas_offset(0);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
        }];
        
    }
    return self;
    
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

#pragma mark - 划线
-(void)drawRect:(CGRect)rect{
    [[UIColor hx_colorWithHexRGBAString:@"#ECECEC"] set];
    //分割线
    CGFloat lineHeight = 1.0f;
    UIBezierPath * dividingPath = [UIBezierPath bezierPath];
    [dividingPath moveToPoint:CGPointMake(0, rect.size.height - lineHeight)];
    [dividingPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - lineHeight)];
    dividingPath.lineWidth = lineHeight;
    [dividingPath stroke];
}

-(void)dealloc{
    NSLog(@"view销毁");
}
@end
