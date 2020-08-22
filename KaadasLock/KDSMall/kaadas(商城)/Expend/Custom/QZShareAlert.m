//
//  QZShareAlert.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/25.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZShareAlert.h"

static UIWindow     * __shareWindow = nil;
static QZShareAlert * __shareAlert  = nil;

@interface QZShareAlert ()
//创建底部半透明的view
@property (nonatomic,strong)UIView            *  backgroundView;
//提示框的背景
@property (nonatomic,strong)UIView            *  alertBG;
//button数组
@property (nonatomic,strong)NSMutableArray    *  buttonArray;
@property (nonatomic,strong)UILabel           * shareTitle;
@property (nonatomic,strong)UILabel           * detailLabel;

@property (nonatomic,copy)QZShareButtonClickBlock   shareButtonClickBlock;
@property (nonatomic,assign)QZShareAlertType    alertType;
@property (nonatomic,strong) UIView           * circleView;
//取消button
@property (nonatomic,strong)UIButton          * cancelButton;
@end

@implementation QZShareAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}
#pragma mark - 半透明view点击事件
-(void)backgroundViewTap{
    [self closeShareAlert];
}

#pragma mark - 分享button点击事件
-(void)buttonClick:(UIButton *)button{
    QZShareButtonType  type = -1;
    switch (button.tag) {
        case 0:{
            type = QZShareButton_wechatFriend;//微信好友
        }
            break;
        case 1:{
            type = QZShareButton_Wechatmoments;//朋友圈
        }
            break;
        case 2:{
            type = QZShareButton_QQFriend;//QQ好友
        }
            break;
        case 3:{
            type = QZShareButton_QZone;//QQ空间
        }
            break;
        case 4:{
            type = QZShareButton_weibo;//微博
        }
            break;
        case 5:{
            if (_alertType == QZShareAlertType_AudioaAndVideo) {
                type = QZShareButton_copyUrl;//复制链接
            }else if(_alertType == QZShareAlertType_Invitation){
                type = QZShareButton_downImage;//下载图片
            }
            
        }
            break;
            
            
        default:
            break;
    }
    
    if (self.shareButtonClickBlock) {
        self.shareButtonClickBlock(type);
    }
    [self closeShareAlert];
}

#pragma mark - 取消事件
-(void)cancelButtonClick{
    [self closeShareAlert];
}
#pragma mark - 关闭窗口
-(void)closeShareAlert{
    __weak typeof(self)weakSelf = self;
    
    CGFloat alertBGX  =  0;
    CGFloat alertBGY = KSCREENHEIGHT;
    CGFloat alertBGW = KSCREENWIDTH;
    CGFloat alertBGH = CGRectGetHeight(_alertBG.frame);
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alertBG.frame = CGRectMake(alertBGX, alertBGY, alertBGW, alertBGH);
    } completion:^(BOOL finished) {
        __shareWindow.hidden = YES;
        __shareWindow = nil;
        __shareAlert = nil;
    }];
}
+(void)shareAlertWithType:(QZShareAlertType)alertType ButtonClick:(QZShareButtonClickBlock)shareButtonClickBlock{
    __shareAlert = [[QZShareAlert alloc]init];
    __shareAlert.shareButtonClickBlock = shareButtonClickBlock;
    __shareAlert.alertType = alertType;
    
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    window.rootViewController = __shareAlert;
    __shareWindow = window;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSArray * buttonTitleArray = nil;
    
    NSString * titleString = @"";
    CGFloat titleFont = 12.0f;
    switch (_alertType) {
        case QZShareAlertType_AudioaAndVideo:{//音视频分享
            titleString = @"分享有礼\n成功邀请一位好友开通VIP，即可领取100元现金奖励";
            buttonTitleArray = @[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"微博",@"复制链接"];
            titleFont = 12.0f;
        }
            
            break;
        case QZShareAlertType_Invitation:{   //邀请专区分享
            titleString = @"分享至";
            buttonTitleArray = @[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"微博",@"下载图片"];
            titleFont = 15.0f;
        }
            break;
        case QZShareAlertType_Ambassador:{   //邀请专区分享
            titleString = @"转发到";
            buttonTitleArray = @[@"微信好友",@"朋友圈"];
            titleFont = 15.0f;
        }
            break;
        default:
            break;
    }

    //设置frame
    //提示框的背景
    CGFloat alertBGX  =  0;
    CGFloat alertBGY  =  KSCREENHEIGHT;
    CGFloat alertBGW  =  KSCREENWIDTH;
    CGFloat alertBGH  =  0;
    _alertBG.frame = CGRectMake(alertBGX, alertBGY, alertBGW,alertBGH);
    
    //titleFrame
    CGFloat shareTitleX = 40.0f;
    CGFloat shareTitleY = 14.0;
    CGFloat shareTitleW = KSCREENWIDTH - 2 * shareTitleX;
    CGFloat shareTitleH = [KDSMallTool getNSStringHeight:titleString textMaxWith:shareTitleW font:titleFont lineSpacing:10];
    NSRange moneyRange = [titleString rangeOfString:@"100元"];
    _shareTitle.attributedText = [KDSMallTool attributedString:titleString dict:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"#F36A5F"]} range:moneyRange lineSpacing:10];
    _shareTitle.textAlignment = NSTextAlignmentCenter;
    _shareTitle.font = [UIFont systemFontOfSize:titleFont];
    _shareTitle.frame = CGRectMake(shareTitleX, shareTitleY, shareTitleW, shareTitleH);
    
    //button
    //总列数
    NSInteger totalColumn = 4;
    CGFloat buttonMargin = 1;
    CGFloat buttonWith = (KSCREENWIDTH - (totalColumn - 1) * buttonMargin) / totalColumn;
    CGFloat buttonHeight = buttonWith + 3;
    CGFloat buttonY     = CGRectGetMaxY(_shareTitle.frame) + 10;
    for (int i = 0; i < _buttonArray.count; i++) {
        UIButton  * button = _buttonArray[i];
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:buttonTitleArray[i]] forState:UIControlStateNormal];
        //行
        int row = i / totalColumn;
        //列
        int column = i % totalColumn;
        [_alertBG addSubview:button];
        button.frame = CGRectMake(column *(buttonMargin + buttonWith),buttonY + row * (buttonMargin + buttonHeight), buttonWith, buttonHeight);
        //设置button的title image的位置
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width, -(button.imageView.frame.size.height + 10), 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(-(button.titleLabel.frame.size.height + 10), 0, 0, -button.titleLabel.frame.size.width);
    }
    
    
    //圆
    //取出最后一个button
    UIButton * lastButton = [_buttonArray lastObject];
    
    if (_alertType == QZShareAlertType_Invitation) {
        CGFloat circleW = 8.0f;
        _circleView.layer.cornerRadius = circleW / 2.0f;
        _circleView.layer.masksToBounds = YES;
        _circleView.frame = CGRectMake(10,CGRectGetMaxY(lastButton.frame) + 30 ,circleW,circleW);
        
        
        NSString * detailString = @"通过该图片二维码扫码注册的用户将和你绑定关系，成为你的下级学员。";
        CGFloat detailX = CGRectGetMaxX(self.circleView.frame) + 8.0f;
        CGFloat detailY = CGRectGetMinY(self.circleView.frame) - 5;
        CGFloat detailW = CGRectGetWidth(_alertBG.frame)  - detailX - 10;
        CGFloat detailH = [KDSMallTool getNSStringHeight:detailString textMaxWith:detailW font:12];
        _detailLabel.text = detailString;
        _detailLabel.frame = CGRectMake(detailX, detailY, detailW, detailH);
        _cancelButton.hidden = YES;
        //白色背景的高度
        alertBGH = CGRectGetMaxY(_detailLabel.frame)+ (isIPHONE_X ? 44 :10);
    }else if (_alertType == QZShareAlertType_AudioaAndVideo || _alertType == QZShareAlertType_Ambassador){
        _circleView.hidden = YES;
        _detailLabel.hidden = YES;
        
        CGFloat cancelX = 0;
        CGFloat cancelY = CGRectGetMaxY(lastButton.frame) + 40.0f;
        CGFloat cancelW = KSCREENWIDTH;
        CGFloat cancelH = 44.0f;
        _cancelButton.frame = CGRectMake(cancelX, cancelY, cancelW, cancelH);
        
        //白色背景的高度
        alertBGH = CGRectGetMaxY(_cancelButton.frame) + (isIPHONE_X ? 44 :10);
    }
    
    
    
//    //重新设置背景frame
    alertBGY = KSCREENHEIGHT ;
    
    _alertBG.frame = CGRectMake(alertBGX, alertBGY, alertBGW, alertBGH);
    
     alertBGY = KSCREENHEIGHT - CGRectGetHeight(_alertBG.frame);
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alertBG.frame = CGRectMake(alertBGX, alertBGY, alertBGW, alertBGH);
    }];
}
#pragma mark - 创建UI
-(void)createUI{
    
    _buttonArray = [NSMutableArray array];
    
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
    
    
    _alertBG = [[UIView alloc]init];
    _alertBG.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F8F8F8"];
    [self.view addSubview:_alertBG];
    
    
    //分享至title
    _shareTitle = [KDSMallTool createLabelString:@"" textColorString:@"#212121" font:12];
    _shareTitle.textAlignment = NSTextAlignmentCenter;
    _shareTitle.numberOfLines = 0;
    [_alertBG addSubview:_shareTitle];


    if (_alertType == QZShareAlertType_Ambassador) {
        for (NSInteger i = 0; i < 2; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#9E9E9E"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [_buttonArray addObject:button];
        }
    } else {
        for (int i = 0; i < 6; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#9E9E9E"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [_buttonArray addObject:button];
        }
    }
    
    //圆
    _circleView = [[UIView alloc] init];
    _circleView.backgroundColor = [UIColor colorWithRed:243/255.0 green:106/255.0 blue:95/255.0 alpha:1.0];
    [_alertBG addSubview:_circleView];
    
    _detailLabel = [KDSMallTool createLabelString:@"" textColorString:@"#F36A5F" font:12];
    _detailLabel.numberOfLines = 0;
    [_alertBG addSubview:_detailLabel];
    
    
    //取消button
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#212121"] forState:UIControlStateNormal];
    _cancelButton.backgroundColor = [UIColor whiteColor];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertBG addSubview:_cancelButton];
    
}

-(void)dealloc{
    NSLog(@"控制器销毁");
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
