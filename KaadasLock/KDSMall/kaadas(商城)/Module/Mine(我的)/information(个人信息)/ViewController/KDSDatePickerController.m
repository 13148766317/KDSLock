//
//  KDSDatePickerController.m
//  kaadas
//
//  Created by hjy on 2018/7/13.
//  Copyright © 2018年 kaadas. All rights reserved.
//

#import "KDSDatePickerController.h"
//必须声明  如果使用局部变量 window会过早释放
static UIWindow *__datePickerWindow = nil;

#define datePickerBGViewHeight  [UIScreen mainScreen].bounds.size.height * 0.4

@interface KDSDatePickerController ()
@property (nonatomic,strong)UIView            *  datePickerBgView;
@property (nonatomic,strong)UIDatePicker      *  datePicer;

@property (nonatomic,copy)NSString            * selectDateString;
@end

@implementation KDSDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置view的背景颜色为透明
    self.view.backgroundColor = [UIColor clearColor];
    
    //创建底部半透明的view
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.4;
    backgroundView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:backgroundView];
    
    
    //半透明view添加点击手势
    UITapGestureRecognizer * backgroundViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundViewTap)];
    [backgroundView addGestureRecognizer:backgroundViewTap];
    _datePickerBgView = [[UIView alloc]init];
//    _datePickerBgView.layer.cornerRadius = 10;
//    _datePickerBgView.layer.masksToBounds = YES;
    _datePickerBgView.backgroundColor = [UIColor whiteColor];
    _datePickerBgView.frame = CGRectMake(0, KSCREENHEIGHT ,KSCREENWIDTH , datePickerBGViewHeight);
    [self.view addSubview:_datePickerBgView];
    
    
    //关闭
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [closeButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"333333"] forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(10, 5, 40, 40);
    [closeButton addTarget:self action:@selector(closeButton) forControlEvents:UIControlEventTouchUpInside];
    [_datePickerBgView addSubview:closeButton];
    
    //确定
    UIButton * OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [OKButton setTitle:@"确定" forState:UIControlStateNormal];
    OKButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [OKButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"333333"] forState:UIControlStateNormal];

    OKButton.frame = CGRectMake(KSCREENWIDTH - 50 - 5, 5, 40, 40);
//    closeButton.backgroundColor = [UIColor redColor];
    [OKButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_datePickerBgView addSubview:OKButton];

    
    UILabel * birthdayTitle = [KDSMallTool createLabelString:@"生日" textColorString:@"333333" font:16];
    birthdayTitle.textAlignment = NSTextAlignmentCenter;
    [_datePickerBgView addSubview:birthdayTitle];
    birthdayTitle.frame = CGRectMake((CGRectGetWidth(_datePickerBgView.frame) - 100) / 2, 5, 100, 40);
    

//    //日历
    _datePicer = [[UIDatePicker alloc]init];
//    _datePicer.backgroundColor = [UIColor purpleColor];
    _datePicer.frame = CGRectMake(0, CGRectGetMaxY(closeButton.frame), CGRectGetWidth(self.datePickerBgView.frame), ( CGRectGetHeight(self.datePickerBgView.frame) - (isIPHONE_X ? 34 : 0)) - 50);
    _datePicer.datePickerMode = UIDatePickerModeDate;
    _datePicer.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [_datePicer addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [_datePickerBgView addSubview:_datePicer];
//    NSLog(@"_datePicer.frame:%@",NSStringFromCGRect(_datePicer.frame));
    
    
//    //确定按钮
//    UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    okButton.layer.cornerRadius = 6;
//    okButton.layer.masksToBounds = YES;
//    [okButton setTitle:@"确定" forState:UIControlStateNormal];
//    okButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"678bf0"];
//    okButton.frame = CGRectMake((KSCREENWIDTH - 120)/2, CGRectGetHeight(_datePickerBgView.frame) - 60, 120, 40);
//    [okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [_datePickerBgView addSubview:okButton];
}

-(void)show{
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor =[UIColor clearColor];
    //设置window的优先级
    window.windowLevel = UIWindowLevelAlert;
    window.hidden = NO;
    
    //设置window的主控制器
    window.rootViewController = self;
    __datePickerWindow = window;
    
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        self.datePickerBgView.frame = CGRectMake(0, KSCREENHEIGHT - datePickerBGViewHeight, KSCREENWIDTH,datePickerBGViewHeight);
    } completion:^(BOOL finished) {
        
    }];
}


-(void)dateChange:(UIDatePicker *)datePicker{
    NSString * dateString =  [self stringForDate:datePicker];
    _selectDateString = dateString;
}

#pragma mark - 背景点击事件
-(void)backgroundViewTap{
    [self closeWindow];
}
#pragma mark - 关闭button
-(void)closeButton{
    [self closeWindow];
}

#pragma mark - 完成  button 点击事件
-(void)okButtonClick{
    
    if (_selectDateString.length <= 0) {
        _selectDateString = [self stringForDate:self.datePicer];
    }
     NSLog(@"%@",_selectDateString);
    if (self.datePickerBlock) {
        self.datePickerBlock(_selectDateString);
    }
    [self closeWindow];
}

#pragma mark - 日期转字符串
-(NSString *)stringForDate:(UIDatePicker *)datePicker{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.dateFormat = @"MM-dd";
    return [formatter stringFromDate:datePicker.date];
}

#pragma mark -  关闭window
-(void)closeWindow{
    [UIView animateWithDuration:0.25 animations:^{
        self.datePickerBgView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, datePickerBGViewHeight);
    } completion:^(BOOL finished) {
        //先隐藏window  然后设置为nil
        __datePickerWindow.hidden = YES;
        __datePickerWindow = nil;
    }];
}

@end
