//
//  KDSNewPersonCouponsController.m
//  kaadas
//
//  Created by 中软云 on 2019/7/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSNewPersonCouponsController.h"

static KDSNewPersonCouponsController * __couponsVC = nil;
static UIWindow                      * __window    = nil;


@interface KDSNewPersonCouponsController ()
//创建底部半透明的view
@property (nonatomic,strong)UIView                    * backgroundView;
@property (nonatomic,strong)KDSCouponModel            * couponModel;
@property (nonatomic,copy)KDSCouponsGetButtonClick      getButtonClick;
@property (nonatomic,copy)KDSCouponsCancelButtonClick   cancelButtonClick;
@end

@implementation KDSNewPersonCouponsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self createUI];
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
    
    UIImage * image = [UIImage imageNamed:@"bg"];
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
//        imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    CGFloat imageViewX = 0;
    CGFloat imageViewW = KSCREENWIDTH - imageViewX * 2;
    CGFloat imageViewH = imageViewW * image.size.height / image.size.width ;
    CGFloat imageViewY = (KSCREENHEIGHT - imageViewH) / 2.0 - 50;
    imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    //新人专享券
    UILabel * conponsTitleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#CA2128" font:15];
    conponsTitleLb.font = [UIFont fontWithName:@"STHupo" size:15];
    conponsTitleLb.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:conponsTitleLb];
    
    NSString * conponsString = [NSString stringWithFormat:@"%@ 元新人专属礼包砸中你啦！",[KDSMallTool numberForString:[[KDSMallTool checkISNull:_couponModel.money] doubleValue] maximumFractionDigits:0]];
    NSMutableAttributedString * conponsAttribut = [[NSMutableAttributedString alloc]initWithString:conponsString];
    [conponsAttribut addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:21] range:NSMakeRange(0, [KDSMallTool checkISNull:_couponModel.money].length)];
    [conponsAttribut addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#CA2128"] range:NSMakeRange(0, [KDSMallTool checkISNull:_couponModel.money].length)];
    //设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 1;
    shadow.shadowColor = [UIColor colorWithRed:126/255.0 green:42/255.0 blue:19/255.0 alpha:0.21];
    shadow.shadowOffset = CGSizeMake(0,3);
    [conponsAttribut addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, conponsString.length)];
    [conponsAttribut addAttribute:NSBaselineOffsetAttributeName value:@(-3) range:NSMakeRange(0, [KDSMallTool checkISNull:_couponModel.money].length)];
    conponsTitleLb.attributedText = conponsAttribut;
    
    
    CGFloat  conponsTitleX  = 0;
    CGFloat  conponsTitleH  =  35;
    CGFloat  conponsTitleY  = CGRectGetHeight(imageView.frame) / 2 - conponsTitleH - 15;
    CGFloat  conponsTitleW  = CGRectGetWidth(imageView.frame) - 2 * conponsTitleX;
    conponsTitleLb.frame = CGRectMake(conponsTitleX, conponsTitleY, conponsTitleW, conponsTitleH);

//    conponsTitleLb.backgroundColor  = [UIColor purpleColor];
    
    UILabel * priceLabel = [KDSMallTool createLabelString:[KDSMallTool numberForString:[[KDSMallTool checkISNull:_couponModel.money] doubleValue] maximumFractionDigits:0] textColorString:@"#FFF0D0" font:24];
    [imageView addSubview:priceLabel];
    
    CGFloat pricelabelY = CGRectGetHeight(imageView.frame) / 2 + CGRectGetHeight(imageView.frame) / 7 - (isIphone5sBelow ? -10 : 0);
     CGFloat pricelabelX = CGRectGetWidth(imageView.frame)/2;
     CGFloat pricelabelW = 100;
     CGFloat pricelabelH = 40;
    priceLabel.frame = CGRectMake(pricelabelX, pricelabelY, pricelabelW, pricelabelH);
    
    
    //点击领取
    UIButton * clickGetButton = [UIButton buttonWithType:UIButtonTypeCustom];
//   [clickGetButton setImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [clickGetButton setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [imageView addSubview:clickGetButton];
    [clickGetButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#ffffff"] forState:UIControlStateNormal];
    clickGetButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [clickGetButton setTitle:@"点击领取" forState:UIControlStateNormal];
    [clickGetButton addTarget:self action:@selector(getCouponButtonClick) forControlEvents:UIControlEventTouchUpInside];
    CGFloat clickButtonH = 45;
    CGFloat clichButtonW = 200;
    CGFloat clickButtonY = CGRectGetHeight(imageView.frame) - clickButtonH;
    CGFloat clickButtonX = (CGRectGetWidth(imageView.frame) - clichButtonW) / 2;
    clickGetButton.frame = CGRectMake(clickButtonX, clickButtonY, clichButtonW, clickButtonH);
    
    
    //关闭
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];

    CGFloat closeButtonW = 40;
    CGFloat closeButtonH = 40;
    CGFloat closeButtonX = (CGRectGetWidth(imageView.frame) - closeButtonW)/2;
    CGFloat closeButtonY = CGRectGetMaxY(imageView.frame) + 50;
    closeButton.frame = CGRectMake(closeButtonX, closeButtonY, closeButtonW, closeButtonH);
}

#pragma mark - 领取点击事件
-(void)getCouponButtonClick{
    NSLog(@"领取");
    if (self.getButtonClick) {
        self.getButtonClick();
    }
    [self closeWindow];
}

#pragma mark - 关闭
-(void)closeButtonClick{
    if (self.cancelButtonClick) {
        self.cancelButtonClick();
    }
    [self closeWindow];
}


+(instancetype)showCouponsWithModel:(KDSCouponModel *)model getButtonClick:(KDSCouponsGetButtonClick)getButtonClick cancelButtonClick:(KDSCouponsGetButtonClick)canceClick{
    __couponsVC = [[KDSNewPersonCouponsController alloc]init];
    __couponsVC.couponModel = model;
    __couponsVC.getButtonClick = getButtonClick;
    __couponsVC.cancelButtonClick = canceClick;
    
    
    //创建UIWindow
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    //设置window的主控制器
    window.rootViewController = __couponsVC;
    __window = window;
    
    return __couponsVC;
}

#pragma mark - 关闭弹框
-(void)closeWindow{
    __couponsVC = nil;
    __window.hidden = YES;
    __window = nil;
    
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
