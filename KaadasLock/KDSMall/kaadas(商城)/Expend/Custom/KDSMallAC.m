//
//  QZAlertController.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/20.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "KDSMallAC.h"

//
static UIWindow  * __alertwindow = nil;
static KDSMallAC * _alertVC = nil;

@interface KDSMallAC ()
//创建底部半透明的view
@property (nonatomic,strong)UIView            *  backgroundView;
//提示框的背景
@property (nonatomic,strong)UIView            *  alertBG;
//提醒title
@property (nonatomic,strong)UILabel           * titleLB;
//提醒title文字
@property (nonatomic,copy)NSString            * titleString;
//提醒内容
@property (nonatomic,strong)UILabel           * msgLabel;
//提醒内容文字
@property (nonatomic,copy)NSString            * msgString;
//取消button
@property (nonatomic,strong)UIButton          * cancelButton;
//取消button title
@property (nonatomic,copy)NSString            * cancelTitle;
//确认button
@property (nonatomic,strong)UIButton          * OKButton;
//确认button title
@property (nonatomic,copy)NSString            * okTitle;
//取消确认顶部分割线
@property (nonatomic,strong)UIView           * buttonTopDividing;

//取消确认分割线
@property (nonatomic,strong)UIView            * dividingView;
//取消block
@property (nonatomic,copy)CancelButtonAlertBlock    cancelBlock;
//确定block
@property (nonatomic,copy)OKButtonAlertBlock        okBlock;

@end

@implementation KDSMallAC

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化数据
    [self initData];
    //创建UI
    [self createUI];
}

#pragma mark - 初始化数据
-(void)initData{
    _titleColor  = @"#212121";
    _titleFont   = 17.0f;
    _msgColor    = @"#9E9E9E";
    _msgFont     = 14.0f;
}

-(void)backgroundViewTap{
    NSLog(@"%s",__func__);
    //     [self clseaAlert];
}

#pragma mark - 取消点击事件
-(void)cancelButtonClick{
    NSLog(@"%s",__func__);
    [self clseaAlert];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
   
}

#pragma mark - 确定点击事件
-(void)OKButtonclick{
    NSLog(@"%s",__func__);
    [self clseaAlert];
    if (self.okBlock) {
        self.okBlock();
    }
}

-(void)clseaAlert{
    __alertwindow.hidden = YES;
    __alertwindow = nil;
    _alertVC = nil;
}

-(void)setTitleFont:(CGFloat)titleFont{
    _titleFont  = titleFont;
    _titleLB.font = [UIFont boldSystemFontOfSize:_titleFont];
}

-(void)setTitleColor:(NSString *)titleColor{
    _titleColor = titleColor;
    _titleLB.textColor = [UIColor hx_colorWithHexRGBAString:_titleColor];
}
-(void)setMsgColor:(NSString *)msgColor{
    _msgColor = msgColor;
    _msgLabel.textColor = [UIColor hx_colorWithHexRGBAString:msgColor];
}

-(void)setMsgFont:(CGFloat)msgFont{
    _msgFont = msgFont;
    _msgLabel.font = [UIFont boldSystemFontOfSize:_msgFont];
}

-(void)dealloc{
    NSLog(@"弹框销毁");
}

+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message  okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle  OKBlock:(OKButtonAlertBlock)okBlock cancelBlock:(CancelButtonAlertBlock)cancel{
    
    _alertVC = [[KDSMallAC alloc]init];
    _alertVC.okBlock = okBlock;
    _alertVC.cancelBlock = cancel;
    _alertVC.titleString = title;
    _alertVC.msgString = message;
    _alertVC.okTitle= okTitle;
    _alertVC.cancelTitle = cancelTitle;
    
    //创建UIWindow
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    //设置window的主控制器
    window.rootViewController = _alertVC;
    __alertwindow = window;
    
    return _alertVC;
}

#pragma mark - 在控制器的视图已经出现时设置控制器子控件的frame
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //提示框的背景
    CGFloat alertBGX = 40.0f;
    CGFloat alertBGW = KSCREENWIDTH - 2 * alertBGX;
    _alertBG.frame = CGRectMake(alertBGX, 0, alertBGW, 0);

    //提醒title
    CGFloat titlex = 0;
    CGFloat titleY = 15;
    CGFloat titleW = CGRectGetWidth(_alertBG.frame);
    CGFloat titleH = [KDSMallTool getNSStringHeight:[KDSMallTool checkISNull:_titleString] textMaxWith:titleW font:_titleFont];
    //判断_titleString 是否为空
    if ([KDSMallTool checkISNull:_titleString].length <= 0) {//title为空
        titleH = 0;
        _titleLB.frame = CGRectMake(titlex, titleY, titleW, titleH);
    }else{//title不为空
        //提醒title
         titleY = 15;
        _titleLB.frame = CGRectMake(titlex, titleY, titleW, titleH);
       
    }
    //提醒内容
    CGFloat msgX = 10;
    CGFloat msgY = CGRectGetMaxY(_titleLB.frame) + 10;
    CGFloat msgW = CGRectGetWidth(_alertBG.frame) - 2 * msgX;
    CGFloat msgH = [KDSMallTool getNSStringHeight:_msgString textMaxWith:msgW font:_msgFont];
    _msgLabel.frame = CGRectMake(msgX, msgY, msgW, msgH);
    
    //取消button
    CGFloat cacelButtonX = 0;
    CGFloat cacelButtonY = CGRectGetMaxY(_msgLabel.frame) + 25.0f;
    CGFloat cacelButtonW = CGRectGetWidth(_alertBG.frame)/2.0;
    CGFloat cacelButtonH = 50;
    _cancelButton.frame = CGRectMake(cacelButtonX, cacelButtonY, cacelButtonW, cacelButtonH);
   
    //确认button
     CGFloat okbuttonX = CGRectGetMaxX(_cancelButton.frame);
     CGFloat okbuttonY = CGRectGetMinY(_cancelButton.frame);
     CGFloat okbuttonW = CGRectGetWidth(_cancelButton.frame);
     CGFloat okbuttonH = CGRectGetHeight(_cancelButton.frame);
    _OKButton.frame = CGRectMake(okbuttonX, okbuttonY, okbuttonW, okbuttonH);
    
    //取消确认顶部分割线
    _buttonTopDividing.frame = CGRectMake(0, CGRectGetMinY(_cancelButton.frame) - 1, alertBGW, 1);
    
    
     //取消确认分割线
    CGFloat dividingW = 1.0f;
    CGFloat dividingX = CGRectGetWidth(_cancelButton.frame) - dividingW / 2;
    CGFloat dividingH =  CGRectGetHeight(_cancelButton.frame);//CGRectGetHeight(_cancelButton.frame) * 0.5;
    CGFloat dividingY = cacelButtonY;//cacelButtonY  +  (okbuttonH - dividingH) / 2.0f;
    _dividingView.frame = CGRectMake(dividingX, dividingY, dividingW, dividingH);
    
    //重新设置背景frame
    CGFloat alertBGH =  CGRectGetMaxY(_cancelButton.frame);//背景高度
    CGFloat alertY   =  (KSCREENHEIGHT - alertBGH ) / 2.0 - 30;
    _alertBG.frame = CGRectMake(alertBGX, alertY,alertBGW, alertBGH);
}

#pragma mark - 创建UI
-(void)createUI{
    //设置view背景颜色为透明
    self.view.backgroundColor = [UIColor clearColor];

    //创建底部半透明的view
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    _backgroundView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_backgroundView];
    
    //半透明view添加点击手势
    UITapGestureRecognizer * backgroundViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundViewTap)];
    [_backgroundView addGestureRecognizer:backgroundViewTap];
    
    //提示框的背景
    _alertBG = [[UIView alloc]init];
    _alertBG.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
//    _alertBG.layer.cornerRadius = 10;
//    _alertBG.layer.masksToBounds = YES;
    [self.view addSubview:_alertBG];
  
    //提醒title
    _titleLB = [KDSMallTool createLabelString:@"" textColorString:@"#212121" font:_titleFont];
    _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.text = _titleString;
    [_alertBG addSubview:_titleLB];
  
    //提醒内容
    _msgLabel = [KDSMallTool createLabelString:@"" textColorString:@"#9E9E9E" font:_msgFont];
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    _msgLabel.numberOfLines = 0;
    _msgLabel.text = _msgString;
    [_alertBG addSubview:_msgLabel];
   
    //取消button
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:_cancelTitle forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_alertBG addSubview:_cancelButton];
   
    //确认button
    _OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_OKButton setTitle:_okTitle forState:UIControlStateNormal];
    [_OKButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#CA2128"] forState:UIControlStateNormal];
    _OKButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
    [_OKButton addTarget:self action:@selector(OKButtonclick) forControlEvents:UIControlEventTouchUpInside];
    _OKButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_alertBG addSubview:_OKButton];
    
    
    //取消确认顶部分割线
    _buttonTopDividing = [KDSMallTool createDividingLineWithColorstring:@"#ECECEC"];
    [_alertBG addSubview:_buttonTopDividing];
    
    //取消确认分割线
    _dividingView = [KDSMallTool createDividingLineWithColorstring:@"#ECECEC"];
    [_alertBG addSubview:_dividingView];
   
}

//#pragma mark - 控制屏幕旋转方法
//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate{
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end
